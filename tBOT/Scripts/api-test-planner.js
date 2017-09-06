var PlannerApp = angular.module('api.test.planner', []);
PlannerApp.controller('PlannerCtrl', function (PlannerFactory, apiTestSharedService, $scope) {    

    $scope.$on('handleApiRequestListBroadcast', function () {
        $scope.ApiRequestList = apiTestSharedService.apiRequestList;


    $scope.getApiInfo = function (RequestResponse) {
        apiTestSharedService.apiResponseInfoBroadcast(RequestResponse);
        };



    $scope.ClearResponse = function () {
        $scope.RequestResponseList = [];
        apiTestSharedService.apiResponseInfoBroadcast(null);
    }

        
     PlannerFactory.getTestTemplates().then(function (d) {
            $scope.TestTemplates = d.data.List;   
        });
    });
    

    PlannerFactory.getEnvironments().then(function (d) {
        $scope.envOptions = d.data;        
        $scope.apiEnv = $scope.envOptions[0];
    });


    PlannerFactory.getTestCases().then(function (d) {        
        $scope.TestCasesList = d.data;
    });

    
    $scope.authOptions;
    PlannerFactory.getAuthorizations().then(function (d) {
        $scope.authOptions = d.data;
        $scope.apiAuth = $scope.authOptions[0];
    });


    $scope.AppOptions = [{ app: "IntegrationApi", id: 1 }, { app: "StudentApi", id: 2 }];
    $scope.apiApp = $scope.AppOptions[0];




    $scope.sortType = 'EndPoint'; // set the default sort type
    $scope.sortReverse = false;  // set the default sort order


    //*****************
    //This section helps to toggle with the check box
    $scope.selectedTestCases = [];
    $scope.isAllSelected = false;
    var getAllSelected = function () {
        var selectedItems = $scope.TestCasesList.filter(function (item) {
            return item.selected;
        });
        $scope.selectedTestCases = selectedItems;
    };

    $scope.toggleAll = function () {
        //$scope.isAllSelected = !$scope.isAllSelected; //this line of code is needed if it is an array
        var toggleStatus = $scope.isAllSelected;
        angular.forEach($scope.TestCasesList, function (itm) { itm.selected = toggleStatus; });
        getAllSelected();
    };

    $scope.optionToggled = function () {
        $scope.isAllSelected = $scope.TestCasesList.every(function (itm) { return itm.selected; });
        getAllSelected();
    };
    //*****************



    $scope.DesignTestCase = function (designTestTemplate) {
        apiTestSharedService.designTestTemplateBroadcast(designTestTemplate); 

    };




    $scope.reqestStatus = false;
    $scope.results = [];
    $scope.requestData = [];
    var GlobalSettings = {};
    $scope.GetResponseRequest = function () {
        //$scope.requestData.splice(0, $scope.requestData.length);//deletes all the items in the array
        $scope.reqestStatus = true;
        apiTestSharedService.apiResponseListBroadcast(null);
        apiTestSharedService.apiResponseInfoBroadcast(null);
        angular.forEach($scope.ApiRequestList, function (info) {

            angular.forEach($scope.selectedTestCases, function (TestCaseSelected) {  

                GlobalSettings = {
                    "Request": {
                        "Environment": {
                            "App": {
                                "Server": $scope.apiEnv.AppServer
                            },
                            "DB": {
                                "HostName": "149.24.38.229",
                                "PortNumber": "1521",
                                "ServiceName": "BAN83",
                                "UserId": "baninst1",
                                "Password": "u_pick_it"
                            }
                        },
                        "Authorization": {
                            "AuthType": $scope.apiAuth.Type,
                            "UserName": $scope.apiAuth.UserName,
                            "Password": $scope.apiAuth.Password
                        },
                        "Accept": "application/json",
                        "ContentType": "application/json",
                        "LanguageCode": "en-in",
                        "RequestMethod": "GET",
                        "RequestUrl": "http://" + $scope.apiEnv.AppServer + "/" + info.APP + "/" + info.Connector + "/" + info.EndPoint,
                        "RequestBody": "",
                        "EndPoint": info.EndPoint
                    },
                    "RawschemaUrl": info.SchemaUrl,
                    "Version": info.Version,
                    "TotalCountQuery":""
                };

                var testCondtion = JSON.parse(TestCaseSelected.Condition, (key, value) =>
                     value = typeof value === 'string' ? value.startsWith("GlobalSettings") ? eval(value) : value : value
                 );

                $scope.requestData.push({
                    "ApiEndPoint": GlobalSettings.Request.EndPoint,
                     "TestCaseTemplateName":TestCaseSelected.Template,
                     "TestCaseCondition": JSON.stringify(testCondtion),
                     "TestCaseName": TestCaseSelected.Name
                 });
            });
            

        });

        //$scope.results.splice(0, $scope.results.length);//deletes all the items in the array
        PlannerFactory.getApiResponseList($scope).then(function (d) {
            $scope.RequestResponseList = d.data;
            $scope.reqestStatus = false;
            console.log($scope.RequestResponseList);
        });
    };


});

PlannerApp.factory('PlannerFactory', function ($http) {
    return {

        getApiResponseList: function (scp) { 
            //var config = {headers: {'Content-Type': 'text/plain;'}}
            console.log(scp.requestData);
            return $http.post("/Planner/GetApiResponseList", scp.requestData/*, config*/);
        },

        getTestTemplates: function (scp) {
            return $http.post("/Planner/GetAllTestTemplates");
        },

        getEnvironments: function () {
            return $http.get("/Planner/GetAllEnvironments");
        },

        getAuthorizations: function () {
            return $http.get("/Planner/GetAllAuthorizations");
        },
        getTestCases: function () {
            return $http.get("/Planner/GetAllTestCases");
        }

    };
});