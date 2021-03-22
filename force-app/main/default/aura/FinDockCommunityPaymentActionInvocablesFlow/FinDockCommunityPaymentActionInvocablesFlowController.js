({
    init : function (component) {
        // Find the component whose aura:id is "flowData"
        var flow = component.find("FinDockCommunityPaymentInvocablesFlow");
        // In that component, start your flow. Reference the flow's API Name.
        flow.startFlow("FinDock_Community_Payment_Invocables");
    },
})