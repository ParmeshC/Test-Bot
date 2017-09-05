var ApiTest = angular.module('api.test', ['api.test.ui.layout', 'api.test.routine', 'api.test.planner', 'api.test.builder', 'api.test.design.testcase','ui.bootstrap', 'my-app', 'QueryApp', 'NestedLists', 'ngAnimate', 'angular-jsoneditor']);
ApiTest.service('apiTestSharedService', function ($rootScope) {
        var sharedService = {};

        //apiRequestList broadcast service
        sharedService.apiRequestList = '';
        this.apiRequestListBroadcast = function (ApiRequestList) {
            this.apiRequestList = ApiRequestList;
            this.broadcastApiRequestList();
        };
        this.broadcastApiRequestList= function () {
            $rootScope.$broadcast('handleApiRequestListBroadcast');
        };
        //---------------------------------


        //apiResponseList broadcast service
        sharedService.apiResponseList = '';
        this.apiResponseListBroadcast = function (ApiResponseList) {
            this.apiResponseList = ApiResponseList;
            this.broadcastApiResponseList();
        };
        this.broadcastApiResponseList = function () {
            $rootScope.$broadcast('handleApiResponseListBroadcast');
        };
        //--------------------------------

        //apiResponseInfo broadcast service
        sharedService.apiResponseInfo = '';
        this.apiResponseInfoBroadcast = function (ApiResponseInfo) {
            this.apiResponseInfo = ApiResponseInfo;
            this.broadcastApiResponseInfo();
        };
        this.broadcastApiResponseInfo = function () {
            $rootScope.$broadcast('handleApiResponseInfoBroadcast');
        };
        //---------------------------------


        //designTestTemplate broadcast service
        sharedService.designTestTemplate = '';
        this.designTestTemplateBroadcast = function (DesignTestTemplate) {
            this.designTestTemplate = DesignTestTemplate;
            this.broadcastDesignTestTemplate();
        };
        this.broadcastDesignTestTemplate = function () {
            $rootScope.$broadcast('handleDesignTestTemplateBroadcast');
        };
        //---------------------------------

});

ApiTest.filter('orderObjectBy', function () {
    return function (items, field, reverse) {

        function isNumeric(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        }

        var filtered = [];

        angular.forEach(items, function (item, key) {
            item.key = key;
            filtered.push(item);
        });

        function index(obj, i) {
            return obj[i];
        }

        filtered.sort(function (a, b) {
            var comparator;
            var reducedA = field.split('.').reduce(index, a);
            var reducedB = field.split('.').reduce(index, b);

            if (isNumeric(reducedA) && isNumeric(reducedB)) {
                reducedA = Number(reducedA);
                reducedB = Number(reducedB);
            }

            if (reducedA === reducedB) {
                comparator = 0;
            } else {
                comparator = reducedA > reducedB ? 1 : -1;
            }

            return comparator;
        });


        if (reverse) {
            filtered.reverse();
        }

        return filtered;
    };
});



