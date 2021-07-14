({
    handleClick : function (component) {
        var flow = component.find("flowData");
        flow.startFlow("Movie_Request");
        component.set("v.flowIncomplete", true);
        component.set("v.buttonVisible", false);
    },

    handleStatusChange : function (component, event) {
        if (event.getParam("status") === "FINISHED") {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Movie Request Succesfully Submitted",
                "message": "We have successfully recieved your request. Thank you!",
                "type": "success",
            });
            toastEvent.fire();

            component.set("v.flowIncomplete", false);
            component.set("v.buttonVisible", true);
        }
        else if (event.getParam("status") === "ERROR") {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error in Submitting Movie Request",
                "message": "Unfortunately there was an error. Please try again.",
                "type": "error",
            });
            toastEvent.fire();

            component.set("v.flowIncomplete", false);
            component.set("v.buttonVisible", true);
        }
    }
})
