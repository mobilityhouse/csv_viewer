@csvv.controller 'ViewFileStep1Controller', ['$scope', 'FileListService', ($scope, FileListService)->

  SPINNER_OPTIONS = 
    scale: 2

  angular.element(document).ready ()->
    $scope.file_list = new FileListService('CsvDocument', { spinner_object: new Spinner(SPINNER_OPTIONS), spinner_target: document.getElementById('main_container') }, $.fn.progress_bar)

]