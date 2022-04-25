

#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @noRd
app_ui <- function(request) {
  thematic_shiny()

  dashboardPage(
    dark = TRUE,
    help = TRUE,
    fullscreen = TRUE,
    scrollToTop = TRUE,
    header = dashboardHeader(
      title = dashboardBrand(
        title = "Open Policing",
        color = "primary",
        opacity = 0.8
      ) %>% tagAppendAttributes(style = "text-align:center;"),
      fixed = TRUE,
      tooltip(
        title = "This toggles the right sidebar",
        placement = "bottom",
        actionButton(inputId = "controlbarToggle", label = "Toggle Controlbar", class = "mx-2")
      ),
      popover(
        title = "Toggle button",
        content = "This toggle the left sidebar",
        placement = "bottom",
        actionButton(inputId = "sidebarToggle", label = "Toggle left sidebar", class = "mx-2")
      )
    ),
    sidebar = dashboardSidebar(
      fixed = TRUE,
      skin = "light",
      status = "primary",
      id = "sidebar",
      sidebarUserPanel(
        image = "https://adminlte.io/themes/v3/dist/img/AdminLTELogo.png",
        name = "Exploring traffic stops"
      ),
      sidebarMenu(
        id = "current_tab",
        flat = FALSE,
        compact = FALSE,
        childIndent = TRUE,
        menuItem(
          "about",
          tabName = "about",
          icon = icon("home")
        ),
        sidebarHeader("CRUD"),
        menuItem(
          "Persons",
          badgeLabel = "New",
          badgeColor = "success",
          tabName = "persons_crud",
          icon = icon("car")
        ),
        menuItem(
          "Stops",
          badgeLabel = "New",
          badgeColor = "success",
          tabName = "stops_crud",
          icon = icon("traffic-light")
        ),
        sidebarHeader("Analysis"),
        menuItem(
          "Persons",
          badgeColor = "success",
          tabName = "persons_analysis",
          icon = icon("car")
        ),
        menuItem(
          "Stops",
          badgeColor = "success",
          tabName = "stops_analysis",
          icon = icon("traffic-light")
        )
      ),
    ),
    controlbar = dashboardControlbar(id = "controlbar"),
    body = dashboardBody(
      tabItems(
        mod_about_ui("about"),
        mod_person_crud_ui("persons_crud"),
        mod_stop_crud_ui("stops_crud"),
        mod_person_analysis_ui("persons_analysis"),
        mod_stop_analysis_ui("stops_analysis")
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  useShinyFeedback()

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "openpolicing"
    ),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}