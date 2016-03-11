@csvv.controller 'LoginController', ['$scope', '$state', 'Auth', ($scope, $state, Auth)->

  $scope.user = {}

  $scope.login = ()->
    Auth.login($scope.user).then ()->
      $state.go 'root.main_view'
    , (err)->
      bootbox.alert "Email / password incorrect"
      return false

  angular.element(document).ready ()->
    $.fn.progress_bar.go(1)
    
]