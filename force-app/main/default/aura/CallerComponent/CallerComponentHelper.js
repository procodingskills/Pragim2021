({
    createComponentHlp : function(component, event, helper) {
        let whatCmp = "c:"+component.find("cmpname").get("v.value");
        let params = this.setParams(component, event, helper);
        $A.createComponent(whatCmp ,params , function(newComponent , status , errorMessage){
            if(status === "SUCCESS"){
                let body =component.get("v.body");
                body.push(newComponent);
                component.set("v.body",body);
            }
            else {
                alert ("Craete CMP ERROR : "+JSON.stringify(errorMessage));
            }
        });
    },
    setParams : function(component, event, helper){
        return {
            "aura:id":component.find("cmpname").get("v.value"),
            "FirstName" : component.getReference("v.fName"),
            "LastName" : component.get("v.fName")
        };
    }
})
