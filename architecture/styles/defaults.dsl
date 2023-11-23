theme default
theme https://static.structurizr.com/themes/microsoft-azure-2023.01.24/theme.json

element "Software System" {
    shape Box
    strokeWidth 4
}

element Container {
    shape roundedbox
    background #438dd5
    color #ffffff
}

element "Service" {
    shape Hexagon
    fontSize 16
}

element "Database" {
    shape cylinder
}

element "Storage" {
    shape cylinder
}

element "WebApp" {
    shape WebBrowser
}

element "MobileApp" {
    shape MobileDevicePortrait
}

element Component {
    shape Component
    fontSize 16
}

element "Group" {
    color #ffffff
    strokeWidth 5
}

element "queue" {
    shape Pipe
}
element "topic" {
    shape Pipe
}
