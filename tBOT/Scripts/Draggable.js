(function (NestedLists) {
    NestedLists.controller("NestedListsController", ['$scope', 'apiTestSharedService', function ($scope, apiTestSharedService) {


        $scope.$on('handleApiResponseInfoBroadcast', function () {
            $scope.ApiResponseInfo = apiTestSharedService.apiResponseInfo; 
            if ($scope.ApiResponseInfo !== null) {
                $scope.ApiResponseInfoObject = $scope.ApiResponseInfo.ResponseContent.IsResponseArray ? $scope.ApiResponseInfo.ResponseContent.ResponseArray : $scope.ApiResponseInfo.ResponseContent.ResponseObject;
            }
        });

        $scope.$on('handleDesignTestTemplateBroadcast', function () {
            $scope.DesignTestTemplate = apiTestSharedService.designTestTemplate;
        });


    $scope.$watch('models.dropzones', function (model) {
        $scope.modelAsJson = angular.toJson(model, true);
    }, true);

    $scope.indxValue;
    $scope.nodeValue;    
    $scope.nodeValueIsObject;

    }]);



})(angular.module('NestedLists', ["dndLists"]));

 (function () {
        'use strict';
        function collection() {
            return {
                restrict: "E",
                replace: true,
                scope: {
                    list: '='
                },
                controller: 'NestedListsController',
                template:
                '<ul dnd-list>\n' +
                '<li ng-repeat="(indx,node) in list track by $index"\n' +
                '><member></member></li></ul>'
            };
        }
        collection.$inject = [];
        angular
            .module('NestedLists')
            .directive('collection', collection);
 }());

(function () {
    'use strict';
    function member($compile) {
        return {
            restrict: 'E',
            template: 
            '<div class="container-element box box-blue">\n' +
            '<h3> {{indxValue}}</h3>\n' +
            '<div ng-if="!nodeValueIsObject">{{nodeValue}}</div>\n' +
             '<div class="clearfix"></div>\n' +
            '</div>\n',
            controller: 'NestedListsController',
            replace: true,
            transclude: true,
            link: function (scope, elem, attrs)
            {                
                if (scope.node !== undefined)
                {
                        scope.indxValue = scope.indx;
                        scope.nodeValue = scope.node;
                        scope.nodeValueIsObject = false;

                        if (angular.isObject(scope.node))
                        {
                            scope.nodeValueIsObject = true;
                        }
                        else
                        {
                            var prop;
                            for (prop in scope.node) {
                                if (angular.isObject(scope.node[prop])) {
                                    scope.nodeValueIsObject = true;
                                    scope.indxValue = prop;
                                    scope.nodeValue = scope.node[prop];
                                }
                            }
                        }

                if (scope.nodeValueIsObject)
                {
                    elem.append("<collection list='nodeValue'></collection>");
                    $compile(elem.contents())(scope);
                } 
                }
            }
        };
    }
    member.$inject = ['$compile'];
    angular
        .module('NestedLists')
        .directive('member', member);
}());