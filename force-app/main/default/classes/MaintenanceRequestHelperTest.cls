@isTest
public class MaintenanceRequestHelperTest {

    @TestSetup
    static void makeData(){
        Vehicle__c vehicle = MaintenanceRequestDataFactory.createVehicle('Ferrari');
        insert vehicle;

        Case case1 = MaintenanceRequestDataFactory.createCase(Constants.TYPE_REPAIR, vehicle.Id);
        Case case2 = MaintenanceRequestDataFactory.createCase(Constants.TYPE_OTHER, vehicle.Id);
        insert new List<Case>{case1,case2};

        List<Product2> equipments = MaintenanceRequestDataFactory.createMultipleEquipments(3);
        insert equipments;
    }

    @isTest
    static void maintenanceRequestTriggerTest(){
        Case caseTest = [SELECT Id, Type, Status, Vehicle__c FROM Case Where Type = :Constants.TYPE_REPAIR LIMIT 1];
        List<Product2> equipments = [SELECT Id, Name, Cost__c, Maintenance_Cycle__c FROM Product2 LIMIT 3];

        List<Equipment_Maintenance_Item__c> equipmentsMaintenanceItems = MaintenanceRequestDataFactory.createMultipleEquipmentMaintenanceItem(caseTest.Id, equipments);
        insert equipmentsMaintenanceItems;

        Test.startTest();
        caseTest.Status = Constants.STATUS_CLOSED;
        Database.SaveResult result = Database.update(caseTest, false);
        Test.stopTest();

        System.assert(result.isSuccess(), 'Check if DML operation ocurred successfully');
        System.assert(result.getErrors().size() < 1, 'Check if the operation has no errors');
    }
}