@csvv.factory 'FileAttributeService', ['$http', ($http)->
  
  class FileAttrService

    constructor: (@type)->
      @current_attributes = {}
          
    get_attributes: (file_id, attributes)->
      $http
        url: "/document/attribute", 
        method: "GET", 
        data: [],
        params: 
          type: @type
          file_id: file_id
          'attributes[]': attributes
          
    update_attributes: (file_id, extension_type, attributes)->
      $http
        url: '/extension_settings'
        method: "PATCH"
        data: []
        params:
          type: @type
          file_id: file_id
          extension_type: extension_type
          extension_attributes: attributes
]