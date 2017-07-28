(function (NestedLists) {
    NestedLists.controller("NestedListsController", ['$scope', 'apiTestSharedService', function ($scope, apiTestSharedService) {

        $scope.models = {
        selected: null,
        templates: [
            { type: "item", id: 2 },
            { type: "container", id: 1, columns: [[], []] }
        ],
        dropzones:
        {
            "A":
           [
    {
        "transactions": [
            {
                "transactionDate": "2017-05-25T07:53:21-04:00",
                "transactionDetailLines": [
                    {
                        "accountingString": "^|B^|^|E1^|12001^|7120^|^|^|^|^|^|^|",
                        "amount": {
                            "currency": "USD",
                            "value": 100
                        },
                        "fundsAvailable": "overrideAvailable",
                        "type": "debit"
                    },
                    {
                        "accountingString": "^|B^|^|E1^|12001^|7120^|^|^|^|^|^|^|",
                        "amount": {
                            "currency": "USD",
                            "value": 5000
                        },
                        "fundsAvailable": "overrideAvailable",
                        "type": "debit"
                    },
                    {
                        "accountingString": "^|B^|^|E1^|12001^|7120^|^|^|^|^|^|^|",
                        "amount": {
                            "currency": "USD",
                            "value": 5000
                        },
                        "fundsAvailable": "available",
                        "type": "credit"
                    },
                    {
                        "accountingString": "^|B^|^|E1^|12001^|7120^|^|^|^|^|^|^|",
                        "amount": {
                            "currency": "USD",
                            "value": 5000
                        },
                        "fundsAvailable": "overrideAvailable",
                        "type": "debit"
                    },
                    {
                        "accountingString": "^|B^|^|E1^|12001^|7120^|^|^|^|^|^|^|",
                        "amount": {
                            "currency": "USD",
                            "value": 5000
                        },
                        "fundsAvailable": "overrideAvailable",
                        "type": "debit"
                    }
                ],
                "type": "travelEncumbranceCreate"
            }
        ]
    }
]

            
        }
    };

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
                '><member></member></li></ul>',
                
            }
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
                if (scope.node != undefined)
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
                            var prop
                            for (prop in scope.node) {
                                if (angular.isObject(scope.node[prop])) {
                                    scope.nodeValueIsObject = true;
                                    scope.indxValue = prop;
                                    scope.nodeValue = scope.node[prop]
                                }
                            }
                        }

                if (scope.nodeValueIsObject)
                {
                    elem.append("<collection list='nodeValue'></collection>");
                    $compile(elem.contents())(scope)
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