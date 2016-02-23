@csvv.factory 'FileSettingsService', ['$http', ($http)->
  
  class FileSettings

    constructor: (@type, @file_id, @spinner)->
      @current_file_settings = {}
      
    get: (callback_function)->
      @spinner.spinner_object.spin(@spinner.spinner_target)
      $http
        url: "/document_settings", 
        method: "GET", 
        data: [],
        params: 
          type: @type
          file_id: @file_id
      .then (res)=>
        @current_file_settings = res.data
        if callback_function?
          callback_function()
        @spinner.spinner_object.stop()
      , (err)=>
        if callback_function?
          callback_function()
        @spinner.spinner_object.stop()
        bootbox.alert "Get file settings failed - #{err.status} #{err.statusText}."
          
    set: ()->
      @spinner.spinner_object.spin(@spinner.spinner_target)
      $http
        url: "/document_settings", 
        method: "POST", 
        data: [],
        params: 
          type: @type
          file_id: @file_id
          new_settings: @current_file_settings
      .then (res)=>
        @spinner.spinner_object.stop()
        bootbox.alert "Update of file settings successfull."
      , (err)=>
        @spinner.spinner_object.stop()
        bootbox.alert "Update of file failed - #{err.status} #{err.statusText}."
          
]