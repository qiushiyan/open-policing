#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  con <- mod_db_server("db")
  mod_about_server("about")
  mod_person_crud_server("persons_crud", con)
  mod_person_analysis_server("persons_analysis", con)
  mod_stop_crud_server("stops_crud", con)
  mod_stop_analysis_server("stops_analysis", con)

  observeEvent(input$sidebarToggle, {
    updateSidebar(id = "sidebar")
  })

  observeEvent(input$controlbarToggle, {
    updateControlbar(id = "controlbar")
  })
}