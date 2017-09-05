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
        $scope.ValidationInfo.List[item]['isOpen'] = $scope.ValidationInfo.List[item]['isOpen'] === undefined ? true : !$scope.ValidationInfo.List[item]['isOpen'];
        if (this.oneAtATime && $scope.ValidationInfo.List[item]['isOpen'] === true) {
            var prop;
            for (prop in $scope.ValidationInfo.List) {
                $scope.ValidationInfo.List[prop]['isOpen'] = prop !== item ? false : true;
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