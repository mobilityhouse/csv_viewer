@csvv.controller 'EditFileStep1Controller', [ '$scope', '$state', 'FileSettingsService', ($scope, $state, FileSettingsService)->

  SPINNER_OPTIONS = 
    scale: 2
    
  spinner = new Spinner(SPINNER_OPTIONS)
  $scope.file_settings = new FileSettingsService('CsvDocument', $state.params.file_id)

  show_update_success_message = ()->
    spinner.stop()
    bootbox.alert "Update of file settings successfull."
    
  show_update_fail_message = (err)->
    spinner.stop()
    bootbox.alert "Update of file failed - #{err.status} #{err.statusText}."

  $scope.save = ()->
    spinner.spin( document.getElementById('a-lv2') )
    $scope.file_settings.set(show_update_success_message, show_update_fail_message)
    
  spinner_stop = ()->
    $('#save-btn-container').toggle()
    spinner.stop()
    
  show_get_settings_error_message = (err)->
    spinner.stop()
    bootbox.alert "Get file settings failed - #{err.status} #{err.statusText}."
    
  $scope.get_file_settings_promise = ()->
    $scope.file_settings.get(spinner_stop, show_get_settings_error_message )

  angular.element(document).ready ()->
    spinner.spin( document.getElementById('a-lv2') )
    
]