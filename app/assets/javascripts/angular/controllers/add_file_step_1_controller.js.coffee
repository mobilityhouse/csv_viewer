@csvv.controller 'AddFileStep1Controller', [ '$scope', '$q', 'CookiesService', ($scope, $q, CookiesService)->

  FILE_PROPERTIES = ['column_separator', 'row_separator', 'string_separator', 'header_line', 'encoding', 'extension']
  EXTENSION_PROPERTIES = ['aws_access_key_id', 'aws_secret_access_key', 'aws_region']

  file_settings_cookies = new CookiesService(FILE_PROPERTIES)
  extension_settings_cookies = new CookiesService(EXTENSION_PROPERTIES)

  $scope.get_cookies_promise = ()->
    $q (resolve, reject)->
      resolve file_settings_cookies.load($scope, 'file_params')
      
  $scope.get_extension_cookies_promise = ()->
    $q (resolve, reject)->
      resolve extension_settings_cookies.load($scope, 'extension_params')
      
      
  angular.element(document).ready ()->
    $.fn.progress_bar.go(33)
    
    $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
      file_settings_cookies.save($scope, 'file_params')
      extension_settings_cookies.save($scope, 'extension_params')
]