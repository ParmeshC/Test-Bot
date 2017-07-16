var PlannerApp = angular.module('api.test.planner', []);
PlannerApp.controller('PlannerCtrl', function (PlannerFactory, apiTestSharedService, $scope) {    

    $scope.$on('handleBroadcast', function () {
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


    $scope.requestResult = false;
    $scope.reqestStatus = false;
    $scope.results = [];
    $scope.apiRequest = function () {
        $scope.reqestStatus = true;
        $scope.requestResult = false;
        envService.getApiResponse($scope).then(function (d) {
            $scope.results = d.data;
            $scope.reqestStatus = false;
            $scope.requestResult = true;
        });
    }
});

PlannerApp.factory('PlannerFactory', function ($http) {
    return {

        getApiResponse: function (scp) {
            return $http.get("/Planner/GetApiResponse"
                + "?SrvNm=" + scp.apiEnv.Server                
                + "&UsrNm=" + scp.apiAuth.UserName
                + "&PassWrd=" + scp.apiAuth.Password
                + "&AuthType=" + scp.apiAuth.Type
                + "&ApiAPP=" + scp.apiApp.app
                + "&ApiEndPoint=" + scp.apiEndPoint
                );
        },

        getEnvironments: function () {
            return $http.get("/Planner/GetAllEnvironments");
        },

        getAuthorizations: function () {
            return $http.get("/Planner/GetAllAuthorizations");
        }

    };
})