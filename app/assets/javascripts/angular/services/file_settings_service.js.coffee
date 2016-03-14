@csvv.factory 'FileSettingsService', ['$http', ($http)->
  
  class FileSettings

    constructor: (@type, @file_id)->
      @current_file_settings = {}
      
    get: (callback_success, callback_fail)->
      $http
        url: "/document_settings", 
        method: "GET", 
        data: [],
        params: 
          type: @type
          file_id: @file_id
      .then (res)=>
        @current_file_settings = res.data
        if callback_success?
          callback_success()
      , (err)=>
        if callback_fail?
          callback_fail(err)
          
    set: (callback_success, callback_fail, extension_settings={})->
      $http
        url: "/document_settings", 
        method: "POST", 
        data: [],
        params: 
          type: @type
          file_id: @file_id
          new_settings: @current_file_settings
          new_extension_settings: extension_settings
      .then (res)=>
        if callback_success?
          callback_success()
      , (err)=>
        if callback_fail?
          callback_fail(err)
          
]