@csvv.controller 'AddFileStep2Controller', ['$scope', 'CookiesService', 'DropzoneService', ($scope, CookiesService, DropzoneService)->

  FILE_PROPERTIES = ['name', 'column_separator', 'row_separator', 'string_separator', 'header_line', 'encoding']
  
  cookies = new CookiesService(FILE_PROPERTIES)
  
  angular.element(document).ready ()->
    cookies.load($scope, 'file_params')
    _.defer ()->
      $scope.$apply()
      $scope.ng_dropzone = new DropzoneService
        type: 'CsvDocument', 
        dropzone_element_id: 'file_uploader_dz'
        alert_element_id: 'file_uploader_dz_alert'
        file_params: $scope.file_params
        
    $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
      cookies.save($scope, 'file_params')
    
]