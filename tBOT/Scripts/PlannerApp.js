var PlannerApp = angular.module('PlannerApp', ['ui.bootstrap']);
PlannerApp.controller('PlannerCtrl', function (envService, $scope) {    

    $scope.apiName;
    
     
    $scope.envOptions;
    envService.getEnvironments().then(function (d) {
        $scope.envOptions = d.data;        
        $scope.apiEnv = $scope.envOptions[0];        
    });
        
    
    $scope.authOptions;
    envService.getAuthorizations().then(function (d) {
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

PlannerApp.factory('envService', function ($http) {
    return {

        getApiResponse: function (scp) {
            return $http.get("/Planner/GetApiResponse"
                + "?SrvNm=" + scp.apiEnv.Server                
                + "&Port=" + scp.apiEnv.Port
                + "&UsrNm=" + scp.apiAuth.UserName
                + "&PassWrd=" + scp.apiAuth.Password
                + "&AuthType=" + scp.apiAuth.Type
                + "&ApiAPP=" + scp.apiApp.app
                + "&ApiName=" + scp.apiName
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

//PlannerApp.filter("prettyJSON", () => json => JSON.stringify(json, null, " "))


