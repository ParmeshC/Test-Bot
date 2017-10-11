var GroupCreateEditApp = angular.module('api.test.group.create.edit', []);

GroupCreateEditApp.controller('GroupCreateEditCtrl', function (GroupCreateEditFactory, apiTestBroadcastService, $scope) {

    //this code helps to gets the notification to refresh data
    $scope.$on('handleEndPointObjectGroupChangedBroadcast', function () {

        //just calling the below function which does both needed data refresh
        GroupCreateEditFactory.getEndPointObjectGroupCount().then(function (d) {
            $scope.EndPointObjectGroupCount = d.data;
        });

        if ($scope.EndPointObjectGroupSection !== undefined) {
            $scope.GetEndPointObjectGroup($scope.EndPointObjectGroupSection)
        }
        
        });


    //****************start-UnGroup EndPoinObject**********
    $scope.UnGroupEndPointObject = function (endPointObjectGroupId) {
        var endpointObjectGroupId = { "EndPointObjectGroupId": endPointObjectGroupId };
        console.log(endpointObjectGroupId)
        GroupCreateEditFactory.ungropuEndPointObject(endpointObjectGroupId).then(function (d) {
            console.log(d.data);

            //this code helps to notify Group to refresh data in EndPoint tab
            apiTestBroadcastService.globalBroadcast('EndPointObjectGroupChanged', true)

        });
    };
    //****************end-UnGroup EndPoinObject******************************************



    //**********************start-Get EndPointObjectGroupCountt***********
    GroupCreateEditFactory.getEndPointObjectGroupCount().then(function (d) {
        $scope.EndPointObjectGroupCount = d.data;
    });
    //**********************end-Get EndPointObjectGroupCountt***********

    //**********************start-Get GetEndPointObjectGroup***********
    $scope.GetEndPointObjectGroup = function (endPointObjectGroupSection) {
        $scope.EndPointObjectGroupSection = endPointObjectGroupSection;

        var endpointObjectGroupSection = { "EndPointObjectGroupSection": endPointObjectGroupSection };

        GroupCreateEditFactory.getEndPointObjectForEndPointObjectGroupSection(endpointObjectGroupSection).then(function (d) {
            $scope.EndPointObjectForEndPointObjectGroupSection = d.data;
        });        
    }
    //**********************end-Get GetEndPointObjectGroup***********


    //************start-Execute EndPointObjectId*************
    $scope.ExecuteEndPointObjectId = function (endPointObjectId) {

        //broadcast EndPointObjectId for  Execution
        apiTestBroadcastService.globalBroadcast('ExecuteEndPointObjectId', endPointObjectId)

    }
    //************end-Execute EndPointObjectId*************



    //************start-Execute EndPointObjectGroupSection*************
    $scope.ExecuteEndPointObjectGroupSection = function (endPointObjectGroupSection) {

         //broadcast EndPointObjectGroupSection for  Execution
        apiTestBroadcastService.globalBroadcast('ExecuteEndPointObjectGroupSection', endPointObjectGroupSection)

    }
    //************end-Execute EndPointObjectGroupSection*************


    //************start-Execute EndPointObjectId*************
    $scope.ExecuteEndPointObject = function (endPointObjectId) {

        //broadcased Enpoint Object to the  Execution
        apiTestBroadcastService.globalBroadcast('ExecuteEndPointObjectId', endPointObjectId)

    }
    //************end-Execute EndPointObjectId*************



    //************start-Previous button*************
    $scope.PreviousClick = function () {

            //refresh previous data when coming back
            GroupCreateEditFactory.getEndPointObjectGroupCount().then(function (d) {
                $scope.EndPointObjectGroupCount = d.data;
            });
            //--------
            $scope.EndPointObjectForEndPointObjectGroupSection = undefined;       
    };
    //************end-Previous button*************

});

GroupCreateEditApp.factory('GroupCreateEditFactory', function ($http) {
    return {

        getEndPointObjectGroupCount: function () {
            return $http.get("/Routine/GetEndPointObjectGroupCount");
        },

        getEndPointObjectForEndPointObjectGroupSection: function (endPointObjectGroupSection) {
            return $http.post("/Routine/GetEndPointObjectForEndPointObjectGroupSection", endPointObjectGroupSection);
        },

        ungropuEndPointObject: function (endPointObjectGroupId) {
            return $http.post("/Routine/UngropuEndPointObject", endPointObjectGroupId);
        }

    };
});