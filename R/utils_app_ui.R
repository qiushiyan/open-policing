#' ui helpers
#'
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
notify <- function(msg, id = NULL, type = "message", ...) {
  showNotification(msg, id = id, duration = NULL, closeButton = FALSE, type = type, ...)
}
