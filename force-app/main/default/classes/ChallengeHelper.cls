public with sharing class ChallengeHelper {
    public static Boolean isRepairOrRoutineMaintenance(String type){
        return type == Constants.TYPE_REPAIR || type == Constants.TYPE_ROUTINE_MAINTENANCE;
    }

    public static Boolean isUpdatedToClose(String newStatus, String oldStatus){
        return newStatus == Constants.STATUS_CLOSED && oldStatus != Constants.STATUS_CLOSED;
    }

    public static Map<Id,Case> getClosedCases(Map<Id,Case> newCasesById, Map<Id,Case> oldCasesById){
        Map<Id,Case> updatedCases = new Map<Id,Case>();
        for(Id caseId : newCasesById.keySet()){
            Case c = newCasesById.get(caseId);
            if(ChallengeHelper.isRepairOrRoutineMaintenance(c.Type) && ChallengeHelper.isUpdatedToClose(c.Status, oldCasesById.get(c.Id).Status)){
                updatedCases.put(caseId, c);
            }
        }
        return updatedCases;
    }

    public static Map<Id,List<Equipment_Maintenance_Item__c>> getEquipmentMaintenanceItems(Set<Id> casesId){
        Map<Id,List<Equipment_Maintenance_Item__c>> equipmentMaintenanceItems = new Map<Id,List<Equipment_Maintenance_Item__c>>();
        for (Equipment_Maintenance_Item__c equipment : [SELECT Id, Equipment__c, Equipment__r.Maintenance_Cycle__c, Maintenance_Request__c, Quantity__c
                                                        FROM Equipment_Maintenance_Item__c
                                                        WHERE Maintenance_Request__c IN :casesId WITH SECURITY_ENFORCED]){
            Id caseKey = equipment.Maintenance_Request__c;
            if(equipmentMaintenanceItems.containsKey(caseKey)){
                equipmentMaintenanceItems.get(caseKey).add(equipment);
            } else {
                equipmentMaintenanceItems.put(caseKey, new List<Equipment_Maintenance_Item__c>{equipment});
            }
        }
        return equipmentMaintenanceItems;
    }

    public static Date calculateDueDate(List<Equipment_Maintenance_Item__c> equipmentMaintenanceItems){
        Decimal daysMore = 0;
        Date day = Date.today();
        for(Equipment_Maintenance_Item__c equipment : equipmentMaintenanceItems){
            daysMore += equipment.Equipment__r.Maintenance_Cycle__c;
        }
        day = day.addDays(daysMore.intValue());
        return day;
    }

    public static void insertNewCases(List<Case> newCases){
        if(newCases != null && !newCases.isEmpty()){
            try {
                insert newCases;
            } catch (DmlException e) {
                System.debug('Error has occurred while the new Cases were being inserting:\n###' + e.getMessage());
            }
        }
    }

    public static void insertNewEquipmentMaintenanceItems(List<Equipment_Maintenance_Item__c> newEquipmentsMaintenanceItems){
        if(newEquipmentsMaintenanceItems != null && !newEquipmentsMaintenanceItems.isEmpty()){
            try {
                insert newEquipmentsMaintenanceItems;
            } catch (DmlException e) {
                System.debug('Error has occurred while the new EquipmentsMaintenanceItems were being inserting:\n###' + e.getMessage());
            }
        }
    }

    public static void upsertExternalEquipments(List<Product2> externalEquipments){
        if(externalEquipments != null && !externalEquipments.isEmpty()){
            try {
                upsert externalEquipments Warehouse_SKU__c;
            } catch (DmlException e) {
                System.debug('Error has occurred while the external equipments were being inserting:\n###' + e.getMessage());
            }
        }
    }

    public static List<Equipment_Maintenance_Item__c> getNewEquipmentMaintenanceItems(List<Equipment_Maintenance_Item__c> equipmentMaintenanceItems, Case newCase){
        List<Equipment_Maintenance_Item__c> newEquipmentsMaintenanceItems = new List<Equipment_Maintenance_Item__c>();
        for(Equipment_Maintenance_Item__c e : equipmentMaintenanceItems){
            Equipment_Maintenance_Item__c newEquipment = e.clone();
            newEquipment.Maintenance_Request__c = newCase.Id;
            newEquipmentsMaintenanceItems.add(newEquipment);
        }
        return newEquipmentsMaintenanceItems;
    }

    public static List<Product2> factoryEquipments(List<Object> equipmentsObject){
        List<Product2> equipments = new List<Product2>();
        for(Object obj : equipmentsObject){
            Map<String, Object> keyValuesObject = (Map<String,Object>) obj;
            if ((Boolean) keyValuesObject.get('replacement') == true){
                equipments.add(MaintenanceRequestDataFactory.createEquipmentByExternalObject(keyValuesObject));
            }
        }
        return equipments;
    }
}
