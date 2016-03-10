@csvv.controller 'LoginController', ['$scope', '$state', 'Auth', ($scope, $state, Auth)->

  $scope.user = {}

#  $scope.toggle_remember_me = (a)->
#    if !$scope.user.remember_me
#      $scope.user.remember_me = true
#    else
#      $scope.user.remember_me = false
#    console.log a

  $scope.login = ()->
    Auth.login($scope.user).then ()->
      $state.go 'root.main_view'
    , (err)->
      console.log err

  angular.element(document).ready ()->
    $.fn.progress_bar.go(1)
    
]