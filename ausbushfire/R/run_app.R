#' Run the FWI dashboard
#'
#' @returns None
#'
#'
#' @examples
#' if (interactive()){
#' run_fwi_dashboard()
#' }
#' @export
run_fwi_dashboard <- function(){
  app_dir <- system.file("dashboard/app.R", package = "ausbushfire")
  shiny::runApp(app_dir, display.mode = "normal")
}
