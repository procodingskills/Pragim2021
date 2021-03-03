({
    handleAppEvent : function(component, event, helper) {
        let appDataFirstName =  event.getParam("firstName");
        let appDataLastName =  event.getParam("lastName");
        console.log("First Name : "+appDataFirstName);
        console.log("Last Name : "+appDataLastName);
        component.set("v.firstNameP",appDataFirstName);
        component.set("v.lastNameP",appDataLastName);
    }
})
