@csvv.factory 'FileListService', ['$http', ($http)->
  
  class FileList

    constructor: (@type)->
      @current_file = []
      @get_file_list().then (response)=>
        @file_list = response.data
      
    get_file_list: ()->
      $http
        url: "/document/list", 
        method: "GET", 
        data: [],
        params: 
          type: @type
]