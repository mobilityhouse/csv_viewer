@csvv.controller 'ViewFileStep1Controller', ['$scope', '$state', 'FileListService', 'FileDeleteService', ($scope, $state, FileListService, FileDeleteService)->

  SPINNER_OPTIONS = 
    scale: 2

  $scope.delete_file = (file_id)->
    bootbox.confirm "Selected file will be deleted. Are you sure?", (result)->
      if result
        new FileDeleteService('CsvDocument', file_id).delete().then (res)->
          $scope.file_list.refresh()
        , (err)->
          bootbox.alert "Removing of file failed - #{err.status} #{err.statusText}"
    return 1
    
  $scope.edit_file = (file_id)->
    $state.go 'edit_file.step_1', {file_id: file_id}

  angular.element(document).ready ()->
    $scope.file_list = new FileListService('CsvDocument', { spinner_object: new Spinner(SPINNER_OPTIONS), spinner_target: document.getElementById('main_container') }, $.fn.progress_bar)

]