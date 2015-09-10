#' Access big data files in a portable way across environments.
#'
#' @description If you need to work with very large data files and want your R code to run consistently when accessing those files locally and on the DeployR Server, then use the \code{deployrExternal} function. 
#' This function provides you with a consistent way of referencing these big data files for reading and writing; thereby, making your R code portable.
#' 
#' \strong{Important!} In order to get your big data files into the DeployR environment, you must first ask the DeployR administrator to place a copy of those files in the appropriate external directory on the server on your behalf. Once the files have been copied onto the server, your R code can reference these files by specifying the filename as an argument on the \code{deployrExternal} function.
#' 
#' When your code executes locally, the function looks for the data files in the current working directory of your R session. When your code executes remotely on the DeployR server, the function looks for the data files in the dedicated external directories configured and managed by the DeployR administrator.
#' 
#' For more information on configuring or using external directories, see the \sQuote{Writing Portable R Code} document for your DeployR version on the official DeployR website (\url{http://deployr.revolutionanalytics.com/documents/dev/scientist-portable-code/}).
#' 
#' @param file Required. A character string specifying a valid filename with its extension. 
#' @param isPublic Optional. If \code{isPublic = NULL} or \code{isPublic = FALSE} and code is running on DeployR, then the file is assumed to be in your private user external directory. If \code{isPublic = TRUE} and code is running on DeployR, then the file is assumed to be in the public external directory. Since the usage of the public external directory is ultimately a deployment decision, please coordinate with the application developer(s) before enabling this argument.
#' 
#' @details
#' The \code{deployrExternal} function allows you access to file data portably by identifying the filename as an argument on the function call. The function then locates the file for you as follows:
#' \itemize{
#'    \item{In your local environment, the function looks for the data file in the current working directory for your local R session. In order for your R code to locate the local file with this function, make certain that a copy of the data file exists in your local working directory. Any references to the \code{isPublic} argument are ignored.}
#'    \item{In your remote DeployR environment, the function locates the data file without requiring you to know the exact physical location of the file on the DeployR server. In order for your R code to find the file data, ask your DeployR administrator to physically store a copy in the external directory for you. The function looks in your private directory unless \code{isPublic = TRUE}, in which case it looks in the public external directory.  Note: This function will not permit R code to write to files in the public external directory.}
#' }
#' \strong{Important!} If your R code fails on the DeployR server, ask your DeployR administrator to verify that the files you sent him or her were, in fact, deployed to the external directories.
#' 
#' @examples
#' \dontrun{
#' 
#'     ## READ CSV FILE
#'     ## Local: find in current working directory
#'     ## DeployR: find in user's external directory
#'     data <- read.csv(file = deployrExternal("data.csv"))
#' 
#'     ## READ CSV FILE
#'     ## Local: find in current working directory
#'     ## DeployR: find in public external directory
#'     data <- read.csv(file = deployrExternal("data.csv", isPublic = TRUE))
#' 
#'     ## READ XDF FILE FROM SCALER & STORE AS DATAFRAME (df)
#'     ## Local: find in current working directory
#'     ## DeployR: find in user's external directory
#'     df <- RxXdfData(deployrExternal("data.xdf"))
#' 
#'     ## WRITE TO CSV FILE 
#'     ## Local: write to current working directory
#'     ## DeployR: write to user's external directory
#'     write.csv(file = deployrExternal("data.csv"))
#' 
#'     ## WRITE TO XDF FILE FROM DATAFRAME
#'     ## Local: write to current working directory
#'     ## DeployR: write to user's external directory
#'     rxDataFrameToXdf(data = df, outFile = deployrExternal("data.xdf"), overwrite = TRUE)
#' }
#' 
#' @export
deployrExternal <- function(file, isPublic = FALSE) {
  if (length(getOption("deployrPublicExternalDir")) != 0) {
    if (isPublic) {
      return (paste(getOption("deployrPublicExternalDir"), file, sep="/"));
    } else {
      return (paste(getOption("deployrPrivateExternalDir"), file, sep="/"));
    }
  } else {
    return (paste(getwd(), file, sep="/"))
  }
}