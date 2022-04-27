#' stop_analysis UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_stop_analysis_ui <- function(id) {
  ns <- NS(id)
  tabItem(
    tabName = "stops_analysis",
    fluidRow(
      box(
        title = "Stop proportions by race",
        width = 4,
        status = "white",
        solidHeader = TRUE,
        collapsible = FALSE,
        echarts4rOutput(ns("stops_year_race"))
      ),
      box(
        title = "Arrest proportions by race",
        width = 8,
        status = "white",
        solidHeader = TRUE,
        collapsible = FALSE,
        echarts4rOutput(ns("arrest_prop_race"))
      ),
    ),
    fluidRow(
      box(
        title = "Report",
        witdth = 6,
        status = "indigo",
        solidHeader = TRUE,
        collapsible = FALSE,
        tagList(
          p("Generate your racial statistics report for given year, including relative proportions of arrest, citation, warning, etc."),
          selectInput(ns("year"), "Year", choices = 2010:2019, selected = 2019),
          downloadButton(ns("report"), "Generate")
        )

      )
    )
  )
}

#' stop_analysis Server Functions
#'
#' @noRd
mod_stop_analysis_server <- function(id, con) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    stops_year_race <- dbGetQuery(con, "select * from stops_year_race")
    stops_year_race$year <- as.integer(stops_year_race$year)
    arrest_prop_race <- dbGetQuery(con, "select * from arrest_prop_race")

    output$stops_year_race <- renderEcharts4r(
      stops_year_race |>
        group_by(subject_race) |>
        e_charts(year) |>
        e_line(prop) |>
        e_tooltip(trigger = "axis") |>
        e_x_axis(year)
    )

    output$arrest_prop_race <- renderEcharts4r(
      arrest_prop_race |>
        mutate(subject_race = forcats::fct_reorder(subject_race, arrest_prop)) |>
        group_by(subject_race) |>
        e_charts(subject_race, reorder = FALSE) |>
        e_bar(arrest_prop, width = 5) |>
        e_tooltip() |>
        e_labels(position = "right", formatter = htmlwidgets::JS("
          function(params){
            return((params.value[0] * 100).toFixed(3) + '%')
          }
      ")) |>
        e_flip_coords()
    )

    output$report <- downloadHandler(
      filename = "report.pdf",
      content = function(file) {
        params <- list(year = input$year)

        id <- notify("Rendering report...")
        on.exit(removeNotification(id), add = TRUE)

        callr::r(
          render_report,
          list(input = app_sys("app/rmd/report-template.Rmd"), output = file, params = params)
        )
      }
    )
  })
}

## To be copied in the UI
# mod_stop_analysis_ui("stop_analysis_1")

## To be copied in the server
# mod_stop_analysis_server("stop_analysis_1")
