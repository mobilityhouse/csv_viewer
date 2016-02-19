@csvv.controller 'ViewFileStep1Controller', ['$scope', 'FileListService', ($scope, FileListService)->

  angular.element(document).ready ()->
    $scope.file_list = new FileListService('CsvDocument')
    console.log 'ok'

]