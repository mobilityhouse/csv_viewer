@csvv.controller 'S3ExtensionFormController', ['$scope', ($scope)->

  angular.element(document).ready ()->
    $scope.$ctrl.getFormDataPromise()

]
