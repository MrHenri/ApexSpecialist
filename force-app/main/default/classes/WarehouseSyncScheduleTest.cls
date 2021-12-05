@isTest
public class WarehouseSyncScheduleTest {

    @isTest
    static void warehouseSyncSchedulePositiveTest(){
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());

        Test.startTest();
        String jobId = System.schedule('WarehouseSyncScheduleJob Test',
        Constants.WAREHOUSE_SYNC_SCHEDULE, new WarehouseSyncSchedule());

        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered FROM CronTrigger WHERE id = :jobId];
        Test.stopTest();

        System.assertEquals(Constants.WAREHOUSE_SYNC_SCHEDULE, ct.CronExpression, 'Verify the expressions are the same');
        System.assertEquals(0, ct.TimesTriggered, 'Verify the job has not run');
    }
}