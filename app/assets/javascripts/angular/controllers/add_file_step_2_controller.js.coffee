@csvv.controller 'AddFileStep2Controller', ['$scope', '$state', 'CookiesService', ($scope, $state, CookiesService)->

  FILE_PROPERTIES = ['name', 'column_separator', 'row_separator', 'string_separator', 'header_line', 'encoding', 'extension']
  EXTENSION_PROPERTIES = ['aws_access_key_id', 'aws_secret_access_key', 'aws_region', 'aws_bucket', 'aws_path']
  EXTENSIONS_WITH_POST_UPLOAD_STEP = ['S3']
  
  SPINNER_OPTIONS = 
    scale: 2
    
  $scope.DROPZONE_OPTIONS =
    url: "/document", 
    createImageThumbnails: false, 
    acceptedFiles: '.csv', 
    previewTemplate: '<div id="preview-template" style="display: none;"></div>'
    
  $scope.FILE_UPLOADER_ID = 'file_uploader'
  
  file_settings_cookies = new CookiesService(FILE_PROPERTIES)
  extension_settings_cookies = new CookiesService(EXTENSION_PROPERTIES)
  spinner = new Spinner(SPINNER_OPTIONS)
  
  $scope.spinner_start = ()->
    spinner.spin(document.getElementById('a-lv2'))
    
  $scope.spinner_stop = ()->
    spinner.stop()
    
  $scope.go_to_next_view = ()->
    if $scope.current_file_id?
      if _.include(EXTENSIONS_WITH_POST_UPLOAD_STEP, $scope.file_params.extension)
        $state.go 'root.add_file.step_3', {file_id: $scope.current_file_id, extension: $scope.file_params.extension}
      else
        $state.go 'root.view_file.step_2', {file_id: $scope.current_file_id}
    else
      bootbox.alert "Please upload file first"
      return true
  
  angular.element(document).ready ()->
    file_settings_cookies.load($scope, 'file_params')
    extension_settings_cookies.load($scope, 'extension_params')
    $scope.file_params.type = 'CsvDocument'
    $.fn.progress_bar.go(66)
    _.defer ()->
      $scope.$apply()
        
    $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
      file_settings_cookies.save($scope, 'file_params')
      extension_settings_cookies.save($scope, 'extension_params')
    
]