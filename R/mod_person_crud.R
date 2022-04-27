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
    box(
      title = "Preview person",
      elevation = 4,
      closable = TRUE,
      width = 12,
      solidHeader = TRUE,
      status = "primary",
      collapsible = TRUE,
      DT::dataTableOutput(ns("persons_table"))
    ),
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
        title = "Edit person",
        elevation = 4,
        closable = TRUE,
        width = 6,
        solidHeader = TRUE,
        status = "white",
        collapsible = TRUE,
        tagList(
          textInput(ns("edit_row_number"), "Person ID", ""),
          numericInput(ns("edit_age"), "Age", value = 25, min = 0, max = 99),
          selectInput(ns("edit_race"), "Race", all_races),
          selectInput(ns("edit_sex"), "Sex", all_sex),
          actionButton(ns("edit_person"), "Edit")
        )
      )
    ),
    fluidRow(
      box(
        title = "Delete a person",
        elevation = 4,
        closable = TRUE,
        width = 3,
        solidHeader = TRUE,
        status = "info",
        collapsible = TRUE,
        tagList(
          textInput(ns("delete_row_number"), "Person ID", ""),
          actionButton(ns("delete_person"), "Delete")
        )
      ),
      box(
        title = "Persons archive",
        elevation = 4,
        closable = TRUE,
        width = 9,
        solidHeader = TRUE,
        status = "info",
        collapsible = TRUE,
        tableOutput(ns("persons_archive"))
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

    persons <- eventReactive(c(input$edit_person, input$delete_person, input$create_person), {
      suppressWarnings(dbGetQuery(con, "select * from persons_info order by raw_row_number limit 100;"))
    })

    archive <- eventReactive(c(input$edit_person, input$delete_person, input$create_person), {
      suppressWarnings(dbGetQuery(con, "select * from persons_archives"))
    })

    observeEvent(input$create_person, {
      id <- notify("Inserting new person ...")
      on.exit(removeNotification(id = id))
      s <- glue::glue("INSERT INTO persons_info (subject_age, subject_race, subject_sex) VALUES ({input$age}, '{input$race}', '{input$sex}')")

      tryCatch(
        {
          dbGetQuery(con, s)
          notify("Insertion successful!", id = id)
        },
        error = function(cond) {
          notify(cond$message, id = id, type = "error")
        }
      )

      Sys.sleep(2)
    })


    observeEvent(input$edit_person, {
      if ((input$edit_row_number == "") || is.na(as.numeric(input$edit_row_number))) {
        showNotification("Person id should be non-empty digits.", type = "error", duration = 2)
      } else {
        id <- notify("finding person ...")
        on.exit(removeNotification(id = id))
        number <- as.integer(input$edit_row_number)
        s1 <- glue::glue("SELECT COUNT(*) FROM persons_info WHERE raw_row_number = {number}")
        no_person <- (dbGetQuery(con, s1) == 0)

        if (no_person) {
          notify("Person id not found, do you want to create instead 👈 ?", id = id, type = "error")
        } else {
          s2 <- glue::glue("UPDATE persons_info SET subject_age = {input$age}, subject_sex = '{input$sex}', subject_race = '{input$race}' WHERE raw_row_number = {number}")
          ret <- dbGetQuery(con, s2)
          notify("Deletion successful!", id = id)
        }
      }
      Sys.sleep(2)
    })

    observeEvent(input$delete_person, {
      if ((input$delete_row_number == "") || is.na(as.numeric(input$delete_row_number))) {
        id <- notify("Person id should be non-empty digits.", type = "error")
        on.exit(removeNotification(id = id))
        return()
      }
      id <- notify("Deleting person ...")
      on.exit(removeNotification(id = id))
      number <- as.integer(input$delete_row_number)

      s1 <- glue::glue("SELECT COUNT(*) FROM persons_info WHERE raw_row_number = {number}")
      no_person <- (dbGetQuery(con, s1) == 0)

      if (no_person) {
        notify("Person id not found, do you want to create instead 👆 ?", id = id, type = "error")
      } else {
        s2 <- glue::glue("DELETE FROM persons_info WHERE raw_row_number = {number}")
        ret <- dbGetQuery(con, s2)
        notify("Deletion successful!", id = id)
      }

      Sys.sleep(2)

      # ret <- tryCatch(
      #   dbGetQuery(con, s),
      #   error = function(cond) {
      #     notify(cond$message, id = id, type = "error")
      #   }
      # )
      #
      # print(ret)
      #
      # if ("error" %in% names(ret)) {
      #
      # } else {
      #   notify("Deletion successful!", id = id)
      # }
      # Sys.sleep(2)
    })

    output$persons_archive <- renderTable(archive())

    output$persons_table <- DT::renderDataTable(
      {
        persons()
      },
      rownames = FALSE
    )
  })
}

## To be copied in the UI
# mod_person_crud_ui("person_crud_1")

## To be copied in the server
# mod_person_crud_server("person_crud_1")
