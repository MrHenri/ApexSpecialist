WarehouseSyncSchedule warehouseSyncSchedulJob = new WarehouseSyncSchedule();
String jobID = system.schedule('WarehouseSyncScheduleJob', Constants.WAREHOUSE_SYNC_SCHEDULE, warehouseSyncSchedulJob);