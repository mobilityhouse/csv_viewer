#@csvv.directive 'ngCompileDyn',[ '$compile', ($compile)->
#  {
#    restrict: 'E',
#    scope:
#      htmlToCompile: '='
#    replace: true,
#    link: (scope, element, attr)->
#      linkFn = $compile(scope.htmlToCompile)
#      content = linkFn(scope)
#      element.append(content)
#  }
#]