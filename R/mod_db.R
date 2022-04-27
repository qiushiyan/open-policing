
#' db Server Functions
#'
#' @noRd
mod_db_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    con <- DBI::dbConnect(RMySQL::MySQL(),
                          host   = "localhost",
                          dbname = "stanford_policing",
                          user      = "root",
                          password  = "",
                          port     = 3306,
                          client_flag = CLIENT_MULTI_STATEMENTS + CLIENT_MULTI_RESULTS)

    con
  })
}

## To be copied in the UI
# mod_db_ui("db_1")

## To be copied in the server
# mod_db_server("db_1")
