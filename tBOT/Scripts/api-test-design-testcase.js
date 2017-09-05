var DesignTestCaseApp = angular.module('api.test.design.testcase', []);
DesignTestCaseApp.controller('DesignTestCaseCtrl', function (DesignTestCaseAppFactory, apiTestSharedService, $scope) {


    $scope.$on('handleDesignTestTemplateBroadcast', function () {
        $scope.DesignTestTemplate = apiTestSharedService.designTestTemplate;
    });

    DesignTestCaseAppFactory.getTestTemplates().then(function (d) {
        $scope.TestCaseTemplatesList = d.data.List;
    });


    $scope.TestCaseTemplateChange = function () {

        for (prop in $scope.TestCaseTemplatesList) {
            if (prop === $scope.TestCaseTemplate) {
                //$scope.TestCaseCondition = { [prop]: $scope.TestCaseTemplatesList[prop]};
                $scope.TestCaseCondition = $scope.TestCaseTemplatesList[prop];
                $scope.TestCaseTemplateName = null;
                break;

            }
        }
    };


    $scope.TestCaseClear = function () {
        $scope.TestCaseTemplate = null;
        $scope.TestCaseTemplateName = null;
    };



    $scope.TestCaseTemplateName;
    $scope.TestCaseTemplate;
    $scope.TestCaseCondition;

 $scope.AddTestCase = function () {    
     $scope.TestCase = { Name: $scope.TestCaseTemplateName, Template: $scope.TestCaseTemplate, Condition: JSON.stringify($scope.TestCaseCondition) };
    DesignTestCaseAppFactory.addTestCasesToDB($scope.TestCase);
    };
});


DesignTestCaseApp.factory('DesignTestCaseAppFactory', function ($http) {
    return {

        getTestTemplates: function (scp) {
            return $http.post("/Planner/GetAllTestTemplates");
        },

        addTestCasesToDB: function (testCase) {
            return $http.post("/Builder/AddTestCases", testCase);
        }

    };
});