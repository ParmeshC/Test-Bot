var BuilderApp = angular.module('api.test.builder', []);

BuilderApp.controller('BuilderCtrl', function (BuilderFactory, apiTestSharedService, $scope) {

    $scope.$on('handleApiResponseListBroadcast', function () {
        $scope.RequestResponseList = apiTestSharedService.apiResponseList;
    });

    $scope.$on('handleApiResponseInfoBroadcast', function () {
        $scope.RequestResponse = apiTestSharedService.apiResponseInfo;
    });


    $scope.sortType = "TestCaseResult.Status";
    $scope.sortReverse = true;


    $scope.oneAtATime = true;
    $scope.collapse = function myfunction(item) {
        $scope.RequestResponse.TestCasesList[item]['isOpen'] = $scope.RequestResponse.TestCasesList[item]['isOpen'] === undefined ? true : !$scope.RequestResponse.TestCasesList[item]['isOpen'];
        if (this.oneAtATime && $scope.RequestResponse.TestCasesList[item]['isOpen'] === true) {
            var prop;
            for (prop in $scope.RequestResponse.TestCasesList) {
                $scope.RequestResponse.TestCasesList[prop]['isOpen'] = prop !== item ? false : true;
            }
        }
    };

});


BuilderApp.factory('BuilderFactory', function ($http) {
    return {

        addTestCasesToDB: function (testCase) {
            return $http.post("/Builder/AddTestCases", testCase);
        }

    };
});