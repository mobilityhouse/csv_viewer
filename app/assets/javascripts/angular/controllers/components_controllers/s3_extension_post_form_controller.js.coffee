@csvv.controller 'S3ExtensionPostFormController', ['$scope', 'CookiesService', ($scope, CookiesService)->

  column_settings_cookie = new CookiesService(['col_keyword'])

  $scope.set_extension_attributes = ()->
    $scope.$ctrl.setFormDataPromise({columns: $scope.$ctrl.extension_post_settings.selected_columns})

  set_form_layout = ()->
    _.defer ()->
      $( "#linked_columns" ).select2({ theme: "bootstrap", width: '100%', allowClear: true, placeholder: "Select columns with links"}).
        next( ".select2-container--bootstrap" ).addClass( "input-lg" );
      
  find_selected_columns = (doc_columns=[])->
    res = []
    column_settings_cookie.load($scope, 'extension_params')
    keyword = $scope.extension_params.col_keyword
    if keyword && (keyword != '')
      res = _.filter doc_columns, (col)->
        col.toUpperCase().match(new RegExp("#{keyword.toUpperCase()} [0-9]*"))
    res
      
  angular.element(document).ready ()->
    $scope.$ctrl.getFormDataPromise().then (res)->
      $scope.$ctrl.extension_post_settings = {columns: res.data.columns, selected_columns: find_selected_columns(res.data.columns)}
      set_form_layout()

]
