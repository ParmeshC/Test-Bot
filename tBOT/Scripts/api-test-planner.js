var PlannerApp = angular.module('api.test.planner', []);
PlannerApp.controller('PlannerCtrl', function (PlannerFactory, apiTestSharedService, $scope) {    

    $scope.$on('handleApiRequestListBroadcast', function () {
        $scope.ApiRequestList = apiTestSharedService.apiRequestList;

    });

    $scope.sortType = 'Status'; // set the default sort type
    $scope.sortReverse = false;  // set the default sort order


    $scope.getApiInfo = function (ResponseResult) {
        $scope.responseResult = ResponseResult;
        apiTestSharedService.apiResponseInfoBroadcast(ResponseResult);
    };


    $scope.envOptions;
    PlannerFactory.getEnvironments().then(function (d) {
        $scope.envOptions = d.data;        
        $scope.apiEnv = $scope.envOptions[0];
    });
        
    
    $scope.authOptions;
    PlannerFactory.getAuthorizations().then(function (d) {
        $scope.authOptions = d.data;
        $scope.apiAuth = $scope.authOptions[0];
    });

    
    $scope.AppOptions = [{ app: "IntegrationApi", id: 1 }, { app: "StudentApi", id: 2 }];
    $scope.apiApp = $scope.AppOptions[0];

    $scope.reqestStatus = false;
    $scope.results = [];
    $scope.requestData = [];
    $scope.apiRequest = function () {
        $scope.requestData.splice(0, $scope.requestData.length);//deletes all the items in the array
        $scope.reqestStatus = true;
        apiTestSharedService.apiResponseListBroadcast(null);
        apiTestSharedService.apiResponseInfoBroadcast(null);
        angular.forEach($scope.ApiRequestList, function (info) {
            $scope.requestData.push({
                ["AuthType"]: $scope.apiAuth.Type,
                ["UserName"]: $scope.apiAuth.UserName,
                ["Password"]: $scope.apiAuth.Password,
                ["Lang"]: "en-in",
                ["Accept"]: "application/json",
                ["ContentType"]: "application/json",
                ["RequestMethod"]: "GET",
                ["RequestUrl"]: "http://" + $scope.apiEnv.Server + "/" + info.APP + "/" + info.Connector + "/" + info.EndPoint,
                ["RequestBody"]: "",
                ["EndPoint"]: info.EndPoint,
                ["RawschemaUrl"]: info.SchemaUrl,
                ["Version"]: info.Version
            });
        });
        $scope.results.splice(0, $scope.results.length);//deletes all the items in the array
        PlannerFactory.getApiResponseList($scope).then(function (d) {
            $scope.results = d.data;
            $scope.reqestStatus = false;
            apiTestSharedService.apiResponseListBroadcast($scope.results);
        });

    };


});

PlannerApp.factory('PlannerFactory', function ($http) {
    return {

        getApiResponse: function (scp) {
            return $http.post("/Planner/GetApiResponse", scp.requestData);
        },

        getApiResponseList: function (scp) {
            return $http.post("/Planner/GetApiResponseList", scp.requestData);
        },

        getEnvironments: function () {
            return $http.get("/Planner/GetAllEnvironments");
        },

        getAuthorizations: function () {
            return $http.get("/Planner/GetAllAuthorizations");
        }

    };
});