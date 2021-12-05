public with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts{

    public void execute(QueueableContext context) {
        HttpResponse response = WarehouseCalloutMethodsService.getEquipmentsFromExternalService();
        List<Object> resultObjects = WarehouseCalloutMethodsService.getEquipmentsFromResponse(response);
        List<Product2> equipmentsToUpinsert = ChallengeHelper.factoryEquipments(resultObjects);
        ChallengeHelper.upsertExternalEquipments(equipmentsToUpinsert);
    }
}