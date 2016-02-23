@csvv.factory 'FileDeleteService', ['$http', ($http)->
  
  class FileList

    constructor: (@type, @file_id)->
      
    delete: ()->
      $http
        url: "/document", 
        method: "DELETE", 
        data: [],
        headers:
          'Content-Type': 'application/json'
        params: 
          type: @type
          file_id: @file_id
          
]