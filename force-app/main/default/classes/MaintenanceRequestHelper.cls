public with sharing class MaintenanceRequestHelper {

    private List<Case> newCases {get;set;}
    private Map<Id, List<Equipment_Maintenance_Item__c>> equipmentMaintenanceItems {get;set;}

    public MaintenanceRequestHelper(){
        newCases = new List<Case>();
        equipmentMaintenanceItems = new Map<Id, List<Equipment_Maintenance_Item__c>>();
    }

    public void automationProcess(Map<Id,Case> newCaseById, Map<Id,Case> oldCaseById){
        Map<Id,Case> updatedCases = ChallengeHelper.getClosedCases(newCaseById, oldCaseById);

        if(updatedCases != null && !updatedCases.isEmpty()){
            getNewMaintenanceRequest(updatedCases, oldCaseById);
            insertNewMaintenanceRequest();
        }
    }

    public void getNewMaintenanceRequest(Map<Id,Case> updatedCases, Map<Id,Case> oldCases){
        equipmentMaintenanceItems = ChallengeHelper.getEquipmentMaintenanceItems(updatedCases.keySet());
        for(Case c : updatedCases.values()){
            Case newCase = MaintenanceRequestDataFactory.cloneParentCase(c);
            newCase.Date_Due__c = ChallengeHelper.calculateDueDate(equipmentMaintenanceItems.get(c.Id));
            newCases.add(newCase);
        }
    }

    public void insertNewMaintenanceRequest(){
        ChallengeHelper.insertNewCases(newCases);
        List<Equipment_Maintenance_Item__c> allNewEquipmentMaintenanceItems = new List<Equipment_Maintenance_Item__c>();
        for(Case newCase : newCases){
            List<Equipment_Maintenance_Item__c> equipments = equipmentMaintenanceItems.get(newCase.ParentId);
            allNewEquipmentMaintenanceItems.addAll(ChallengeHelper.getNewEquipmentMaintenanceItems(equipments, newCase));
        }
        ChallengeHelper.insertNewEquipmentMaintenanceItems(allNewEquipmentMaintenanceItems);
    }

}
