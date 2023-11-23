systemContext AnalyticsSys "Diagram1" {
      include *
      autoLayout
}

container AnalyticsSys "AnalyticsSys_Containers" {
      include *
      autoLayout
}

container AnalyticsSys "AnalyticsSys_Containers_Dependencies_as_Container" "TBD" {
      include "->AnalyticsSys.backgroundService-> && element.type==Container"
}
