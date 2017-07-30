var BuilderApp = angular.module('api.test.builder', []);

BuilderApp.controller('BuilderCtrl', function ($scope, apiTestSharedService) {


    $scope.$on('handleApiResponseListBroadcast', function () {
        $scope.ApiResponseList = apiTestSharedService.apiResponseList;
        console.log($scope.ApiResponseList);
    });



    $scope.$on('handleApiResponseInfoBroadcast', function () {
        $scope.ApiResponseInfo = apiTestSharedService.apiResponseInfo;
    });



});