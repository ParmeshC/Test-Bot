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
//var app = angular.module('Tab', ['ui.bootstrap']);

//app.controller("TabsParentController", function ($scope) {

//    var setAllInactive = function () {
//        angular.forEach($scope.workspaces, function (workspace) {
//            workspace.active = false;
//        });
//    };

//    var addNewWorkspace = function () {
//        var id = $scope.workspaces.length + 1;
//        $scope.workspaces.push({
//            id: id,
//            name: name + "Apis",
//            active: true
//        });
//    };

//    $scope.workspaces =
//        [
//            { id: 1, name: "Individual", active: true }
//            , { id: 2, name: "Groups", active: false }
//        ];

//    $scope.addWorkspace = function () {
//        setAllInactive();
//        addNewWorkspace();
//    };

//});

//app.controller("TabsChildController", function ($scope, $log) {

//});


angular.module('Tab', ['ui.grid'])

    .controller('TabsParentController', ['$scope', function ($scope) {
        var vm = this;

        vm.gridOptions = {};
        $scope.hdrMapping = [{ header: "Api", id: 1 }, { header: "App", id: 2 }, { header: "Version", id: 3 }];
        $scope.revisedHdrMapping = [{ header: "Api", id: 1 }, { header: "App", id: 2 }, { header: "Version", id: 3 }];
        //$scope.hdrMapped = $scope.hdrMapping[0];

        $scope.update = function (indx,hdrval) {
            //console.log($scope.hdrMapped)
            $scope.hdrMapped = this.hdrMapped

            console.log(this.hdrMapped)
            console.log($scope.hdrMapping)
            //var index = $scope.hdrMapping.indexOf(this.hdrMapped.id);
            //$scope.hdrMapping.splice(index, 1);
            console.log(this.hdrMapped.id)
            $scope.revisedHdrMapping.splice({ id: this.hdrMapped.id }, 1);
            console.log($scope.revisedHdrMapping)
            console.log(hdrval)
            console.log(indx)
        }

        //$scope.$watch('hdrMapped', function () {
        //    alert('hey, hdrMapped has changed!');
        //});

        vm.reset = reset;

        function reset() {
            vm.gridOptions.data = [];
            vm.gridOptions.columnDefs = [];
        }
    }])

    .directive("fileread", [function () {
        return {
            scope: {
                opts: '='
            },
            link: function ($scope, $elm, $attrs) {
                $elm.on('change', function (changeEvent) {
                    var reader = new FileReader();

                    reader.onload = function (evt) {
                        $scope.$apply(function () {
                            var data = evt.target.result;

                            var workbook = XLSX.read(data, { type: 'binary' });

                            var headerNames = XLSX.utils.sheet_to_json(workbook.Sheets[workbook.SheetNames[0]], { header: 1 })[0];

                            data = XLSX.utils.sheet_to_json(workbook.Sheets[workbook.SheetNames[0]]);

                            $scope.opts.columnDefs = [];
                            headerNames.forEach(function (h) {
                                $scope.opts.columnDefs.push({ field: h });
                            });

                            $scope.opts.data = data;

                            $elm.val(null);
                        });
                    };

                    reader.readAsBinaryString(changeEvent.target.files[0]);
                });
            }
        }
    }]);