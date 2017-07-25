var PlannerApp = angular.module('api.test.planner', []);
PlannerApp.controller('PlannerCtrl', function (PlannerFactory, apiTestSharedService, $scope) {    

    $scope.$on('handleApiInfoBroadcast', function () {
        $scope.ApiInfo = apiTestSharedService.apiInfo;
        $scope.updateApiInfo();
    });

    $scope.updateApiInfo = function () {
        $scope.ApiInfoUrl = "http://" + $scope.apiEnv.Server + "/" + $scope.ApiInfo.APP + "/" + $scope.ApiInfo.Connector + "/" + $scope.ApiInfo.EndPoint;
        $scope.ApiInfoSchema = $scope.ApiInfo.SchemaUrl
        $scope.ApiInfoVersion = $scope.ApiInfo.Version
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
    $scope.requestData = {};
    $scope.apiRequest = function () {
         $scope.requestData["AuthType"] = $scope.apiAuth.Type;
        $scope.requestData["UserName"] = $scope.apiAuth.UserName;
        $scope.requestData["Password"] = $scope.apiAuth.Password;
        $scope.requestData["Lang"] = "en-in";
        $scope.requestData["Accept"] = "application/json";
        $scope.requestData["ContentType"] = "application/json";
        $scope.requestData["RequestMethod"] = "GET";
        $scope.requestData["RequestUrl"] = $scope.ApiInfoUrl;
        $scope.requestData["RequestBody"] = "";
        $scope.requestData["EndPoint"] = $scope.ApiInfo.EndPoint;
        $scope.requestData["RawschemaUrl"] = $scope.ApiInfoSchema;
        $scope.requestData["Version"] = $scope.ApiInfo.Version;

        PlannerFactory.getApiResponse($scope).then(function (d) {
            $scope.results = d.data;
            $scope.reqestStatus = false;
            $scope.requestResult = true;    

            console.log($scope.results);
            //apiTestSharedService.ApiRsponseInfoBroadcast($scope.results);
        });

    };


});

PlannerApp.factory('PlannerFactory', function ($http) {
    return {

        getApiResponse: function (scp) {
            return $http.post("/Planner/GetApiResponse", scp.requestData);
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