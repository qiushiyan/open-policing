#' about UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_about_ui <- function(id) {
  ns <- NS(id)
  tabItem(
    tabName = "about",
    bs4Dash::userBox(
      title = bs4Dash::userDescription(
        image = "https://images.unsplash.com/photo-1630783204535-cb30ffb3c0a1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1932&q=80",
        title = "Exploring traffic stops with open policing data",
      ),
      collapsible = FALSE,
      ribbon(
        text = "About",
        color = "fuchsia"
      ),
      status = "purple",
      elevation = 4,
      width = 8,
      includeMarkdown(app_sys("app/md/about.md"))
    )
  )
}

#' about Server Functions
#'
#' @noRd
mod_about_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
  })
}

## To be copied in the UI
# mod_about_ui("about_1")

## To be copied in the server
# mod_about_server("about_1")
