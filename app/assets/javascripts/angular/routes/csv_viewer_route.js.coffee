@csvv.config ($stateProvider, $urlRouterProvider)->

  $urlRouterProvider.otherwise '/'

  $stateProvider
  
  .state 'root',
    url: '/',
    templateUrl: 'root_view.html'
    controller: 'RootController'
  
  .state 'root.log_in',
    url: 'login',
    templateUrl: 'login.html'
    controller: 'LoginController'
  
  .state 'root.main_view',
    url: 'main_view',
    templateUrl: 'main_view.html'
    controller: 'MainViewController'
    
  .state 'root.add_file',
    url: 'add_file',
    templateUrl: 'add_file.html'
    
  .state 'root.add_file.step_1',
    url: '/step_1',
    templateUrl: 'add_file/step_1.html'
    controller: 'AddFileStep1Controller'
    
  .state 'root.add_file.step_2',
    url: '/step_2',
    templateUrl: 'add_file/step_2.html'
    controller: 'AddFileStep2Controller'
    params: 
      name: null
      
  .state 'root.add_file.step_3',
    url: '/step_3/:file_id/:extension'
    templateUrl: 'add_file/step_3.html'
    controller: 'AddFileStep3Controller'
    params: 
      file_id: null
      extension: null
    
  .state 'root.view_file',
    url: 'view_file',
    templateUrl: 'view_file.html'
    
  .state 'root.view_file.step_1',
    url: '/step_1',
    templateUrl: 'view_file/step_1.html'
    controller: 'ViewFileStep1Controller'
    
  .state 'root.view_file.step_2',
    url: '/step_2/:file_id',
    templateUrl: 'view_file/step_2.html'
    controller: 'ViewFileStep2Controller'
    params:
      file_id: null
      
  .state 'root.edit_file',
    url: 'edit_file',
    templateUrl: 'edit_file.html'
    
  .state 'root.edit_file.step_1',
    url: '/step_1/:file_id',
    templateUrl: 'edit_file/step_1.html'
    controller: 'EditFileStep1Controller'
    params:
      file_id: null
      
