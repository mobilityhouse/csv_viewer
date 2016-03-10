@csvv.controller 'ViewFileStep1Controller', ['$scope', '$state', 'FileListService', 'FileDeleteService', ($scope, $state, FileListService, FileDeleteService)->

  SPINNER_OPTIONS = 
    scale: 2
    
  spinner = new Spinner(SPINNER_OPTIONS)
  
  $scope.go_to_file = ()->
    if $scope.file_list.current_file_id()?
      $state.go 'root.view_file.step_2', {file_id: $scope.file_list.current_file_id()} 
    else
      bootbox.alert "Please select file to view"
      return true

  $scope.delete_file = (file_id)->
    bootbox.confirm "Selected file will be deleted. Are you sure?", (result)->
      if result
        new FileDeleteService('CsvDocument', file_id).delete().then (res)->
          $scope.file_list.refresh()
        , (err)->
          bootbox.alert "Removing of file failed - #{err.status} #{err.statusText}"
    return 1
    
  $scope.edit_file = (file_id)->
    $state.go 'root.edit_file.step_1', {file_id: file_id}
    
  set_layout = ()->
    $.fn.progress_bar.go(50)
    spinner.stop()
    $('#state-content').toggle()
  
  show_error_message = (err)->
    $.fn.progress_bar.go(50)
    spinner.stop()
    bootbox.alert "Get file list failed - #{err.status} #{err.statusText}"

  angular.element(document).ready ()->
    spinner.spin( document.getElementById('a-l2') )
    $scope.file_list = new FileListService('CsvDocument')
    $scope.file_list.refresh(set_layout, show_error_message)
    
]