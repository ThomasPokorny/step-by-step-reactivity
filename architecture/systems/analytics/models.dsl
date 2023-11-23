AnalyticsSys = softwareSystem "Analytics"{
    
    tags "team-analytics"
    
    backgroundService = container "AnalysisService" {
        description "TBD"
        technology "ExpressJS"
        tags "team-analytics"
    }

    api = container "AnalyticsApi" {
        description "Provides the information after analysis for the sake of the management dashboard"
        technology "ExpressJS"
        tags "team-analytics"
    }

    analyticsDashboard = container "AnalyticsDashboardUI" {
      description "TBD"
      technology "TBD"
      tags "team-analytics" "WebApp"
    }

    redisCache = container "AnalysisServiceDataStore" {
        description "TBD"
        technology "redis"
        tags "team-analytics"
    }

    backgroundService -> redisCache "Wtites the aggregated values to"
    api -> redisCache "Reading the aggregated values from"
    analyticsDashboard -> api "Fetches the values and shows them to the user"

}
