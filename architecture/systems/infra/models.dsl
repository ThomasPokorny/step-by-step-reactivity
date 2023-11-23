infra = softwareSystem "infra"{
    
    tags "team-infra"
    
    kafka = container "Kafka_Stream" {
        description "TBD"
        technology "TBD"
        tags "team-infra" "topic"

        ordersTopic = component "ordersTopic" {
        }

    }
}
