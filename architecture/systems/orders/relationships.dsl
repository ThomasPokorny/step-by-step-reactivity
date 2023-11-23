OrderManagementSys.api -> infra.kafka "Publishes Orders Messages" {
  tags "async"
}

customer -> OrderManagementSys.orderWeb.CustomerOrderController "Submits Orders"
backOfficeOperator -> OrderManagementSys.orderWeb.BackofficeOrderMangementController "Manages Orders"
