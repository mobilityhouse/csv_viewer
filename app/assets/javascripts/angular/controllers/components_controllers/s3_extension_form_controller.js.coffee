@csvv.controller 'S3ExtensionFormController', ['$scope', ($scope)->

  set_form_layout = ()->
    _.defer ()->
      $( "#aws_region" ).select2({ theme: "bootstrap", width: '100%', allowClear: false, placeholder: "Select AWS region"}).
        next( ".select2-container--bootstrap" ).addClass( "input-lg" );
      
  angular.element(document).ready ()->
    $scope.$ctrl.getFormDataPromise().then ()->
      set_form_layout()

]
