trigger MaintenanceRequest on Case (before update) {

    if(Trigger.isBefore && Trigger.isUpdate){
        MaintenanceRequestHelper maintenanceHelper = new MaintenanceRequestHelper();
        maintenanceHelper.automationProcess(Trigger.newMap, Trigger.oldMap);
    }
}