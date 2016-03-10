@csvv.controller 'RootController', ['$scope', '$rootScope', '$state', 'Auth', ($scope, $rootScope, $state, Auth)->

  check_auth = (state)->
    console.log 'check_auth' 
    if state.name != 'root.log_in' && !Auth.isAuthenticated() 
      console.log 'check_auth redirect'
      $state.go 'root.log_in'
      
  check_auth($state.current)
  
  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
    console.log 'state change'
    check_auth(toState)

  $scope.logout = ()->
    Auth.logout().then ()->
      $state.go 'root.log_in'
    , (err)->
      console.log err

]