@csvv.factory 'FileExtensionService', ['$http', ($http)->
  
  class ExtensionSettings

    constructor: (@type, @file_id)->
      @current_extension_settings = {}
      
    get: (callback_success, callback_fail)->
      $http
        url: "/extension_settings", 
        method: "GET", 
        data: [],
        params: 
          type: @type
          file_id: @file_id
      .then (res)=>
        @current_extension_settings = res.data
        if callback_success?
          callback_success()
      , (err)=>
        if callback_fail?
          callback_fail(err)
          
]