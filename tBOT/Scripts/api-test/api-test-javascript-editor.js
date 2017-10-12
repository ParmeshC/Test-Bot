var JavaScriptEditorApp = angular.module('api.test.JavaScript.editor', ['ui.ace']);
JavaScriptEditorApp.controller('JavaScriptEditorCtrl', function (JavaScriptEditorFactory, apiTestBroadcastService, $scope) {

    var ObjectComponent;
    var GlobalComponent;
    JavaScriptEditorFactory.getEndPointComponentsAsJsonString().then(function (d) {
        ObjectComponent=d.data;
        GlobalComponent = d.data;
    });


    var stringValue = '';
    $scope.$on('handleEditableComponentBroadcast', function () {

        //**********************start-Get EndPointObjectComponent or EndPointComponent based the Id**************************
      
        if (apiTestBroadcastService.sharedObjects.EditableComponent !== undefined) {
            if (apiTestBroadcastService.sharedObjects.EditableComponent.EndPointObjectComponentId !== undefined) {
                JavaScriptEditorFactory.getEndPointObjectComponent({ "EndPointObjectComponentId": apiTestBroadcastService.sharedObjects.EditableComponent.EndPointObjectComponentId }).then(function (d) {
                    $scope.EditableComponent = d.data[0];
                    stringValue = $scope.EditableComponent.ComponentValue == null ? '' : $scope.EditableComponent.ComponentValue;
                    editor.setValue(stringValue, stringValue.length) 
                })
            }
            else if (apiTestBroadcastService.sharedObjects.EditableComponent.EndPointComponentId !== undefined) {                
                JavaScriptEditorFactory.getEndPointComponent({ "EndPointComponentId": apiTestBroadcastService.sharedObjects.EditableComponent.EndPointComponentId }).then(function (d) {
                    $scope.EditableComponent = d.data[0];
                    stringValue = $scope.EditableComponent.ComponentValue == null ? '' : $scope.EditableComponent.ComponentValue;
                    editor.setValue(stringValue, stringValue.length)
                })
            }

        }

        else
        {
            $scope.EditableComponent = undefined;
            apiTestBroadcastService.globalBroadcast('ShowJsonEditor', false)
            apiTestBroadcastService.globalBroadcast('ShowSqlEditor', false)
        }
        //**********************end-Get EndPointObjectComponent or EndPointComponent based the Id**************************

        

        
        $scope.ExecutionOutPut=undefined
         editor.focus();
    });


    $scope.$on('handleJsonValueBroadcast', function () {
        var InseretedJsonValue = JSON.stringify(apiTestBroadcastService.sharedObjects.JsonValue, null, 2);
        if (InseretedJsonValue != undefined) { $scope.InsertSnippet(InseretedJsonValue);}
    });

    
    var editor = ace.edit("editor");
    editor.$blockScrolling = Infinity;
    editor.setShowPrintMargin(false);
    editor.setOptions({
        firstLineNumber:0,
        enableBasicAutocompletion: true,
        enableSnippets: true,
        //enableLiveAutocompletion: false   
    });

    $scope.AddJson = function () {

        apiTestBroadcastService.globalBroadcast('ShowSqlEditor', false)
        apiTestBroadcastService.globalBroadcast('ShowJsonEditor', true)
    }

    $scope.AddSql = function () {
        apiTestBroadcastService.globalBroadcast('ShowSqlEditor', true)
        apiTestBroadcastService.globalBroadcast('ShowJsonEditor', false)
    }

    $scope.ExecuteCode = function () {
        var annot = editor.getSession().getAnnotations();
        var gotError;
        var prevCode = undefined;
        if (annot.length == 0) {
            try {
                prevCode = eval(editor.getValue());
                gotError = undefined;
            }
            catch (error) {
                gotError = error
            }

                if (gotError == undefined)
                {
                    $scope.ExecutionOutPut = prevCode

                    if ($scope.EditableComponent.EndPointComponentId != undefined)
                    {
                        var endpointComponent = { "EndPointComponentId": $scope.EditableComponent.EndPointComponentId, "EndPointComponentValue": editor.getValue() };                        
                        JavaScriptEditorFactory.editEndPointComponentValue(endpointComponent).then(function (d) {
                            console.log(d.data)                          
                        })

                    }
                    else if ($scope.EditableComponent.EndPointObjectComponentId != undefined)
                    {
                        var endpointObjectComponent = { "EndPointObjectComponentId": $scope.EditableComponent.EndPointObjectComponentId, "EndPointObjectComponentValue": editor.getValue() };
                        JavaScriptEditorFactory.editEndPointObjectComponentValue(endpointObjectComponent).then(function (d) {
                            console.log(d.data)
                        })
                    }
                }
                else
                {
                    $scope.ExecutionOutPut = gotError.message
                }
        }
        else {
            for (var key in annot) {
                if (annot.hasOwnProperty(key)) {
                    var rowNumber = annot[key].row == -1 ? 0 : annot[key].row;
                    var errorMessage = "Row: " + rowNumber + '\n' + "Error: " + annot[key].text;
                    $scope.ExecutionOutPut = errorMessage;
                }
            }
        }
    }



    $scope.EvaluteCode = function () {
        var annot = editor.getSession().getAnnotations();
        var gotError;
        var prevCode = undefined;
        if (annot.length == 0) {
            try {
                prevCode = eval(editor.getValue());
                gotError = undefined;
            }
            catch (error) {
                gotError = error
            }

            $scope.ExecutionOutPut = gotError == undefined ? prevCode : gotError.message;
        }
        else {
            for (var key in annot) {
                if (annot.hasOwnProperty(key)) {
                    var rowNumber = annot[key].row == -1 ? 0 : annot[key].row;
                    var errorMessage = "Row: " + rowNumber + '\n' + "Error: " + annot[key].text;
                    $scope.ExecutionOutPut = errorMessage;
                }
            }
        }
    }


    $scope.InsertSnippet = function (snippetText) {
        var snippetManager = ace.require("ace/snippets").snippetManager;
        snippetManager.insertSnippet(editor, snippetText);
        editor.focus();
    }

        
    var Components = { AuthType: 'Basic' };
    

    
    //A template literal is delimited by backticks:
    $scope.snippetText = [
`Array.prototype.in_array = function(p_val) {
	for(var i = 0, l = this.length; i < l; i++) {
		if(this[i] == p_val) {
			return true;
		}
	}
	return false;
};

var v_array = [ 5, 10, 15, 20, 25];
v_array.in_array(10);`,

`function Car(){
    
}

Car.prototype={
    model:"",
    maxSpeed:0,
    power:0,
    coords:{x:0,y:0},
    move:function(x,y){
        this.x=x,
        this.y=y;
    }
};

var myCar = new Car();`]
    
});


JavaScriptEditorApp.factory('JavaScriptEditorFactory', function ($http) {
    return {

        editEndPointComponentValue: function (endPointComponent) {
            return $http.post("/Routine/EditEndPointComponentValue", endPointComponent);
        },

         editEndPointObjectComponentValue: function (endPointObjectComponent) {
            return $http.post("/Routine/EditEndPointObjectComponentValue", endPointObjectComponent);
        },

         getEndPointObjectComponent: function (endPointObjectComponentId) {
             return $http.post("/Routine/GetEndPointObjectComponent", endPointObjectComponentId);
         },

         getEndPointComponent: function (endPointComponentId) {
             return $http.post("/Routine/GetEndPointComponent", endPointComponentId);
         },

         getEndPointComponentsAsJsonString: function () {
             return $http.get("/Planner/GetEndPointComponentsAsJsonString");
         },

    };
});