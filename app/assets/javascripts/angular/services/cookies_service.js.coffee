@csvv.factory 'CookiesService', ['$cookies', ($cookies)->
  
  class CookiesService

    constructor: (@fields)->
      
    save: (source, key)->
      _.each @fields, (field)->
        console.log "Save cookie #{field} - #{source[key][field]}"
        $cookies.put(field, source[key][field])
    
    load: (destination, key)->
      destination[key] = _.reduce @fields, (acc, field)->
        console.log "Load cookie #{field} - #{$cookies.get(field)}"
        acc[field] = $cookies.get(field)
        return acc
      , {} 
      
]