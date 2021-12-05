@IsTest
private class WarehouseCalloutServiceTest {

    @isTest
    static void testCallout() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());

        HttpResponse res = WarehouseCalloutMethodsService.getEquipmentsFromExternalService();

        String actualValue = res.getBody();
        String expectedValue = '[{"_id":"55d66226726b611100aaf742","replacement":true,"quantity":183,"name":"Cooling Fan","maintenanceperiod":0,"lifespan":0,"cost":300,"sku":"100004"}]';
        System.assertEquals(actualValue, expectedValue, 'Check response value');
        System.assertEquals(200, res.getStatusCode(), 'Check response status');
    }

    @isTest
    static void warehouseCalloutServiceTestPositive() {
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());

        Test.startTest();
        System.enqueueJob(new WarehouseCalloutService());
        Test.stopTest();

        List<Product2> externalEquipments = [SELECT Id FROM Product2];
        System.assert(!externalEquipments.isEmpty(), 'Check if the external Equipments were added');
    }
}