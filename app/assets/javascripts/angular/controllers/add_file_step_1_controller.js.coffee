@csvv.controller 'AddFileStep1Controller', [ '$scope', '$rootScope', '$state', 'CookiesService', ($scope, $rootScope, $state, CookiesService)->

  FILE_PROPERTIES = ['name', 'column_separator', 'row_separator', 'string_separator', 'header_line', 'encoding']

  cookies = new CookiesService(FILE_PROPERTIES)

  angular.element(document).ready ()->
    cookies.load($scope, 'file_params')
    _.defer ()->
      $scope.$apply()
      $( "#f_column_separator" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select column separator"})
      $( "#f_row_separator" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select row separator"})
      $( "#f_string_separator" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select string separator"})
      $( "#f_has_header" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select if file has header row"})
      $( "#f_encoding" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select encoding"})

    $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
      cookies.save($scope, 'file_params')

]