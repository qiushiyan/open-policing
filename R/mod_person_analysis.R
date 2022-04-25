#' person_analysis UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_person_analysis_ui <- function(id){
  ns <- NS(id)
  tabItem(
    tabName = "persons_analysis",
    fluidRow(
      box(
        title = "Racial distribution",
        width = 6,
        gradient = TRUE,
        background = "navy",
        status = "teal",
        solidHeader = TRUE,
        collapsible = FALSE,
        echarts4rOutput(ns("persons_race"))
      ),
      box(
        title = "Age distribution",
        width = 6,
        status = "danger",
        closable = FALSE,
        maximizable = TRUE,
        collapsible = TRUE,
        sliderInput(ns("bins"), "Number of bins",
                    min = 50, max = 1000, value = 500
        ),
        plotOutput(ns("age_hist"))
    )
  ))
}

#' person_analysis Server Functions
#'
#' @noRd
mod_person_analysis_server <- function(id, con) {
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    persons <- dbGetQuery(con, "select * from persons_info limit 10000;")


    output$age_hist <- renderPlot(
      ggplot(persons) +
        geom_histogram(aes(subject_age), bins = input$bins)
    )

    output$persons_race <- renderEcharts4r(
      persons |>
        dplyr::group_by(subject_sex) |>
        dplyr::count(subject_race) |>
        e_charts(subject_race, timeline = TRUE) |>
        e_pie(n, roseType = "radius")
    )
  })
}

## To be copied in the UI
# mod_person_analysis_ui("person_analysis_1")

## To be copied in the server
# mod_person_analysis_server("person_analysis_1")
