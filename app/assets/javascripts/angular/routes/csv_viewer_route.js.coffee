@csvv.config ($stateProvider, $urlRouterProvider)->

  $urlRouterProvider.otherwise "/"

  $stateProvider
  
  .state 'main_view',
    url: "/",
    templateUrl: "main_view.html"
    
  .state 'add_file',
    url: "/add_file",
    templateUrl: "add_file.html"
    
  .state 'add_file.step_1',
    url: "/step_1",
    templateUrl: "add_file/step_1.html"
    controller: 'AddFileStep1Controller'
    
  .state 'add_file.step_2',
    url: "/step_2/:name",
    templateUrl: "add_file/step_2.html"
    controller: 'AddFileStep2Controller'
    params: 
      name: null
    
  .state 'view_file',
    url: "/view_file",
    templateUrl: "view_file.html"
    
  .state 'view_file.step_1',
    url: "/step_1",
    templateUrl: "view_file/step_1.html"
    controller: 'ViewFileStep1Controller'
    
  .state 'view_file.step_2',
    url: "/step_2/:file_id",
    templateUrl: "view_file/step_2.html"
    controller: 'ViewFileStep2Controller'
    params:
      file_id: null
    