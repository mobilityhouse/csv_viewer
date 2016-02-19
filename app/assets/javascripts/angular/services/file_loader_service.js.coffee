@csvv.factory 'FileLoaderService', ['$http', ($http)->
  
  class FileLoader

    constructor: (@type)->
      @file = null
      
    load_file: (file_id)->
      if file_id?
        @get_file(file_id).then (response)=>
          @file = response.data
          
    get_file: (id)->
      $http
        url: "/document/", 
        method: "GET", 
        data: [],
        params: 
          type: @type
          id: id     
]