//var app = angular.module('myApp', []);
//app.controller('envCtrl', function ($scope, $http) {

//    $http.get('/NoticeBoard/GetPersons').then(mySucces, myError);

//    function mySucces(response) {
//        $scope.result = response.data;

//    }

//    function myError(response) {
//        $scope.result = response.statusText;
//    }
    
//});



//var app = angular.module('myApp', []);
//app.controller('envCtrl', function (envService, $scope) {
//    envService.getEnvironments().then(function (d) {
//        $scope.result = d.data;
//    });
//});


//app.factory('envService', function ($http) {
//    return {
//        getEnvironments: function () {
//            return $http.get('/NoticeBoard/GetPersons');
//        }
//    };
//})


//$(document).ready
//(
//    function ()
//            {
//                var source;
//                var destination;
//                var fn = function (event, ui)
//                {
//                    toDrop = $(ui.draggable)//.clone();
//                    //if ($("#droppable").find("li[uniqueIdentity=" + toDrop.attr("uniqueIdentity") + "]").length <= 0)
//                    {
//                        $("#droppable").append(toDrop);
//                    }
//                    //else
//                        //return false;
//                };

//                $("#draggable li").draggable(
//                    {
//                        helper: 'clone'
                    
//                    }
//                );

//                $("#droppable").droppable(
//                    {
//                        drop: fn
//                    }
//                );
//    }
//);

var module = angular.module('my-app', []);

module.directive('draggable', function () {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            element[0].addEventListener('dragstart', scope.handleDragStart, false);
            element[0].addEventListener('dragend', scope.handleDragEnd, false);
        }
    }
});

module.directive('droppable', function () {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            element[0].addEventListener('drop', scope.handleDrop, false);
            element[0].addEventListener('dragover', scope.handleDragOver, false);
        }
    }
});

module.controller('envCtrl', function ($scope, $http) {

    $http.get('/NoticeBoard/GetPersons').then(mySucces, myError);

    function mySucces(response) {
        $scope.result = response.data;

    }

    function myError(response) {
        $scope.result = response.statusText;
    }


    //$scope.drag_types = [{ "name": "Charan" }, { "name": "Vijay" }, { "name": "Mahesh" }, { "name": "Dhananjay" }];
      $scope.items = [];

    $scope.handleDragStart = function (e) {
        this.style.opacity = '0.4';
        e.dataTransfer.setData("text/plain", this.innerHTML);
    };

    $scope.handleDragEnd = function (e) {
        this.style.opacity = '1.0';
    };

    $scope.handleDrop = function (e) {
        e.preventDefault();
        e.stopPropagation();
        var dataText = e.dataTransfer.getData("text/plain");
        $scope.$apply(function () {
            $scope.items.push(dataText);
        });
        console.log($scope.items);
    };

    $scope.handleDragOver = function (e) {
        e.preventDefault(); // Necessary. Allows us to drop.
        e.dataTransfer.dropEffect = 'move';  // See the section on the DataTransfer object.
        return false;
    };


    $scope.resize = function (evt, ui) {
        $scope.w = ui.size.width;
        $scope.h = ui.size.height;
    }


});

module.directive('myDraggable', ['$document', function ($document) {
            return {
                link: function (scope, element, attr) {
                    var startX = 0, startY = 0, x = 0, y = 0;

                    element.css({
                        position: 'relative',
                        border: '1px solid red',
                        backgroundColor: 'lightgrey',
                        cursor: 'pointer'
                    });

                    
                    element.on('mousedown', function (event) {
                        // Prevent default dragging of selected content
                        
                        event.preventDefault();
                        startX = event.pageX - x;
                        startY = event.pageY - y;
                        $document.on('mousemove', mousemove);
                        $document.on('mouseup', mouseup);
                    });

                    function mousemove(event) {
                        y = event.pageY - startY;
                        x = event.pageX - startX;
                        element.css({
                            top: y + 'px',
                            left: x + 'px'
                        });
                    }

                    function mouseup() {
                        $document.off('mousemove', mousemove);
                        $document.off('mouseup', mouseup);
                    }
                }
            };
}]);

module.directive('resizable', function () {

    return {
        restrict: 'A',
        scope: {
            callback: '&onResize'
        },
        link: function postLink(scope, elem, attrs) {
            elem.resizable();
            elem.on('resize', function (evt, ui) {
                scope.$apply(function () {
                    if (scope.callback) {
                        scope.callback({ $evt: evt, $ui: ui });
                    }
                })
            });
        }
    };
})


module.controller('MainCtrl', function ($scope) {

        $scope.resize = function (evt, ui) {
            //console.log (evt,ui);
            $scope.w = ui.size.width;
            $scope.h = ui.size.height;
        }

    });




//function MainController($scope) {
//    //$scope.drag_types = [{ "name": "Charan" }, { "name": "Vijay" }, { "name": "Mahesh" }, { "name": "Dhananjay" }];
//    $scope.drag_types = [{ "Id": 1, "Name": "Environment-1", "Server": "m040145.ellucian.com", "Port": "8088", "APP": "IntegrationApi", "Connector": "api" }, { "Id": 2, "Name": "Environment-2", "Server": "http://149.24.38.75", "Port": "7004", "APP": "IntegrationApi", "Connector": "api" }, { "Id": 3, "Name": "Environment-3", "Server": "http://34.193.79.158", "Port": "7005", "APP": "StudentApi", "Connector": "api" }, { "Id": 4, "Name": "Environment-4", "Server": "http://149.24.38.75", "Port": "7005", "APP": "StudentApi", "Connector": "api" }, { "Id": 5, "Name": "Environment-5", "Server": "http://52.201.103.2", "Port": "7005", "APP": "IntegrationApi", "Connector": "api" }, { "Id": 6, "Name": "Environment-6", "Server": "http://149.24.12.180", "Port": "8080", "APP": "StudentApi", "Connector": "api" }, { "Id": 7, "Name": "Environment-7", "Server": "http://52.202.27.120", "Port": "7006", "APP": "StudentApi", "Connector": "api" }];
//    $scope.items = [];

//    $scope.handleDragStart = function (e) {
//        this.style.opacity = '0.4';
//        e.dataTransfer.setData('text/plain', this.innerHTML);
//    };

//    $scope.handleDragEnd = function (e) {
//        this.style.opacity = '1.0';
//    };

//    $scope.handleDrop = function (e) {
//        e.preventDefault();
//        e.stopPropagation();
//        var dataText = e.dataTransfer.getData('text/plain');
//        $scope.$apply(function () {
//            $scope.items.push(dataText);
//        });
//        console.log($scope.items);
//    };

//    $scope.handleDragOver = function (e) {
//        e.preventDefault(); // Necessary. Allows us to drop.
//        e.dataTransfer.dropEffect = 'move';  // See the section on the DataTransfer object.
//        return false;
//    };

//}