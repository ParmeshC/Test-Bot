var ImportComponentsApp = angular.module('api.test.import.components', []);
ImportComponentsApp.controller('ImportComponentsCtrl', function (ImportComponentsFactory, $scope) {
    var vm = this;

    var jsonData = [{ header: "EndPoint", id: 0 }, { header: "App", id: 1 }, { header: "Connector", id: 2 }, { header: "Version", id: 3 }];
    

    vm.gridOptions = {};
    $scope.slctdHdr;
    $scope.mpdHdr = {};
    $scope.mpdHdrNdata = [];
    $scope.mpblHdr = jsonData;

    vm.reset = function reset() {
        vm.gridOptions.data = [];
        vm.gridOptions.columnDefs = [];
        $scope.slctdHdr;
        $scope.mpdHdr = {};
        $scope.mpdHdrNdata = [];
        $scope.mpblHdr = jsonData;
    };

    $scope.AddApiInfo = function () {
        ImportComponentsFactory.addApiInfoToDB($scope.mpdHdrNdata);
    };

    $scope.update = function (clmIndx) {
        if (this.slctdHdr !== undefined && this.slctdHdr !== null) {
            var index = this.slctdHdr['id'];
            $scope.mpdHdr[clmIndx] = this.slctdHdr['header'];
            $scope.mpblHdr = $scope.mpblHdr.filter(function (hdr) {
                return hdr.id !== index;
            });
            getCol($scope.mpdHdrNdata, vm.gridOptions.data, vm.gridOptions.columnDefs, clmIndx, this.slctdHdr['header']);
        }
    };

    function getCol(mpdHdrNdata, dataArray, colmnHeader, clmnIndx, hdrNm) {
        var hasRows = mpdHdrNdata.length > 0 ? true : false;

        for (var row = 0; row < dataArray.length; row++) {
            for (var clmn = 0; clmn < dataArray.length; clmn++) {
                if (clmn === clmnIndx) {
                    if (dataArray[row][colmnHeader[clmn].field] !== undefined) {
                        if (hasRows) {
                            mpdHdrNdata[row][hdrNm] = dataArray[row][colmnHeader[clmn].field];
                        }
                        else {
                            mpdHdrNdata.push({ [hdrNm]: dataArray[row][colmnHeader[clmn].field] });
                        }
                    }
                    else {
                        if (hasRows) {
                            mpdHdrNdata[row][hdrNm] = null;
                        }
                        else {
                            mpdHdrNdata.push({ [hdrNm]: null });
                        }
                    }
                }
            }
        }
    }

});

ImportComponentsApp.directive("fileread", [function () {
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
    };
}]);

ImportComponentsApp.factory('ImportComponentsFactory', function ($http) {
    return {

        addApiInfoToDB: function (ApiInput) {
            return $http.post("/Routine/AddApiInfo", ApiInput);
        }
    };
});