@csvv.controller 'ViewFileStep2Controller', [ '$scope', '$stateParams', 'FileLoaderService', ($scope, $stateParams, FileLoaderService)->
  
  SPINNER_OPTIONS = 
    scale: 2
    
  spinner = new Spinner(SPINNER_OPTIONS)
  
  set_layout = ()->
    $( "#filter_columns" ).select2({ theme: "bootstrap", width: '100%', allowClear: true, placeholder: 'All columns visible'})
    spinner.stop()
    $( '#state-content' ).toggle()
    $.fn.progress_bar.go(99)
    
  show_error_message = (err)=>
    spinner.stop()
    $.fn.progress_bar.go(99)
    bootbox.alert "Get file failed - #{err.status} #{err.statusText}. Check file settings or upload it again"
  
  angular.element(document).ready ()->
    spinner.spin( document.getElementById('a-l2') )
    $scope.file_loader = new FileLoaderService('CsvDocument')
    $scope.file_loader.load_file($stateParams.file_id, set_layout, show_error_message)
    $scope.search_phrase = null
  
]