@csvv.factory 'FileLoaderService', ['$http', ($http)->
  
  class FileLoader

    constructor: (@type, @spinner, @progress_bar)->
      @file = null
      
    load_file: (file_id)->
      if file_id?
        @get_file(file_id).then (response)=>
          @file = response.data
          @progress_bar.go(99)
          @spinner.spinner_object.stop()
          
    get_file: (id)->
      @spinner.spinner_object.spin(@spinner.spinner_target)
      $http
        url: "/document/", 
        method: "GET", 
        data: [],
        params: 
          type: @type
          id: id     
]