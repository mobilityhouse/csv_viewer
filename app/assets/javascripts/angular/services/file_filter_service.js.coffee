@csvv.factory 'FileFilterService', ['$http', ($http)->
  
  class FileFilter

    constructor: (@type, @file_id)->
      @filter = { phrase_filter: null, column_filter: null }
        
    get_filter: ()->
      $http
        url: '/document_filter', 
        method: 'GET', 
        data: [],
        params: 
          type: @type
          file_id: @file_id
      .then (res)=>
        @filter = res.data
    
    set_filter: ()->
      $http
        url: '/document_filter'
        method: 'POST'
        data: [],
        params:
          type: @type
          file_id: @file_id
          filter_settings: @filter

]