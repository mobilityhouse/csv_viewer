@csvv.controller 'FileExtensionPostFormController', ['$scope', ($scope)->
  
  angular.element(document).ready ()->
    console.log $scope.$ctrl.setFormDataPromise
]
