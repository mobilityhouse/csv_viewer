@csvv.controller 'EditFileStep1Controller', [ '$scope', '$state', 'FileSettingsService', ($scope, $state, FileSettingsService)->

  SPINNER_OPTIONS = 
    scale: 2
    
  spinner = new Spinner(SPINNER_OPTIONS)

  show_update_success_message = ()->
    spinner.stop()
    bootbox.alert "Update of file settings successfull."
    
  show_update_fail_message = (err)->
    spinner.stop()
    bootbox.alert "Update of file failed - #{err.status} #{err.statusText}."

  $scope.save = ()->
    spinner.spin( document.getElementById('a-lv2') )
    $scope.file_settings.set(show_update_success_message, show_update_fail_message)
    

  set_layout = ()->
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
      spinner.stop()
      $( '#state-content' ).toggle()
      
  show_error_message = (err)->
    spinner.stop()
    bootbox.alert "Get file settings failed - #{err.status} #{err.statusText}."

  angular.element(document).ready ()->
    spinner.spin( document.getElementById('a-lv2') )
    $scope.file_settings = new FileSettingsService('CsvDocument', $state.params.file_id)
    $scope.file_settings.get(set_layout, show_error_message)
    
]