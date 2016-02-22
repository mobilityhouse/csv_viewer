@csvv.controller 'ViewFileStep2Controller', [ '$scope', '$stateParams', 'FileLoaderService', ($scope, $stateParams, FileLoaderService)->
  
  SPINNER_OPTIONS = 
    scale: 2
  
  angular.element(document).ready ()->
    $scope.file_loader = new FileLoaderService('CsvDocument', { spinner_object: new Spinner(SPINNER_OPTIONS), spinner_target: document.getElementById('main_container') }, $.fn.progress_bar)
    $scope.file_loader.load_file($stateParams.file_id)
    $( "#filter_columns" ).select2({ theme: "bootstrap", width: '100%', allowClear: true, placeholder: 'All columns visible'})
  
]