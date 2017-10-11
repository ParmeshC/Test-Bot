var RoutineApp = angular.module('api.test.routine', []);

RoutineApp.controller('RoutineCtrl', function ($scope, apiTestBroadcastService) {
    $scope.tabSelected = function (tabName) {

        //console.log(tabName)

        //this code helps to close the javascript editor in the planner area
        apiTestBroadcastService.globalBroadcast('EditableComponent', undefined)

        };
});
