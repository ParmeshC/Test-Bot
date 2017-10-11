var EndPointCreateEditApp = angular.module('api.test.endpoint.create.edit', []);

EndPointCreateEditApp.controller('EndPointCreateEditCtrl', function (EndPointCreateEditFactory, apiTestBroadcastService, $scope, $timeout) {

    //***********start-using apiTestBroadcastService********************
    $scope.EditEndPointObjectComponent = function (EndPointObjectComponentId) {
        apiTestBroadcastService.globalBroadcast('EditableComponent', { "EndPointObjectComponentId": EndPointObjectComponentId })        
    }
    //***********end-using apiTestBroadcastService********************


    //this code helps to gets the notification to refresh data in the Group
    $scope.$on('handleEndPointObjectGroupChangedBroadcast', function () {

        //just calling the below function which does both needed data refresh
        if ($scope.Object.EndPointObjectId !== undefined) {
            $scope.GetEndPointObjectGroups($scope.Object.EndPointObjectId)
        }
    });


    //**********************start-Get EndPoints***********
    var instanceId = { "InstanceId": 1 };
    EndPointCreateEditFactory.getEndPoints(instanceId).then(function (d) {
        $scope.EndPoints = d.data;
    });

    var GetEndPoints = function () {
    EndPointCreateEditFactory.getEndPoints(instanceId).then(function (d) {
        $scope.EndPoints = d.data;
    });
    }
    //**********************end-Get EndPoints*************

    //**********************start-Get EndPointObjectCount***********
    EndPointCreateEditFactory.getEndPointObjectCount().then(function (d) {
        $scope.EndPointObjectCount = d.data;
    });

    var GetEndPointObjectCount = function () {
        EndPointCreateEditFactory.getEndPointObjectCount().then(function (d) {
            $scope.EndPointObjectCount = d.data;
        });
    }
    //**********************end-Get EndPointObjectCount*************
    

    //***********start-Add EndPoint********************
    $scope.AddEndPoint = function (val) {

        var endPointInfo = { "InstanceId": 1, "EndPointName": val };
        EndPointCreateEditFactory.addEndPoint(endPointInfo).then(function (d) {
        console.log(d.data)
             //refresh the data after insertion
            GetEndPointObjectCount()
            GetEndPoints();  
            $scope.NewEndPoint.Value = '';
        });
    }
     //***********end-Add EndPoint********************


    //***********start-Remove EndPoint********************
    $scope.RemoveEndPoint = function (endPointId) {

        var endpointId = { "EndPointId": endPointId };
        EndPointCreateEditFactory.removeEndPoint(endpointId).then(function (d) {
            console.log(d.data)
            //refresh the data after insertion
            GetEndPointObjectCount()
            GetEndPoints();
            $scope.NewEndPoint.Value = '';
        });
    }
     //***********end-Remove EndPoint********************


      //***********start-Validate EndPoint********************
    $scope.NewEndPoint = { Value: '' };
    $scope.$watch('NewEndPoint.Value', function (newValue, oldValue) {
        $scope.ValidEndPoint = { status: false };
        if (newValue === undefined || newValue === '') {
            $scope.ValidEndPoint = undefined;
            $scope.NewEndPoint.Value = newValue === undefined ? oldValue : '';
        }
        else {
            if ($scope.EndPoints.length === 0) { $scope.ValidEndPoint.status = true }
            angular.forEach($scope.EndPoints, function (itm)
            {
                    if (itm.EndPoint !== newValue && $scope.ValidEndPoint !== undefined) {
                        $scope.ValidEndPoint.status = true
                    }
                    else {
                        $scope.ValidEndPoint = undefined;
                        return false;
                    }
            });
        }
    });
    //***********end-Validate EndPoint********************



    //**********************start-Get Selected EndPointObjects*****
    $scope.GetEndPointObjects = function (endPointId, endPoint) {

        $scope.SelectedGroupedEndPointId = endPointId;
        $scope.SelectedGroupedEndPoint = endPoint;

        var endpointId = { "EndPointId": endPointId };
        EndPointCreateEditFactory.getEndPointObjects(endpointId).then(function (d) {
            $scope.EndPointObjects = d.data;
        })
    }
    //**********************end-Get Selected EndPointObjects***********


    //**************start-Add EndPointObject***************************************
    $scope.AddEndPointObject = function () {
        var endpointId = { "EndPointId": $scope.SelectedGroupedEndPointId };
        EndPointCreateEditFactory.addEndPointObject(endpointId).then(function (d) {

            $scope.ObjectStatus = "Object ID: " + d.data[0].Id + " added...";

            $scope.GetEndPointObjects($scope.SelectedGroupedEndPointId, $scope.SelectedGroupedEndPoint)
        })

        $scope.show = false;
        $timeout(function () {
            $scope.show = true;

        }, 1000);
    };
    //**************end-Add EndPointObject*************************
    $scope.show = true; //part of both 'Add EndPointObject' and 'Remove EndPointObject'
    //**************start-Remove EndPointObject********************
    $scope.RemoveEndPointObject = function (endPointObjectId) {
        var endpointObjectId = { "EndPointObjectId": endPointObjectId };
        EndPointCreateEditFactory.removeEndPointObject(endpointObjectId).then(function (d) {

            $scope.ObjectStatus = "Object ID: " + d.data[0].Id + " removed...";
            $scope.GetEndPointObjects($scope.SelectedGroupedEndPointId, $scope.SelectedGroupedEndPoint)
        })

        $scope.show = false;
        $timeout(function () {
            $scope.show = true;

        }, 1000);
    };
    //**************end-Remove EndPointObject****************************************




    //**********************start-Get Selected EndPoint Components and Object Components***********
    $scope.GetEndPointObjectComponents = function (endPointObjectId) {
        $scope.Object = { "EndPointObjectId": endPointObjectId };

        //**********************start-Get EndPointObjectComponents***********
        EndPointCreateEditFactory.getEndPointObjectComponents($scope.Object).then(function (d) {
            $scope.EndPointObjectComponents = d.data;

            //**********************start-Get EndPointComponents***********
            EndPointCreateEditFactory.getEndPointComponents().then(function (d) {
                $scope.EndPointComponents = d.data;

                //**********************start-Filter EndPointComponents based on EndPointObjectComponents already added***********
                $scope.EndPointObjectComponents.forEach(function (arrayItem) {
                    if (angular.isObject(arrayItem)) {
                        for (prop in arrayItem) {                            
                            if (prop === 'ComponentName') {
                                $scope.EndPointComponents = $scope.EndPointComponents.filter(function (obj) {
                                    return obj.ComponentName !== arrayItem[prop];
                                });
                            }
                        }
                    }
                });
                //**********************end-Filter EndPointComponents based on EndPointObjectComponents already added***********
                $scope.SelectedEndPointComponent = $scope.EndPointComponents[0];
            });
            //**********************end-Get EndPointComponents***********

        });
        //**********************end-Get EndPointObjectComponents*************
    };
    //**********************end-Get Selected EndPoint Components and Object Components**************
    

    //****************start-Add EndPoinObjectComponent****************************************
    $scope.AddEndPointObjectComponent = function () {
        if ($scope.SelectedEndPointComponent !== undefined) {

            //this code helps to close the javascript editor in the planner area
            apiTestBroadcastService.globalBroadcast('EditableComponent', undefined)

            var endPointObjectComponent = { "EndPointObjectId": $scope.Object.EndPointObjectId, "EndPointObjectComponentName": $scope.SelectedEndPointComponent.ComponentName };
            EndPointCreateEditFactory.addEndPointObjectComponent(endPointObjectComponent).then(function (d) {
                //refresh the data after insertion
                $scope.GetEndPointObjectComponents($scope.Object.EndPointObjectId)
            });

            $scope.EndPointComponents = $scope.EndPointComponents.filter(function (obj) {
                return obj.ComponentName !== $scope.SelectedEndPointComponent.ComponentName;
            });
            $scope.SelectedEndPointComponent = $scope.EndPointComponents[0];
        }
    };
    //****************end-Add EndPoinObjectComponent***************
    //****************start-Remove EndPoinObjectComponent**********
    $scope.RemoveEndPoitObjectComponent = function (endPointObjectComponentId) {

        //this code helps to close the javascript editor in the planner area
        apiTestBroadcastService.globalBroadcast('EditableComponent', undefined)

        var endpointObjectComponentId = { "EndPointObjectComponentId": endPointObjectComponentId};
        EndPointCreateEditFactory.removeEndPointObjectComponent(endpointObjectComponentId).then(function (d) {
            console.log(d.data);
            //refresh the data after insertion
            $scope.GetEndPointObjectComponents($scope.Object.EndPointObjectId)
        });
    };
    //****************end-Remove EndPoinObjectComponent******************************************


    //**********************start-Get EndPointObjectGroups***********
    $scope.GetEndPointObjectGroups = function (endPointObjectId) {
        $scope.Object = { "EndPointObjectId": endPointObjectId };
        EndPointCreateEditFactory.getEndPointObjectGroups($scope.Object).then(function (d) {
            $scope.EndPointObjectGroups = d.data

            //**********************start-Get EndPointObjectGroupList***********
            EndPointCreateEditFactory.getEndPointObjectGroupList().then(function (d) {
                $scope.EndPointObjectGroupList = d.data;  
                $scope.FilteredEndPointObjectGroupList = d.data;

                //**********************start-Filter EndPointComponents based on EndPointObjectComponents already added***********
                $scope.EndPointObjectGroups.forEach(function (arrayItem) {
                    if (angular.isObject(arrayItem)) {
                        for (prop in arrayItem) {
                            if (prop === 'EndPointObjectGroupSection') {
                                $scope.FilteredEndPointObjectGroupList = $scope.FilteredEndPointObjectGroupList.filter(function (obj) {
                                    return obj.Section !== arrayItem[prop];
                                });
                            }
                        }
                    }
                });
                //**********************end-Filter EndPointComponents based on EndPointObjectComponents already added***********
                $scope.SelectedEndPointObjectGroup = $scope.FilteredEndPointObjectGroupList[0];
            });
            //**********************end-Get EndPointObjectGroupList***********
        });
    };
    //**********************end-Get EndPointObjectGroups***********


    //****************start-Group EndPointObject****************************************
    $scope.GroupEndPointObject = function () {
        if ($scope.SelectedEndPointObjectGroup !== undefined) {
            var endpointObjectGroupingInfo = { "EndPointObjectId": $scope.Object.EndPointObjectId, "Section": $scope.SelectedEndPointObjectGroup.Section };
            EndPointCreateEditFactory.gropuEndPointObject(endpointObjectGroupingInfo).then(function (d) {
                console.log(d.data);

                //this code helps to notify Group tab to refresh data and also call $scope.GetEndPointObjectGroups() to refresh data
                apiTestBroadcastService.globalBroadcast('EndPointObjectGroupChanged', true)
            });

            $scope.FilteredEndPointObjectGroupList = $scope.FilteredEndPointObjectGroupList.filter(function (obj) {
                return obj !== $scope.SelectedEndPointObjectGroup;
            });
            $scope.SelectedEndPointObjectGroup = $scope.FilteredEndPointObjectGroupList[0];
        }
    };
    //****************end-Group EndPointObject***************
    //****************start-UnGroup EndPoinObject**********
    $scope.UnGroupEndPointObject = function (endPointObjectGroupId) {
        var endpointObjectGroupId = { "EndPointObjectGroupId": endPointObjectGroupId };
        EndPointCreateEditFactory.ungropuEndPointObject(endpointObjectGroupId).then(function (d) {
            console.log(d.data);
            
            //this code helps to notify Group tab to refresh data and also call $scope.GetEndPointObjectGroups() to refresh data
            apiTestBroadcastService.globalBroadcast('EndPointObjectGroupChanged', true)

        });
    };
    //****************end-UnGroup EndPoinObject******************************************



    //***********start-New EndPointObjectGroup********************
    $scope.AddEndPointObjectGroup = function (val) {
        $scope.SelectedEndPointObjectGroup = { 'Section': val }
        $scope.GroupEndPointObject();
        $scope.NewEndPointObjectGroup.Value = '';
    }
    //***********end-New EndPointObjectGroup********************



    //***********start-Validate EndPointObjectGroup********************
    $scope.NewEndPointObjectGroup = { Value: '' };
    $scope.$watch('NewEndPointObjectGroup.Value', function (newValue, oldValue) {        
        $scope.ValidEndPointObjectGroup = { status: false };
        if (newValue === undefined || newValue === '') {
            $scope.ValidEndPointObjectGroup = undefined;
            $scope.NewEndPointObjectGroup.Value = newValue === undefined ? oldValue : '';
        }
        else {
            if ($scope.EndPointObjectGroupList.length === 0){$scope.ValidEndPointObjectGroup.status = true}
            angular.forEach($scope.EndPointObjectGroupList, function (itm) {  
                
                if (itm.Section !== newValue && $scope.ValidEndPointObjectGroup !== undefined) {
                    $scope.ValidEndPointObjectGroup.status = true
                }
                else {
                    $scope.ValidEndPointObjectGroup = undefined;
                    return false;
                }
            });
        }
    });
    //***********end-Validate EndPointObjectGroup********************


    //************start-Execute EndPointObjectId*************
    $scope.ExecuteEndPointObjectId = function (endPointObjectId) {

        //broadcased Enpoint Object to the  Execution
        apiTestBroadcastService.globalBroadcast('ExecuteEndPointObjectId', endPointObjectId )

    }
    //************end-Execute EndPointObjectId*************


    //************start-Previous button*************
    $scope.PreviousClick = function () {

        //this code helps to close the javascript editor in the planner area
        apiTestBroadcastService.globalBroadcast('EditableComponent', undefined)

        if ($scope.EndPointObjectComponents === undefined) {

            if ($scope.EndPointObjectGroups === undefined)
            {
                //refresh previous data when coming back
                EndPointCreateEditFactory.getEndPointObjectCount().then(function (d) {
                    $scope.EndPointObjectCount = d.data;
                });
                //--------
                $scope.EndPointObjects = undefined;
            }
            else
            {
                //refresh previous data when coming back
                $scope.GetEndPointObjects($scope.SelectedGroupedEndPointId, $scope.SelectedGroupedEndPoint);
                //--------
                $scope.EndPointObjectGroups = undefined;
                $scope.Object = undefined;
            }

        }
        else {
            //refresh previous data when coming back
            $scope.GetEndPointObjects($scope.SelectedGroupedEndPointId, $scope.SelectedGroupedEndPoint);
            //--------
            $scope.EndPointObjectComponents = undefined;            
            $scope.Object = undefined;
        }
    };
    //************end-Previous button*************

});

