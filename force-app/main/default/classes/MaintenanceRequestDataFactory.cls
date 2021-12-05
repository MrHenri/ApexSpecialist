public class MaintenanceRequestDataFactory {

    public static Case createCase(String type, Id vehicleId){
        return new Case(Type = type, Vehicle__c = vehicleId, Status = Constants.STATUS_NEW, Origin = Constants.ORIGIN_WEB);
    }

    public static Case cloneParentCase(Case parentCase){
        Case newCase = parentCase.clone();
        newCase.ParentId = parentCase.Id;
        newCase.Parent = parentCase;
        newCase.Type = Constants.TYPE_ROUTINE_MAINTENANCE;
        newCase.Status = Constants.STATUS_NEW;
        newCase.Subject = 'New Maintenance was scheduled';
        newCase.Date_Reported__c = Date.today();
        return newCase;
    }

    public static Vehicle__c createVehicle(String name){
        return new Vehicle__c(Name = name, Model__c = name);
    }

    public static Product2 createEquipment(String name, Double cost, Double cycleDays){
        return new Product2(Name = name, Cost__c = cost, Maintenance_Cycle__c = cycleDays, Replacement_Part__c = true);
    }

    public static Equipment_Maintenance_Item__c createEquipmentMaintenanceItem(Id maintenanceRequestId, Id equipmentId){
        return new Equipment_Maintenance_Item__c(Maintenance_Request__c = maintenanceRequestId, Equipment__c = equipmentId);
    }

    public static List<Product2> createMultipleEquipments(Integer quantity){
        List<Product2> equipments = new List<Product2>();

        for(Integer i = 0; i < quantity; i++){
            equipments.add(createEquipment('Equipment ' + i, i + 25, i + 25));
        }
        return equipments;
    }

    public static List<Equipment_Maintenance_Item__c> createMultipleEquipmentMaintenanceItem(Id maintenanceRequestId, List<Product2> equipments){
        List<Equipment_Maintenance_Item__c> equipmentsMaintenanceItems = new List<Equipment_Maintenance_Item__c>();
        for(Product2 equipment : equipments){
            equipmentsMaintenanceItems.add(createEquipmentMaintenanceItem(maintenanceRequestId, equipment.Id));
        }
        return equipmentsMaintenanceItems;
    }

    public static Product2 createEquipmentByExternalObject(Map<String,Object> externalObject){
        Product2 equipment = new Product2();
        equipment.Replacement_Part__c = (Boolean) externalObject.get('replacement');
        equipment.Current_Inventory__c = (Double) externalObject.get('quantity');
        equipment.Name = (String) externalObject.get('name');
        equipment.Maintenance_Cycle__c = (Double) externalObject.get('maintenanceperiod');
        equipment.Lifespan_Months__c = (Double) externalObject.get('lifespan');
        equipment.Cost__c = (Double) externalObject.get('cost');
        equipment.Warehouse_SKU__c = (String) externalObject.get('sku');
        return equipment;
    }
}
