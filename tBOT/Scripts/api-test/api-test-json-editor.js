var JsonEditorApp = angular.module('api.test.json.editor', []);
JsonEditorApp.controller('JsonEditorCtrl', function (apiTestBroadcastService, $scope) {

    $scope.$on('handleShowJsonEditorBroadcast', function () {
        $scope.ShowJsonEditor = apiTestBroadcastService.sharedObjects.ShowJsonEditor;
    });


    $scope.jsonData;
    $scope.InsertJsonData = function (val) {
        apiTestBroadcastService.globalBroadcast('JsonValue',val);
    }

    $scope.CloseJsonEditor = function () {
        $scope.jsonData = undefined;
    }

});

