@csvv.factory 'FileLoaderService', ['$http', ($http)->
  
  class FileLoader

    constructor: (@type, @file_id)->
      @file = null
          
    get_file: ()->
      $http
        url: "/document/", 
        method: "GET", 
        data: [],
        params: 
          type: @type
          id: @file_id
      .then (res)=>
        @file = res.data
]