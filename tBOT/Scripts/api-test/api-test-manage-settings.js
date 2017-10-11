var ManageSettingsApp = angular.module('api.test.manage.settings', []);

ManageSettingsApp.controller('ManageSettingsCtrl', function (ManageSettingsFactory, apiTestBroadcastService, $scope) {

    $scope.ManageSettings = [{ type: "Manage Users", id: 1 }, { type: "Manage Instances", id: 2 }, { type: "Manage Components", id: 3 }, { type: "Import Components", id: 4 }];

    $scope.ChooseSettings = function (val) {
        //this code helps to close the javascript editor in the planner area
        apiTestBroadcastService.globalBroadcast('EditableComponent', undefined)

        $scope.settingType = val;
        if (val === undefined) $scope.EditEndPointComponent(undefined);
    };

    //**************Instance****************
    ManageSettingsFactory.getInstances().then(function (d) {
        $scope.Instances = d.data;
    });

    $scope.EditInstance = function (Instance) {
        console.log(Instance);
    };

    $scope.NewInstance = { Value: '' };
    $scope.$watch('NewInstance.Value', function (newValue, oldValue) {
        $scope.ValidInstance = { status: false };
        if (newValue === undefined || newValue === '') {
            $scope.ValidInstance = undefined;
            $scope.NewInstance.Value = newValue === undefined ? oldValue : '';
        }
        else {
            angular.forEach($scope.Instances, function (itm) {
                {
                    if (itm.Name !== newValue && $scope.ValidInstance !== undefined) {
                        $scope.ValidInstance.status = true
                    }
                    else {
                        $scope.ValidInstance = undefined;
                        return false;
                    }
                }
            });
        }
    });

    $scope.AddInstance = function (val) {
        console.log(val)
    };
    //**************Instance****************


    //**************EndPointComponent****************
    ManageSettingsFactory.getEndPointComponents().then(function (d) {
        $scope.EndPointComponents = d.data;
    });


    //***********start-using apiTestBroadcastService********************
    $scope.EditEndPointComponent = function (EndPointComponentId) {
        apiTestBroadcastService.globalBroadcast('EditableComponent', { "EndPointComponentId": EndPointComponentId })
    }
    //***********end-using apiTestBroadcastService********************

    //***********start-Validate EndPointComponent********************
    $scope.NewComponent = { Value: '' };
    $scope.$watch('NewComponent.Value', function (newValue, oldValue) {
        $scope.ValidComponent = { status: false };
        if (newValue === undefined || newValue === '') {
            $scope.ValidComponent = undefined;
            $scope.NewComponent.Value = newValue === undefined ? oldValue : '';
        }
        else {
            if ($scope.EndPointComponents.length === 0) { $scope.ValidComponent.status = true }
            angular.forEach($scope.EndPointComponents, function (itm) {
                {
                    if (itm.Name !== newValue && $scope.ValidComponent !== undefined) {
                        $scope.ValidComponent.status = true
                    }
                    else {
                        $scope.ValidComponent = undefined;
                        return false;
                    }
                }
            });
        }
    });
    //***********end-Validate EndPointComponent********************

    $scope.AddEndPointComponent = function (val) {

        //this code helps to close the javascript editor in the planner area
        apiTestBroadcastService.globalBroadcast('EditableComponent', undefined)

        var endPointComponentInfo = { "InstanceId": 1, "ComponentName": val };
        ManageSettingsFactory.addEndPointComponent(endPointComponentInfo).then(function (d) {
            console.log(d.data)
            //refresh the data after insertion
            ManageSettingsFactory.getEndPointComponents().then(function (d) {
                $scope.EndPointComponents = d.data;
            });
            $scope.NewComponent.Value = '';
        });
    }
    //**************EndPointComponent****************

});


ManageSettingsApp.factory('ManageSettingsFactory', function ($http) {
    return {

        getEndPointComponents: function () {
            return $http.get("/Routine/GetEndPointComponents");
        },

        getInstances: function () {
            return $http.get("/Routine/GetInstances");
        },

        addEndPointComponent: function (endPointComponentInfo) {
            return $http.post("/Routine/AddEndPointComponent", endPointComponentInfo);
        }

    };
});