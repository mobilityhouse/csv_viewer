@csvv.config ($stateProvider, $urlRouterProvider)->

  $urlRouterProvider.otherwise "/"

  $stateProvider
  
  .state 'main_view',
    url: "/",
    templateUrl: "main_view.html"
    controller: 'DocumentViewerController'