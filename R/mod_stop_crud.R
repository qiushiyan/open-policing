#' stop_crud UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_stop_crud_ui <- function(id) {
  ns <- NS(id)
  tabItem(
    tabName = "stops_crud",
    fluidRow(
      box(
        title = "Insert new stop record",
        elevation = 4,
        closable = TRUE,
        width = 6,
        solidHeader = TRUE,
        status = "primary",
        collapsible = TRUE,
        tagList(
          fluidRow(
            textInput(ns("city"), "city", ""),
            textInput(ns("state"), "state", ""),
          ) %>% tagAppendAttributes(style = "justify-content:space-between;"),
          sliderInput(ns("lng"), "lng", value = -85, min = -91, max = -81),
          sliderInput(ns("lat"), "lat", value = 36, min = 34, max = 37),
          fluidRow(
            textInput(ns("zipcode"), "zip code", ""),
            textAreaInput(ns("street_address"), "street address", ""),
          ) %>% tagAppendAttributes(style = "justify-content:space-between;"),
        ),
        actionButton(ns("create_stop_location"), "Create")
      ),
      box(
        title = "Preview stop locations",
        elevation = 4,
        closable = TRUE,
        width = 6,
        solidHeader = TRUE,
        status = "primary",
        collapsible = TRUE,
        DT::dataTableOutput(ns("stops_table"))
      )
    )
  )
}

#' stop_crud Server Functions
#'
#' @noRd
mod_stop_crud_server <- function(id, con) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    stops <- suppressWarnings(dbGetQuery(con, "select * from stop_location limit 100"))

    observeEvent(input$create_stop_location, {
      # if ((input$zipcode != "") && ((nchar(input$zipcode) != 5) || is.na(as.numeric(input$zipcode)))) {
      #   showFeedbackWarning("zipcode", text = "zip code should be 5 digits")
      # } else {
      #   # hideFeedback("zipcode")
      #   # id <- notify("Inserting new stop ...")
      #   # on.exit(removeNotification(id = id))
      #   # s <- glue::glue("CALL create_stop_location('{input$city}', {input$lat}, {input$lng}, '{input$state}', '{input$state_address}', {input$zipcode})")
      #   # ret <- tryCatch(
      #   #   dbGetQuery(con, s),
      #   #   error = function(cond) {
      #   #     notify(cond$message, id = id, type = "error")
      #   #   }
      #   # )

      #   # if (is.null(ret$error)) {
      #   #   notify(ret$error, id = id, type = "error")
      #   # }

      #   # notify("Insertion successful!", id = id)
      #   # Sys.sleep(0.5)
      # }


      id <- notify("Inserting new stop ...")
      on.exit(removeNotification(id = id))
      s <- glue::glue("CALL create_stop_location('{input$city}', {input$lat}, {input$lng}, '{input$state}', '{input$state_address}', {input$zipcode})")
      ret <- tryCatch(
        dbGetQuery(con, s),
        error = function(cond) {
          notify(cond$message, id = id, type = "error")
        }
      )
      # if (is.null(ret$error)) {
      #   notify(ret$error, id = id, type = "error")
      # }

      notify("Insertion successful!", id = id)
      Sys.sleep(0.5)
    })


    output$stops_table <- DT::renderDT({
      stops
    })
  })
}

## To be copied in the UI
# mod_stop_crud_ui("stop_crud_1")

## To be copied in the server
# mod_stop_crud_server("stop_crud_1")