EndPointCreateEditApp.factory('EndPointCreateEditFactory', function ($http) {
    return {

        getEndPoints: function (instanceId) {
            return $http.post("/Routine/GetEndPoints",instanceId);
        },

        addEndPoint: function (endPointInfo) {
            return $http.post("/Routine/AddEndPoint", endPointInfo);
        },

        removeEndPoint: function (endPointId) {
            return $http.post("/Routine/RemoveEndPoint", endPointId);
        },        

        getEndPointComponents: function () {
            return $http.get("/Routine/GetEndPointComponents");
        },

        getEndPointObjectCount: function () {
            return $http.get("/Routine/GetEndPointObjectCount");
        },

        getEndPointObjects: function (endpointId) {
            return $http.post("/Routine/GetEndPointObject", endpointId);
        },

        getEndPointObjectComponents: function (endPointObjectId) {
            return $http.post("/Routine/GetEndPointObjectComponents", endPointObjectId);
        },

        getEndPointObjectGroups: function (endPointObjectId) {
            return $http.post("/Routine/GetEndPointObjectGroups", endPointObjectId);
        },

        addEndPointObject: function (endpointId) {
            return $http.post("/Routine/AddEndPointObject", endpointId);
        },

        addEndPointObjectComponent: function (endPointObjectComponent) {
            return $http.post("/Routine/AddEndPointObjectComponent", endPointObjectComponent);
        },
        
        removeEndPointObject: function (endPointObjectId) {
            return $http.post("/Routine/RemoveEndPointObject", endPointObjectId);
        },

        removeEndPointObjectComponent: function (endPointObjectComponentId) {
            return $http.post("/Routine/RemoveEndPointObjectComponent", endPointObjectComponentId);
        },

         getEndPointObjectGroupList: function () {
             return $http.get("/Routine/GetEndPointObjectGroupList");
        },

         gropuEndPointObject: function (endPointObjectGroupingInfo) {
             return $http.post("/Routine/GropuEndPointObject", endPointObjectGroupingInfo);
         },
         
         ungropuEndPointObject: function (endPointObjectGroupId) {
             return $http.post("/Routine/UngropuEndPointObject", endPointObjectGroupId);
         }

    };
});
