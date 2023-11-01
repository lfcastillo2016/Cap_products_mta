using com.training as training from '../db/training';

service ManageOrders {

    //Declaración de tipo para el evento ACTION
    type cancelOrderReturn {
        status  : String enum {
            succeeded;
            failed
        };
        message : String
    };


    /*Se comentan para realizar esto de otra forma, los dos
     * eventos (action y function) en un mismo llamado
     */

    // entity Orders as projection on training.Orders;
    // // Function
    // function getClientTaxRate(clientEmail : String(65)) returns Decimal(4, 2);
    // //Action
    // action   cancelOrder(clientEmail : String(65))      returns cancelOrderReturn;


    /* los dos eventos (action y function) en un mismo llamado */
    entity Orders as projection on training.Orders actions {
        function getClientTaxRate(clientEmail : String(65)) returns Decimal(4, 2);
        action   cancelOrder(clientEmail : String(65))      returns cancelOrderReturn;
    }

}//fin ManageOrders
