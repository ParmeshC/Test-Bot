var DesignExecutionApp = angular.module('api.test.design.execution', []);
DesignExecutionApp.controller('DesignExecutionCtrl', function (DesignExecutionFactory, apiTestBroadcastService, $scope, $q) {




    $scope.$on('handleExecuteEndPointObjectIdBroadcast', function () {
        var executeEndPointObjectId = {'EndPointObjectId':apiTestBroadcastService.sharedObjects.ExecuteEndPointObjectId };
        DesignExecutionFactory.getEndPointObjectComponentsforEndPointObjectId(executeEndPointObjectId).then(function (d) {
            $scope.ObjectComponent = JSON.parse(d.data);


            DesignExecutionFactory.getEndPointComponentsAsJsonString().then(function (d) {
                $scope.GlobalComponent = JSON.parse(d.data);

            });
       
        });
    });
    
    
    $scope.$on('handleExecuteEndPointObjectGroupSectionBroadcast', function () {    
        var executeEndPointObjectGroupSection = { 'EndPointObjectGroupSection':apiTestBroadcastService.sharedObjects.ExecuteEndPointObjectGroupSection };
        DesignExecutionFactory.getEndPointObjectComponentsForEndPointObjectGroupSection(executeEndPointObjectGroupSection).then(function (d) {
            $scope.ObjectComponent = JSON.parse(d.data);


            DesignExecutionFactory.getEndPointComponentsAsJsonString().then(function (d) {
                $scope.GlobalComponent = JSON.parse(d.data);
            });

        });
    });
    

    DesignExecutionFactory.getTestTemplates().then(function (d) {
        $scope.TestTemplates = d.data.List;
    });


    DesignExecutionFactory.getEnvironments().then(function (d) {
        $scope.envOptions = d.data;
        $scope.apiEnv = $scope.envOptions[0];
    });


    DesignExecutionFactory.getTestCases().then(function (d) {
        $scope.TestCasesList = d.data;
    });


    $scope.authOptions;
    DesignExecutionFactory.getAuthorizations().then(function (d) {
        $scope.authOptions = d.data;
        $scope.apiAuth = $scope.authOptions[0];
    });


    $scope.AppOptions = [{ app: "IntegrationApi", id: 1 }, { app: "StudentApi", id: 2 }];
    $scope.apiApp = $scope.AppOptions[0];



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
        apiTestBroadcastService.globalBroadcast('DesignTestTemplate', designTestTemplate)
    };

    $scope.CancelRequest = function () {
        $scope.canceler.resolve("http call aborted");
        $scope.resolved = false;
    };

 
    var GetResponseRequestHelper = function () {
        var processingObjects = [];
        var row = -1;
        angular.forEach($scope.ObjectComponent, function (ObjectComponent) {            

            var GlobalComponent={} = $scope.GlobalComponent[0];
            row = row+1;

            for (ObjectComponentKey in ObjectComponent) {
                if (ObjectComponentKey === 'EndPoint') {
                    processingObjects.push({ [ObjectComponentKey]: ObjectComponent[ObjectComponentKey] });                    
                }
                else
                {
                    ObjectComponent[ObjectComponentKey] = eval(ObjectComponent[ObjectComponentKey]);
                }
            }

            for (GlobalComponentKey in GlobalComponent)
            {
                if (GlobalComponent[GlobalComponentKey] != '')
                {
                        processingObjects[row][GlobalComponentKey] = eval(GlobalComponent[GlobalComponentKey]);
                }
                else
                {
                        processingObjects[row][GlobalComponentKey] = GlobalComponent[GlobalComponentKey];
               
                }
            }
                

        });

        console.log(processingObjects)
    }

    $scope.resolved = false;
    $scope.GetResponseRequest = function () {

        $scope.canceler = $q.defer();
        $scope.resolved = true;

        $scope.requestData = [];
        //var GlobalSettings = {};

        //apiTestBroadcastService.globalBroadcast('ApiResponseList', null);
        //apiTestBroadcastService.globalBroadcast('ApiResponseInfo', null);


        GetResponseRequestHelper();

        //console.log($scope.requestData)


    //    RequestResponseFactory.getApiResponseList($scope).then(function (value) {
    //        $scope.RequestResponseList = value.data;
    //        $scope.resolved = false;
    //        console.log(value); // "Success!"
    //        return Promise.reject('oh, no!');
    //    }).catch(function (e) {
    //        console.log(e); // "oh, no!"
    //    }).then(function () {
    //        console.log('after a catch the chain is restored');
    //    }, function () {
    //        console.log('Not fired due to the catch');
    //    });

    };


});

DesignExecutionApp.factory('DesignExecutionFactory', function ($http) {
    return {

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
        },

        getEndPointComponentsAsJsonString: function () {
            return $http.get("/Planner/GetEndPointComponentsAsJsonString");
        },

        getEndPointObjectComponentsForEndPointObjectGroupSection: function (endPointObjectGroupSection) {
            return $http.post("/Planner/GetEndPointObjectComponentsForEndPointObjectGroupSection", endPointObjectGroupSection);
        },

        getEndPointObjectComponentsforEndPointObjectId: function (endPointObjectId) {
            return $http.post("/Planner/GetEndPointObjectComponentsforEndPointObjectId", endPointObjectId);
        },

        getApiResponseList: function (scp) {
            var config =
                {
                    //headers: 'Content-Type': 'text/plain;'
                    timeout: scp.canceler.promise
                }
            return $http.post("/Planner/GetApiResponseList", scp.requestData, config);
        }

    };
});