@csvv.controller 'ViewFileStep2Controller', [ '$scope', '$stateParams', 'FileLoaderService', 'FileFilterService', ($scope, $stateParams, FileLoaderService, FileFilterService)->
  
  SPINNER_OPTIONS = 
    scale: 2
    
  spinner = new Spinner(SPINNER_OPTIONS)
  $scope.file_filter = new FileFilterService('CsvDocument', $stateParams.file_id)
  $scope.file_loader = new FileLoaderService('CsvDocument', $stateParams.file_id)
  
  $scope.save_filter = ()->
    $scope.file_filter.set_filter()
  
  set_layout = ()->
    $( "#filter_columns" ).select2({ theme: "bootstrap", width: '100%', allowClear: true, placeholder: 'All columns visible'})
    if $scope.file_loader.file?.extension_type == 'S3'
      _.forEach $scope.file_loader.file.rows, (r, i)->
        $( "#s3_doc_select_#{i}" ).select2({ theme: "bootstrap", width: '50%', allowClear: true, placeholder: 'Select document to view'})
    spinner.stop()
    $( '#state-content' ).show()
    $.fn.progress_bar.go(99)
    
  show_error_message = (err)=>
    spinner.stop()
    $.fn.progress_bar.go(99)
    bootbox.alert "Get file failed - #{err.status} #{err.statusText}. Check file settings or upload it again"
  
  angular.element(document).ready ()->
    spinner.spin( document.getElementById('a-l2') )
    $scope.file_loader.get_file().then ()->
      $scope.file_filter.get_filter().then ()->
        _.defer ()->
          set_layout()
      ,(err)->
        show_error_message(err)
]