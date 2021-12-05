public with sharing class WarehouseCalloutMethodsService {
    public static HttpResponse getEquipmentsFromExternalService(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(Constants.WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }

    public static List<Object> getEquipmentsFromResponse(HttpResponse response){
        List<Object> resultObjects = new List<Object>();
        if(response.getStatusCode() == 200) {
            resultObjects = (List<Object>) JSON.deserializeUntyped(response.getBody());
        }
        return resultObjects;
    }
}
