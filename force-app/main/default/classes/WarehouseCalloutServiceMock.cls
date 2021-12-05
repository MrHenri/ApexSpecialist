@isTest
public class WarehouseCalloutServiceMock implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest req) {
        System.assertEquals(Constants.WAREHOUSE_URL, req.getEndpoint(), 'Check if the Endpoint is the correct one');
        System.assertEquals('GET', req.getMethod(), 'Check if the Method is GET');

        HttpResponse res = new HttpResponse();
        res.setBody('[{"_id":"55d66226726b611100aaf742","replacement":true,"quantity":183,"name":"Cooling Fan","maintenanceperiod":0,"lifespan":0,"cost":300,"sku":"100004"}]');
        res.setStatusCode(200);
        return res;
    }
}