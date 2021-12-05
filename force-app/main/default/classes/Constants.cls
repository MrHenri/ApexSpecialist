public with sharing class Constants {

    //Case Type
    public final static String TYPE_REPAIR = 'Repair';
    public final static String TYPE_ROUTINE_MAINTENANCE = 'Routine Maintenance';
    public final static String TYPE_OTHER = 'Other';

    //Case Status
    public final static String STATUS_CLOSED = 'Closed';
    public final static String STATUS_NEW = 'New';

    //Case Origin
    public final static String ORIGIN_WEB = 'Web';

    //Endpoint
    public static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';

    //Schedule Job
    public static final String WAREHOUSE_SYNC_SCHEDULE = '0 0 1 * * ?';
}
