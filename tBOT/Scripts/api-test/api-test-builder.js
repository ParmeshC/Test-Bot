var BuilderApp = angular.module('api.test.builder', []);
BuilderApp.controller('BuilderCtrl', function (BuilderFactory, apiTestBroadcastService, $scope) {


    $scope.$on('handleApiResponseListBroadcast', function () {
        $scope.RequestResponseList = apiTestBroadcastService.sharedObjects.ApiResponseList;
    });

    $scope.$on('handleApiResponseInfoBroadcast', function () {
        $scope.RequestResponse = apiTestBroadcastService.sharedObjects.ApiResponseInfo;
    });

    $scope.sortType = "TestCaseResult.Status";
    $scope.sortReverse = true;

    $scope.oneAtATime = false;
    $scope.openStatus = true;

    $scope.checkStatus = function () {
        $scope.openStatus = !$scope.oneAtATime;
    }

});

BuilderApp.factory('BuilderFactory', function ($http) {
    return {

        addTestCasesToDB: function (testCase) {
            return $http.post("/Builder/AddTestCases", testCase);
        }

    };
});