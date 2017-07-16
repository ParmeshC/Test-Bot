var ApiTest = angular.module('api.test', ['api.test.ui.layout', 'api.test.routine', 'api.test.planner', 'ui.bootstrap', 'my-app', 'QueryApp', 'NestedLists']);
ApiTest.service('apiTestSharedService', function ($rootScope) {

        var sharedService= {};
        sharedService.apiInfo = '';

    this.prepForBroadcast= function (info) {
        this.apiInfo = info;
        this.broadcastInfo();
    };

    this.broadcastInfo= function () {
        $rootScope.$broadcast('handleBroadcast');
    };

    });



