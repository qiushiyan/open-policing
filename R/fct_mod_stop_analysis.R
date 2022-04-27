#' mod_stop_analysis
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
render_report <- function(input, output, params) {
  rmarkdown::render(input,
                    output_file = output,
                    params = params,
                    envir = new.env(parent = globalenv())
  )
}
