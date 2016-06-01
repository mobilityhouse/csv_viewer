@csvv.controller 'ViewFileStep2Controller', [ '$scope', '$stateParams', 'FileLoaderService', 'FileFilterService', ($scope, $stateParams, FileLoaderService, FileFilterService)->
  
  SPINNER_OPTIONS = 
    scale: 2
    
  PER_PAGE = 10
  PER_PAGE_PRESETS = [10, 20, 30, 40, 50]
    
  spinner = new Spinner(SPINNER_OPTIONS)
  $scope.file_filter = new FileFilterService('CsvDocument', $stateParams.file_id)
  $scope.file_loader = new FileLoaderService('CsvDocument', $stateParams.file_id)
  
  $scope.save_filter = ()->
    $scope.file_filter.set_filter()
  
  set_layout = ()->
    column_filter = $( "#filter_columns" ).select2({ theme: "bootstrap", width: '100%', allowClear: true, placeholder: 'All columns visible'})
    column_filter.on 'change', (e)-> 
      $scope.set_document_selects()
    $('#search_phrase').on 'keypress', (e)->
      $scope.set_document_selects()
    $scope.set_document_selects()
    spinner.stop()
    $( '#state-content' ).show()
    $.fn.progress_bar.go(99)
    
  $scope.set_document_selects = ()->
    $('#state-content').hide();
    spinner.spin( document.getElementById('a-l2') )
    if $scope.file_loader.file?.extension_type == 'S3'
      _.defer ()->
        $( ".document_selector" ).select2({ theme: "bootstrap", width: '85%', allowClear: true, placeholder: 'Select document to view'})
        $('#state-content').show();
        spinner.stop()
    true
    
  show_error_message = (err)=>
    spinner.stop()
    $.fn.progress_bar.go(99)
    bootbox.alert "Get file failed - #{err.status} #{err.statusText}. Check file settings or upload it again"
    
  $scope.set_per_page = (new_per_page)->
    $scope.per_page = new_per_page
    $scope.set_document_selects()
    
  $scope.per_page_class = (per_page_set)->
    return 'active' if per_page_set == $scope.per_page
    return ''
  
  angular.element(document).ready ()->
    $scope.per_page = PER_PAGE
    $scope.per_page_presets = PER_PAGE_PRESETS
    spinner.spin( document.getElementById('a-l2') )
    $scope.file_loader.get_file().then ()->
      $scope.file_filter.get_filter().then ()->
        _.defer ()->
          set_layout()
      ,(err)->
        show_error_message(err)
]