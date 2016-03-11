@csvv.controller 'FileSettingsFormController', ['$scope', ($scope)->

  set_form_layout = ()->
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
      $( '#file-settings-form' ).toggle()

  angular.element(document).ready ()->
    $scope.$ctrl.getFormDataPromise().then ()->
      set_form_layout()

]