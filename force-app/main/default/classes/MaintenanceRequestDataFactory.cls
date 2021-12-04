public class MaintenanceRequestDataFactory {

    public static Case createCase(String type, Id vehicleId){
        return new Case(Type = type, Vehicle__c = vehicleId, Status = Constants.STATUS_NEW, Origin = Constants.ORIGIN_WEB);
    }

    public static Vehicle__c createVehicle(String name){
        return new Vehicle__c(Name = name, Model__c = name);
    }

    public static Product2 createEquipment(String name, Double cost, Double cycleDays){
        return new Product2(Name = name, Cost__c = cost, Maintenance_Cycle__c = cycleDays);
    }

    public static Equipment_Maintenance_Item__c createEquipmentMaintenanceItem(Id maintenanceRequestId, Id equipmentId){
        return new Equipment_Maintenance_Item__c(Maintenance_Request__c = maintenanceRequestId, Equipment__c = equipmentId);
    }
}
