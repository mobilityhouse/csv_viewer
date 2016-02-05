@csvv.controller 'DocumentViewerController', [ '$scope', 'DropzoneService', 'FileListService', 'FileLoaderService', ($scope, DropzoneService, FileListService, FileLoaderService)->

  angular.element(document).ready ()->
    $scope.fl = new FileListService('CsvDocument')
    $scope.dz = new DropzoneService('CsvDocument', 'file_uploader_dz', $scope.fl)
    $scope.floader = new FileLoaderService('CsvDocument')
    $scope.floader.current_file_info = $scope.fl.current_file
    
    $( "#filter_columns" ).select2({ theme: "bootstrap", width: '100%', allowClear: true, placeholder: 'All columns visible'})
    
    $scope.aaa = ()->
      console.log $scope.column_filter
]