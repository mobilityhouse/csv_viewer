@csvv.controller 'ViewFileStep2Controller', [ '$scope', '$stateParams', 'FileLoaderService', ($scope, $stateParams, FileLoaderService)->
  
  angular.element(document).ready ()->
    $scope.file_loader = new FileLoaderService('CsvDocument')
    #$scope.file_loader = new FileLoaderService('CsvDocument')
    $scope.file_loader.load_file($stateParams.file_id)
    $( "#filter_columns" ).select2({ theme: "bootstrap", width: '100%', allowClear: true, placeholder: 'All columns visible'})
    #_.defer ()->
    #  $scope.$apply()
  
]