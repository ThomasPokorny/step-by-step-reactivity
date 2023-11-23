workspace {
    
    !adrs decisions
    !identifiers hierarchical

    model {

        properties {
            "structurizr.groupSeparator" "/"
        }

        customer = person "Customer"
        backOfficeOperator = person "Backoffice Operator"

        !include systems/analytics/models.dsl
        !include systems/infra/models.dsl
        !include systems/web/models.dsl
        !include systems/orders/models.dsl

        !include ./relationships.dsl
    }

    views {

        !include ./styles/styles.dsl

        systemLandscape {
            include *
        }

        !include ./views.dsl

    }

}
