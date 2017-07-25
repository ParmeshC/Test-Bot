var ApiTest = angular.module('api.test', ['api.test.ui.layout', 'api.test.routine', 'api.test.planner', 'ui.bootstrap', 'my-app', 'QueryApp', 'NestedLists']);
ApiTest.service('apiTestSharedService', function ($rootScope) {

        var sharedService= {};
        sharedService.apiInfo = '';
        sharedService.apiResponseInfo = '';

        this.ApiInfoBroadcast= function (ApiInfo) {
        this.apiInfo = ApiInfo;
        this.broadcastApiInfo();
    };

    this.broadcastApiInfo= function () {
        $rootScope.$broadcast('handleApiInfoBroadcast');
    };

    this.ApiRsponseInfoBroadcast = function (ApiRsponseInfo) {
        this.apiResponseInfo = ApiRsponseInfo;
        this.broadcastApiResponseInfo();
    };

    this.broadcastApiResponseInfo = function () {
        $rootScope.$broadcast('handleApiResponseInfoBroadcast');
    };

    });



