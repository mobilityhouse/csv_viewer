@csvv.controller 'AddFileStep3Controller', [ '$scope', '$state', 'FileAttributeService', ($scope, $state, FileAttributeService)->
  
  REQUIRED_ATTRIBUTES = ['columns']
  SPINNER_OPTIONS = 
    scale: 2
  $scope.attr_service = new FileAttributeService('CsvDocument')
  spinner = new Spinner(SPINNER_OPTIONS)

  $scope.get_attributes_promise = ()->
    $('#file-post-extension-form').hide()
    spinner.spin(document.getElementById('a-lv2'))
    $scope.attr_service.get_attributes($state.params.file_id, REQUIRED_ATTRIBUTES).then (res)->
      spinner.stop()
      $('#file-post-extension-form').show()
      res
    , (err)->
      spinner.stop()
      bootbox.alert "Cannot load file settings - #{err.status} #{err.statusText}"
      err
  
  $scope.set_attributes_promise = (data_to_send)->
    $('#file-post-extension-form').hide()
    spinner.spin(document.getElementById('a-lv2'))
    $scope.attr_service.update_attributes($state.params.file_id, $state.params.extension, data_to_send).then (res)->
      spinner.stop()
      bootbox.alert "Extension settings updated successfully."
      $('#file-post-extension-form').show()
      res
    , (err)->
      spinner.stop()
      bootbox.alert "Error during extension settings update - #{err.status} #{err.statusText}"
      $('#file-post-extension-form').show()
      err  
  
  $scope.go_to_next_view = ()->
    if $state.params.file_id?
      $state.go 'root.view_file.step_2', {file_id: $state.params.file_id}
    else
      bootbox.alert('File not selected')
      return false
      
  $scope.extension = $state.params.extension

#  angular.element(document).ready ()->

]
