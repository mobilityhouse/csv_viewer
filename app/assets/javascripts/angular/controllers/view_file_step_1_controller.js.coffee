@csvv.controller 'ViewFileStep1Controller', ['$scope', 'FileListService', 'FileDeleteService', ($scope, FileListService, FileDeleteService)->

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
    

  angular.element(document).ready ()->
    $scope.file_list = new FileListService('CsvDocument', { spinner_object: new Spinner(SPINNER_OPTIONS), spinner_target: document.getElementById('main_container') }, $.fn.progress_bar)

]