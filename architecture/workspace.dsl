workspace {
    
    !adrs decisions
    !identifiers hierarchical

    model {

        properties {
            "structurizr.groupSeparator" "/"
        }

        user = person "User"

        !include systems/analytics/models.dsl

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
