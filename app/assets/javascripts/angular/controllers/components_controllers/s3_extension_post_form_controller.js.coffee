@csvv.controller 'S3ExtensionPostFormController', ['$scope', ($scope)->

  $scope.set_extension_attributes = ()->
    $scope.$ctrl.setFormDataPromise({columns: $scope.$ctrl.extension_post_settings.selected_columns})

  set_form_layout = ()->
    _.defer ()->
      $( "#linked_columns" ).select2({ theme: "bootstrap", width: '100%', allowClear: true, placeholder: "Select columns with links"}).
        next( ".select2-container--bootstrap" ).addClass( "input-lg" );
      
  angular.element(document).ready ()->
    $scope.$ctrl.getFormDataPromise().then (res)->
      $scope.$ctrl.extension_post_settings = {columns: res.data.columns}
      set_form_layout()

]
