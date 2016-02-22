@csvv.controller 'AddFileStep2Controller', ['$scope', '$state', 'CookiesService', 'DropzoneService', ($scope, $state, CookiesService, DropzoneService)->

  FILE_PROPERTIES = ['name', 'column_separator', 'row_separator', 'string_separator', 'header_line', 'encoding']
  
  SPINNER_OPTIONS = 
    scale: 2
  
  cookies = new CookiesService(FILE_PROPERTIES)
  
  $scope.go_to_file_view = ()->
    $state.go 'view_file.step_2', {file_id: $scope.ng_dropzone.current_file_id()}
  
  set_dropzone = ()->
    _.defer ()->
      $scope.ng_dropzone = new DropzoneService
        type: 'CsvDocument', 
        dropzone_element_id: 'file_uploader_dz'
        spinner_element_id: 'dz_container'
        description_element_id: 'uploader-text'
        alert_element_id: 'file_uploader_dz_alert'
        file_params: $scope.file_params
        spinner_params: SPINNER_OPTIONS
  
  angular.element(document).ready ()->
    cookies.load($scope, 'file_params')
    set_dropzone()
    $.fn.progress_bar.go(66)
        
    $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
      cookies.save($scope, 'file_params')
    
]