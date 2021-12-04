@isTest
public class MaintenanceRequestHelperTest {

    @TestSetup
    static void makeData(){
        Vehicle__c vehicle = MaintenanceRequestDataFactory.createVehicle('Ferrari');
        insert vehicle;

        Case case1 = MaintenanceRequestDataFactory.createCase(Constants.TYPE_REPAIR, vehicle.Id);
        Case case2 = MaintenanceRequestDataFactory.createCase(Constants.TYPE_ROUTINE_MAINTENANCE, vehicle.Id);
        Case case3 = MaintenanceRequestDataFactory.createCase(Constants.TYPE_OTHER, vehicle.Id);
        insert new List<Case>{case1,case2,case3};

        Product2 equipment1 = MaintenanceRequestDataFactory.createEquipment('Equipment1', 100, 100);
        Product2 equipment2 = MaintenanceRequestDataFactory.createEquipment('Equipment2', 35, 35);
        Product2 equipment3 = MaintenanceRequestDataFactory.createEquipment('Equipment3', 75, 75);
        insert new List<Product2>{equipment1,equipment2,equipment3};

        Equipment_Maintenance_Item__c equipmentMaintenance1 = MaintenanceRequestDataFactory.createEquipmentMaintenanceItem(case1, equipment1);
        Equipment_Maintenance_Item__c equipmentMaintenance2 = MaintenanceRequestDataFactory.createEquipmentMaintenanceItem(case1, equipment2);
        Equipment_Maintenance_Item__c equipmentMaintenance3 = MaintenanceRequestDataFactory.createEquipmentMaintenanceItem(case2, equipment3);
        insert new List<Equipment_Maintenance_Item__c>{equipmentMaintenance1,equipmentMaintenance2,equipmentMaintenance3};
    }
}