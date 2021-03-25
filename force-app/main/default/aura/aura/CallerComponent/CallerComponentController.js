({
    createComponentCtr : function(component, event, helper) {
        helper.createComponentHlp(component, event, helper);
    },
    deleteComponent : function(component , event , helper){
        let cmpAuraId = component.find("cmpname").get("v.value");
        let destroyBody = component.find(cmpAuraId);
            destroyBody.destroy();
    }
})
