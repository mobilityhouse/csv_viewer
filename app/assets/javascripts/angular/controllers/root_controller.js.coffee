@csvv.controller 'RootController', ['$scope', '$rootScope', '$state', 'Auth', ($scope, $rootScope, $state, Auth)->

  STATES_WITHOUT_AUTHORIZATION = ['root.log_in']

  check_auth = (state)->
    console.log 'check_auth' 

    if !_.include( STATES_WITHOUT_AUTHORIZATION, state.name)
      Auth.currentUser().then (logged_user)->
        $scope.is_admin = logged_user.admin
      , ()->
        bootbox.alert "You have to be logged in to view this page"
        $state.go 'root.log_in'
  
  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, options)->
    check_auth(toState)

  $scope.logout = ()->
    Auth.logout().then ()->
      $state.go 'root.log_in'
    , (err)->
      bootbox.alert "Error during logout occured"
      return false
      
  check_auth($state.current)

]