var ApiTest = angular.module('api.test',
    [
        'api.test.ui.layout',
        'api.test.routine',
        'api.test.planner',
        'api.test.builder',
        'api.test.design.testcase',
        'ui.bootstrap',
        'my-app',
        'api.test.sql.editor',
        'NestedLists',
        'ngAnimate',
        'angular-jsoneditor',
        'api.test.json.editor',
        'api.test.JavaScript.editor',
        'api.test.request.response',
        'api.test.design.execution',
        'api.test.endpoint.create.edit',
        'api.test.import.components',
        'api.test.manage.settings',
        'api.test.group.create.edit'
    ]);

ApiTest.service('apiTestBroadcastService', function ($rootScope) {
    var sharedObjects = {};

    //Global broadcast service
    this.globalBroadcast = function (broadcastName, broadcastValue) {
        this.sharedObjects = { [broadcastName]: broadcastValue };
        $rootScope.$broadcast('handle' + broadcastName + 'Broadcast');
    };
    //---------------------------------

});

ApiTest.filter('orderObjectBy', function () {
    return function (items, field, reverse) {

        function isNumeric(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        }

        var filtered = [];

        angular.forEach(items, function (item, key) {
            item.key = key;
            filtered.push(item);
        });

        function index(obj, i) {
            return obj[i];
        }

        filtered.sort(function (a, b) {
            var comparator;
            var reducedA = field.split('.').reduce(index, a);
            var reducedB = field.split('.').reduce(index, b);

            if (isNumeric(reducedA) && isNumeric(reducedB)) {
                reducedA = Number(reducedA);
                reducedB = Number(reducedB);
            }

            if (reducedA === reducedB) {
                comparator = 0;
            } else {
                comparator = reducedA > reducedB ? 1 : -1;
            }

            return comparator;
        });


        if (reverse) {
            filtered.reverse();
        }

        return filtered;
    };
});



