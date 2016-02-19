@csvv.controller 'AddFileStep1Controller', [ '$scope', '$rootScope', '$state', 'CookiesService', ($scope, $rootScope, $state, CookiesService)->

  FILE_PROPERTIES = ['column_separator', 'row_separator', 'string_separator', 'header_line', 'encoding']

  cookies = new CookiesService(FILE_PROPERTIES)

  angular.element(document).ready ()->
    cookies.load($scope, 'file_params')
    _.defer ()->
      $scope.$apply()
      $( "#f_column_separator" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select column separator"}).
        next( ".select2-container--bootstrap" ).addClass( "input-lg" );
      $( "#f_row_separator" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select row separator"}).
        next( ".select2-container--bootstrap" ).addClass( "input-lg" );
      $( "#f_string_separator" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select string separator"}).
        next( ".select2-container--bootstrap" ).addClass( "input-lg" );
      $( "#f_has_header" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select if file has header row"}).
        next( ".select2-container--bootstrap" ).addClass( "input-lg" );
      $( "#f_encoding" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select encoding"}).
        next( ".select2-container--bootstrap" ).addClass( "input-lg" );

    $scope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
      cookies.save($scope, 'file_params')

]