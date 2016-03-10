@csvv.controller 'AddFileStep2Controller', ['$scope', '$state', 'CookiesService', ($scope, $state, CookiesService)->

  FILE_PROPERTIES = ['name', 'column_separator', 'row_separator', 'string_separator', 'header_line', 'encoding']
  
  SPINNER_OPTIONS = 
    scale: 2
    
  $scope.DROPZONE_OPTIONS =
    url: "/document", 
    createImageThumbnails: false, 
    acceptedFiles: '.csv', 
    previewTemplate: '<div id="preview-template" style="display: none;"></div>'
    
  $scope.FILE_UPLOADER_ID = 'file_uploader'
  
  cookies = new CookiesService(FILE_PROPERTIES)
  spinner = new Spinner(SPINNER_OPTIONS)
  
  $scope.spinner_start = ()->
    spinner.spin(document.getElementById('a-lv2'))
    
  $scope.spinner_stop = ()->
    spinner.stop()
    
  $scope.go_to_file_view = ()->
    console.log $scope.current_file_id
    console.log $scope.current_file_id?
    if $scope.current_file_id?
      $state.go 'root.view_file.step_2', {file_id: $scope.current_file_id}
    else
      bootbox.alert "Please upload file first"
      return true
  
  angular.element(document).ready ()->
    cookies.load($scope, 'file_params')
    $scope.file_params.type = 'CsvDocument'
    $.fn.progress_bar.go(66)
    _.defer ()->
      $scope.$apply()
        
    $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
      cookies.save($scope, 'file_params')
    
]