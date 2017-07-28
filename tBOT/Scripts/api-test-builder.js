var BuilderApp = angular.module('api.test.builder', []);

BuilderApp.controller('BuilderCtrl', function ($scope, apiTestSharedService) {


    $scope.$on('handleApiResponseInfoBroadcast', function () {
        $scope.ApiResponseInfo = apiTestSharedService.apiResponseInfo;
        console.log($scope.ApiResponseInfo)
    });




});