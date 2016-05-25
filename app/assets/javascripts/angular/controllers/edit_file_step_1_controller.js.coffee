@csvv.controller 'EditFileStep1Controller', [ '$scope', '$state', 'FileSettingsService', 'FileExtensionService', ($scope, $state, FileSettingsService, FileExtensionService)->

  SPINNER_OPTIONS = 
    scale: 2
    
  spinner = new Spinner(SPINNER_OPTIONS)
  $scope.file_settings = new FileSettingsService('CsvDocument', $state.params.file_id)
  $scope.extension_settings = new FileExtensionService('CsvDocument', $state.params.file_id)
  
  show_update_success_message = ()->
    spinner.stop()
    bootbox.alert "Update of file settings successfull."
    
  show_update_fail_message = (err)->
    spinner.stop()
    bootbox.alert "Update of file failed - #{err.status} #{err.statusText}."

  $scope.save = ()->
    spinner.spin( document.getElementById('a-lv2') )
    $scope.file_settings.set(show_update_success_message, show_update_fail_message, $scope.extension_settings.current_extension_settings)
    $state.go 'root.view_file.step_1'
    
  spinner_stop = ()->
    $('#save-btn-container').show()
    spinner.stop()
    
  show_get_settings_error_message = (err)->
    spinner.stop()
    bootbox.alert "Get file settings failed - #{err.status} #{err.statusText}."
    
  $scope.get_file_settings_promise = ()->
    $scope.file_settings.get(spinner_stop, show_get_settings_error_message )
    
  $scope.get_extension_settings_promise = ()->
    $scope.extension_settings.get(spinner_stop, show_get_settings_error_message)

  angular.element(document).ready ()->
    spinner.spin( document.getElementById('a-lv2') )
    
]