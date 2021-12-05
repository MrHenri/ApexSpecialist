public with sharing class WarehouseCalloutService implements Queueable, Database.AllowsCallouts{

    public void execute(QueueableContext context) {
        List<Object> resultObjects = getMethod();
        List<Product2> equipmentsToUpinsert = ChallengeHelper.factoryEquipments(resultObjects);
        ChallengeHelper.upsertExternalEquipments(equipmentsToUpinsert);
    }

    public List<Object> getMethod(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        List<Object> results = new List<Object>();
        request.setEndpoint(Constants.WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {
            results = (List<Object>) JSON.deserializeUntyped(response.getBody());
        }
        return results;
    }
}