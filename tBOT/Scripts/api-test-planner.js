var PlannerApp = angular.module('api.test.planner', []);
PlannerApp.controller('PlannerCtrl', function (PlannerFactory, apiTestSharedService, $scope) {    

    $scope.$on('handleApiInfoBroadcast', function () {
        $scope.ApiInfo = apiTestSharedService.apiInfo;
        if ($scope.ApiInfo.length > 0)
        {
            $scope.updateApiInfo($scope.ApiInfo[0]);
        }
    });

    $scope.updateApiInfo = function (info) {
        $scope.ApiInfoUrl = "http://" + $scope.apiEnv.Server + "/" + info.APP + "/" + info.Connector + "/" + info.EndPoint;
        $scope.ApiInfoSchema = info.SchemaUrl
        $scope.ApiInfoVersion = info.Version
    }

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


    //$scope.requestResult = false;
    //$scope.reqestStatus = false;
    //$scope.results = [];
    //$scope.apiRequest = function () {
    //    $scope.reqestStatus = true;
    //    $scope.requestResult = false;
    //    PlannerFactory.getApiResponse($scope).then(function (d) {
    //        $scope.results = d.data;
    //        $scope.reqestStatus = false;
    //        $scope.requestResult = true;
    //    });
    //}

    $scope.requestResult = false;
    $scope.reqestStatus = false;
    $scope.results = [];
    $scope.requestData = [];
    $scope.apiRequest = function () {
        angular.forEach($scope.ApiInfo, function (info) {
            $scope.requestData.push({
                ["AuthType"]:$scope.apiAuth.Type,
                ["UserName"]: $scope.apiAuth.UserName,
                ["Password"]: $scope.apiAuth.Password,
                ["Lang"]: "en-in",
                ["Accept"]:"application/json",
                ["ContentType"]:"application/json",
                ["RequestMethod"]:"GET",
                ["RequestUrl"]:"http://" + $scope.apiEnv.Server + "/" + info.APP + "/" + info.Connector + "/" + info.EndPoint,
                ["RequestBody"]:"",
                ["EndPoint"]:info.EndPoint,
                ["RawschemaUrl"]:info.SchemaUrl,
                ["Version"]:info.Version
            });           
        })
        PlannerFactory.getApiResponseList($scope).then(function (d) {
            $scope.results = d.data;
            $scope.reqestStatus = false;
            $scope.requestResult = true;
            //apiTestSharedService.ApiRsponseInfoBroadcast($scope.results);
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

        //getApiResponse: function (scp) {
        //    return $http.get("/Planner/GetApiResponse"
        //        + "?SrvNm=" + scp.apiEnv.Server                
        //        + "&UsrNm=" + scp.apiAuth.UserName
        //        + "&PassWrd=" + scp.apiAuth.Password
        //        + "&AuthType=" + scp.apiAuth.Type
        //        + "&ApiAPP=" + scp.apiApp.app
        //        + "&ApiEndPoint=" + scp.apiEndPoint
        //        );
        //},

        getEnvironments: function () {
            return $http.get("/Planner/GetAllEnvironments");
        },

        getAuthorizations: function () {
            return $http.get("/Planner/GetAllAuthorizations");
        }

    };
})