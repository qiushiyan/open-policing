#' person_crud UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_person_crud_ui <- function(id) {
  ns <- NS(id)
  tabItem(
    tabName = "persons_crud",
    fluidRow(
      box(
        title = "Create new person",
        elevation = 4,
        closable = TRUE,
        width = 6,
        solidHeader = TRUE,
        status = "primary",
        collapsible = TRUE,
        tagList(
          numericInput(ns("age"), "Age", value = 25, min = 0, max = 99),
          selectInput(ns("race"), "Race", all_races),
          selectInput(ns("sex"), "Sex", all_sex),
          actionButton(ns("create_person"), "Create")
        )
      ),
      box(
        title = "Preview person",
        elevation = 4,
        closable = TRUE,
        width = 6,
        solidHeader = TRUE,
        status = "primary",
        collapsible = TRUE,
        DT::dataTableOutput(ns("persons_table"))
      )
    )
  )
}

#' person_crud Server Functions
#'
#' @noRd
mod_person_crud_server <- function(id, con) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    persons <- suppressWarnings(dbGetQuery(con, "select * from persons_info limit 100"))

    observeEvent(input$create_person, {
      id <- notify("Inserting new person ...")
      on.exit(removeNotification(id = id))
      s <- glue::glue("CALL create_person({input$age}, '{input$race}', '{input$sex}')")

      ret <- tryCatch(
        dbGetQuery(con, s),
        error = function(cond) {
          notify(cond$message, id = id, type = "error")
        }
      )

      if (is.null(ret$error)) {
        notify(ret$error, id = id, type = "error")
      }

      notify("Insertion successful!", id = id)
      Sys.sleep(0.5)
    })


    output$persons_table <- DT::renderDT({
      persons
    })
  })
}

## To be copied in the UI
# mod_person_crud_ui("person_crud_1")

## To be copied in the server
# mod_person_crud_server("person_crud_1")