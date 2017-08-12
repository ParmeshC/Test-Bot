var ApiTest = angular.module('api.test', ['api.test.ui.layout', 'api.test.routine', 'api.test.planner', 'api.test.builder', 'ui.bootstrap', 'my-app', 'QueryApp', 'NestedLists', 'ngAnimate']);
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
    });



