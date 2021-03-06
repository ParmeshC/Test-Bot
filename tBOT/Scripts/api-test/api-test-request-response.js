﻿var RequestResponseApp = angular.module('api.test.request.response', []);
RequestResponseApp.controller('RequestResponseCtrl', function ($scope, $timeout, $q, RequestResponseFactory, apiTestBroadcastService) {

    $scope.showCounter = false;

    $scope.$on('handleEndPointComponentBroadcast', function () {
        $scope.EditableEndPointComponent = apiTestBroadcastService.sharedObjects.EndPointComponent;
    });


    $scope.$on('handleRequestObjectsAndTestCasesAppliedBroadcast', function () {
        $scope.ApiRequestObjectList = apiTestBroadcastService.sharedObjects.RequestObjectsAndTestCasesApplied; 
        $scope.GetResponseRequest();
    });

    $scope.$on('handleExecutionCancelBroadcast', function () {
        CancelRequest();
    });

    $scope.getApiInfo = function (RequestResponse) {
            apiTestBroadcastService.globalBroadcast('ApiResponseInfo', RequestResponse);
    };


    var sendRequestResponseInfo = function (RequestResponseList) {
        apiTestBroadcastService.globalBroadcast('RequestResponseInfo', RequestResponseList);
    };



    $scope.ClearResult = function () {
        $scope.RequestResponseList = [];
        apiTestBroadcastService.globalBroadcast('ApiResponseInfo', null)
        apiTestBroadcastService.globalBroadcast('RequestResponseInfo', null);
        $scope.showCounter = false;
    };


    $scope.sortType = 'EndPoint'; // set the default sort type
    $scope.sortReverse = false;  // set the default sort order

    $scope.DesignTestCase = function (designTestTemplate) {
        apiTestBroadcastService.globalBroadcast('DesignTestTemplate', designTestTemplate)
    };

    var CancelRequest = function () {
        $scope.canceler.resolve("http call aborted");
        $scope.resolved = false;
        $scope.stopTimeout();
        $scope.showCounter = false;
    };

    var RequestComponents = [
        'AuthType',
        'UserName',
        'Password',
        'Accept',
        'ContentType',
        'LanguageCode',
        'RequestMethod',
        'RequestUrl',
        'RequestBody',
        'EndPoint',
        'EndPointObjectId'
    ];

    var GetResponseRequestHelper = function () {
        angular.forEach($scope.ApiRequestObjectList, function (info) {

            var testCondtion = { 'Request': {} };
            angular.forEach(RequestComponents, function (comp) {
                for (prop in info) {                    
                    if (comp === prop) {
                        testCondtion['Request'][prop] = info[prop];
                    } 
                }
            });
            testCondtion = Object.assign({}, info, testCondtion);


            angular.forEach(info.TestCaseList, function (TestCase) {
                if (TestCase.selected) {
                    $scope.requestData.push({
                        "ApiEndPoint": testCondtion.Request.EndPoint,
                        "TestCaseCondition": JSON.stringify(testCondtion),
                        "TestCaseName": TestCase.Name
                    });
                }
            });

        });
    }

    $scope.resolved = false;
    $scope.GetResponseRequest = function () {

        $scope.canceler = $q.defer();
        $scope.resolved = true;
        $scope.counter = 0;
        $scope.showCounter = true;
        $scope.startTimeout();

        $scope.requestData = [];

        apiTestBroadcastService.globalBroadcast('ApiResponseList', null);
        apiTestBroadcastService.globalBroadcast('ApiResponseInfo', null);
        

        GetResponseRequestHelper();


        RequestResponseFactory.getApiResponseList($scope).then(function (value) {
            $scope.RequestResponseList = value.data;
            sendRequestResponseInfo($scope.RequestResponseList);
            $scope.resolved = false;
            $scope.stopTimeout();
            console.log(value); // "Success!"
            return Promise.reject('oh, no!');
        }).catch(function (e) {
            console.log(e); // "oh, no!"
        }).then(function () {
            console.log('after a catch the chain is restored');
        }, function () {
            console.log('Not fired due to the catch');
            });
        

    };



    //*****************Timmer*******
    $scope.counter = 0;
    $scope.startTimeout = function () {
        $scope.counter = $scope.counter + 1;
        mytimeout = $timeout($scope.startTimeout, 1000);
    }
    

    $scope.stopTimeout = function () {
        $timeout.cancel(mytimeout);
    }  
    //*****************Timmer*******
});

RequestResponseApp.factory('RequestResponseFactory', function ($http) {
    return {

        getApiResponseList: function (scp) {
            var config =
                {
                    //headers: 'Content-Type': 'text/plain;'
                    timeout: scp.canceler.promise
                }
            return $http.post("/Planner/GetApiResponseList", scp.requestData, config);
        },

        getEndPointObjectComponents: function (item) {
            return $http.post("/Planner/GetEndPointObjectComponent", item);
        }


    };
});