@csvv.controller 'AddFileStep1Controller', [ '$scope', '$q', 'CookiesService', ($scope, $q, CookiesService)->

  FILE_PROPERTIES = ['column_separator', 'row_separator', 'string_separator', 'header_line', 'encoding']

  cookies = new CookiesService(FILE_PROPERTIES)

  $scope.get_cookies_promise = ()->
    $q (resolve, reject)->
      resolve cookies.load($scope, 'file_params')
      

  angular.element(document).ready ()->
    $.fn.progress_bar.go(33)
    
    $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
      cookies.save($scope, 'file_params')
    
]