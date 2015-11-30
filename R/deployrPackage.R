#' Install and load R packages to ensure package portability.
#' 
#' @description The \code{deployrPackage} function guarantees package portability from your local environment to the DeployR server environment when you use it to declare all of the package dependencies in your R script. 
#'    
#' This function safeguards your R code by making certain that the necessary packages are available to your R code at runtime.
#' 
#' For more information on ensuring package portability, see the \sQuote{Writing Portable R Code} document for your DeployR version on the official DeployR website (\url{http://go.microsoft.com/fwlink/?LinkId=708337}).
#'    
#' @details Declare the set of package dependencies using this function at the top of your script.
#'    
#' Packages declared using this function are automatically loaded at runtime, either in your local environment or on the DeployR server. The function checks whether the package is installed on the machine on which the script is running. If the package already exists, then it is loaded for you. If not found, the function attempts to install and load the package on your behalf. The \code{deployrPackage} function supports all the same arguments as the regular R \code{\link{install.packages}} function.
#' 
#' Note: If you declare your package dependencies with this function and your script still fails due to missing packages, please contact your DeployR server administrator with details.
#'    
#' @param pkgs  character vector of the names of packages whose current versions should be downloaded from the repositories. If \code{repos = NULL}, a character vector of file paths  of \code{.tar.gz} files. If this is missing or a zero-length, character vector, a listbox of available packages is presented where possible in an interactive R session.
#'   
#' @param lib  character vector providing the library directories where to install the packages. Recycled as needed. If missing, defaults to the first element of \code{.libPaths().}
#'   
#' @param repos  character vector, the base URL(s) of the repositories to use, such as the URL of a CRAN mirror (for example: \url{http://go.microsoft.com/fwlink/?LinkId=708336}.) Can be \code{NULL} to install from local files (with extension \code{.tar.gz} for source packages). \cr Tip: If you develop your own private R packages and want to use them in DeployR, then we recommend storing these packages in a local CRAN repository that is reachable by the DeployR server. For more on setting up a local package repository, visit: \url{http://cran.r-project.org/doc/manuals/r-release/R-admin.html}.
#'   
#' @param ...  additional arguments to pass to \code{\link{install.packages}} function.
#'   
#'    
#' @examples 
#' \dontrun{
#'   
#'   ### PACKAGE DECLARATIONS ###
#'   # Use deployrPackage() to ensure package dependencies are 
#'   # installed & loaded at the start of your script.
#'   
#'   deployrPackage("ggplot2")
#' }
#' 
#' @keywords load packages
#'      
#' @export
deployrPackage <- function(pkgs, lib, repos = getOption("repos"), ...) {
  #
  # this function checks to see if the declared pkgs are installed. If not, 
  # pkgs are installed. In all cases the packages are loaded
  #
  if (!suppressWarnings(require(pkgs, character.only = TRUE))) {
    install.packages(pkgs, lib, repos = repos, ...)
    if(!suppressWarnings(require(pkgs, character.only = TRUE))) {
      stop("Package not found")
    }
  }
  
  suppressWarnings(require(pkgs, character.only = TRUE))
}

#' Install and load R packages. \bold{deprecated}.
#'
#' This function is now \bold{deprecated}. Please transition to 
#' \code{\link{deployrPackage}}.
#'
#' @param pkgs package nam
#' @param repos test code containing expectations
#' @param ...  additional arguments to pass to \code{install.packages()}.
#' 
#' @export
revoPackage <- function(pkgs, repos = getOption("repos"), ...) {
  warning("'--revoPackage()' had been deprecated. Please use 'deployrPackage()'.")  
  deployrPackage(pkgs, repos, ...)
}