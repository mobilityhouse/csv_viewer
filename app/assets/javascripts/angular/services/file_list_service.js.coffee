@csvv.factory 'FileListService', ['$http', ($http)->
  
  class FileList

    constructor: (@type)->
      @current_file = []
      @get_file_list().then (response)=>
        @files = response.data
        
    current_file_id: ()->
      if @current_file.length > 0
        return @current_file[0].id
      
    get_file_list: ()->
      $http
        url: "/document/list", 
        method: "GET", 
        data: [],
        params: 
          type: @type
]