@csvv.factory 'FileLoaderService', ['$http', ($http)->
  
  class FileLoader

    constructor: (@type)->
      @current_file_info = null
      @current_file = null
      
    load_current_file: ()->
      if @current_file_info.length > 0
        @get_file(@current_file_info[0].id).then (response)=>
          @current_file = response.data
          
    get_file: (id)->
      $http
        url: "/document/", 
        method: "GET", 
        data: [],
        params: 
          type: @type
          id: id     
]