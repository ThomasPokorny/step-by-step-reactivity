OrderManagementSys = softwareSystem "OrderManagement"{
    
    tags "team-orders"
    
    api = container "OrderManagementApi" {
        description "TBD"
        technology "TBD"
        tags "team-orders"
    }

    database = container "OrderManagementDB" {
        description "TBD"
        technology "TBD"
        tags "team-orders"
    }

    orderWeb = container "OrderWeb" {
        description "TBD"
        technology "TBD"
        tags "team-orders"

        BackofficeOrderMangementController = component "BackofficeOrderMangementController" {
        }

        CustomerOrderController = component "CustomerOrderController" { 
        }
    }

    orderWeb -> api "Calls the endpoints"
}
