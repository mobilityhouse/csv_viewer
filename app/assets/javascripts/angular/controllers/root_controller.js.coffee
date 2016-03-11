@csvv.controller 'RootController', ['$scope', '$rootScope', '$state', 'Auth', ($scope, $rootScope, $state, Auth)->

  STATES_WITHOUT_AUTHORIZATION = ['root.log_in']

  check_auth = (state)->
    console.log 'check_auth' 

    if !_.include( STATES_WITHOUT_AUTHORIZATION, state.name)
      Auth.currentUser().then (res)->
        console.log 'auth ok'
      , ()->
        console.log 'auth bad - redirect'
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