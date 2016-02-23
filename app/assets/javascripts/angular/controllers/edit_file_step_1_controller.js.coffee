@csvv.controller 'EditFileStep1Controller', [ '$scope', '$state', 'FileSettingsService', ($scope, $state, FileSettingsService)->

  SPINNER_OPTIONS = 
    scale: 2

  $scope.save = ()->
    $scope.file_settings.set()

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

  angular.element(document).ready ()->
    $scope.file_settings = new FileSettingsService('CsvDocument', $state.params.file_id,  { spinner_object: new Spinner(SPINNER_OPTIONS), spinner_target: document.getElementById('a-lv2') })
    $scope.file_settings.get(set_form_layout)
    
]