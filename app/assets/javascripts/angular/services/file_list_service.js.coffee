@csvv.factory 'FileListService', ['$http', ($http)->
  
  class FileList

    constructor: (@type, @spinner, @progress_bar)->
      @current_file = []
      @get_file_list().then (response)=>
        @files = response.data
        @progress_bar.go(50)
        @spinner.spinner_object.stop()
        
    current_file_id: ()->
      if @current_file.length > 0
        return @current_file[0].id
      
    get_file_list: ()->
      @spinner.spinner_object.spin(@spinner.spinner_target)
      $http
        url: "/document/list", 
        method: "GET", 
        data: [],
        params: 
          type: @type
]