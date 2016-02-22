@csvv.factory 'CookiesService', ['$cookies', ($cookies)->
  
  class CookiesService

    constructor: (@fields)->
      
    save: (source, key)->
      _.each @fields, (field)->
        $cookies.put(field, source[key][field])
    
    load: (destination, key)->
      destination[key] = _.reduce @fields, (acc, field)->
        acc[field] = $cookies.get(field)
        return acc
      , {} 
      
]