
var TestsCreateEditApp = angular.module('api.test.tests.create.edit', []);

TestsCreateEditApp.controller('TestsCreateEditCtrl', function (TestsCreateEditFactory, apiTestBroadcastService, $scope) {


    //*****************
    //This section helps to toggle with the check box
    $scope.isAllSelected = false;
    var getAllSelected = function () {
        var selectedItems = $scope.TestTemplates.filter(function (item) {
            return item.selected;
        });

        selectedTestCases(selectedItems);
    };

    $scope.toggleAll = function () {
        //$scope.isAllSelected = !$scope.isAllSelected; //this line of code is needed if it is an array
        var toggleStatus = $scope.isAllSelected;
        angular.forEach($scope.TestTemplates, function (itm) { itm.selected = toggleStatus; });
        getAllSelected();
    };

    $scope.optionToggled = function () {
        $scope.isAllSelected = $scope.TestTemplates.every(function (itm) { return itm.selected; });
        getAllSelected();
    };
    //*****************

    TestsCreateEditFactory.getTestTemplates().then(function (d) {        
        $scope.TestTemplates=[]
        for (prop in d.data.List)
        {            
            $scope.TestTemplates.push({ 'Name': prop });
        }
    });


    //TestsCreateEditFactory.getTestCases().then(function (d) {
    //    $scope.TestCasesList = d.data;
    //});


    var selectedTestCases = function (itemsSelected) {
        apiTestBroadcastService.globalBroadcast('TestCaseSelected', itemsSelected)
    };

});


TestsCreateEditApp.factory('TestsCreateEditFactory', function ($http) {
    return {

        //getTestCases: function () {
        //    return $http.get("/Planner/GetAllTestCases");
        //},

        getTestTemplates: function () {
            return $http.get("/Planner/GetAllTestTemplates");
        }
    };
});
