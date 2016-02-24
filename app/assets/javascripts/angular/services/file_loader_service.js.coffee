@csvv.factory 'FileLoaderService', ['$http', ($http)->
  
  class FileLoader

    constructor: (@type)->
      @file = null
      
    load_file: (file_id, callback_success, callback_fail)->
      if file_id?
        @get_file(file_id).then (response)=>
          @file = response.data
          if callback_success?
            callback_success()
        , (err)=>
          if callback_fail?
            callback_fail(err)
      else
        if callback_fail?
          callback_fail({status: 404, statusText: 'No file selected'})
          
          
    get_file: (id)->
      $http
        url: "/document/", 
        method: "GET", 
        data: [],
        params: 
          type: @type
          id: id     
]