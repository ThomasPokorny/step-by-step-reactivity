ProductManagementSys = softwareSystem "ProductManagemnt"{
    
    tags "team-internal-pm"
    
    api = container "ProductManagementApi" {
        description "TBD"
        technology "TBD"
        tags "team-internal-pm"
    }

    database = container "ProductManagementDB" {
        description "TBD"
        technology "TBD"
        tags "team-internal-pm" "Database"
    }

    productManagementWeb = container "ProductManagementUI" {
        description "TBD"
        technology "TBD"
        tags "team-internal-pm" "WebApp"
    }

    mobileApp = container "ProductManagementApp" {
        description "TBD"
        technology "TBD"
        tags "team-internal-pm" "MobileApp"
    }

    api -> database "Reads From"
    api -> database  "Writes to"

    productManagementWeb -> api "calls the endpoints"
}
