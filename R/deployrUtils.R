#' Develop portable R code for use in DeployR.
#'
#' @description The goal of \code{deployrUtils} is to solve several R portability issues that arise when developing R analytics for use in your local R environment and in the DeployR server environment. They are package portability, input portability, and portable access to data files.
#'
#' @details These portability issues can be solved when you use the following functions in the \code{deployrUtils} package. 
#' \itemize{
#'    \item{ Use \code{\link{deployrPackage}} to declare your package dependencies in your R code.}
#'	  \item{ Use \code{\link{deployrInput}} to declare the required inputs along with default values in your R code.}
#'	  \item{ Use \code{\link{deployrExternal}} to access big data files from your R code.}
#' }
#'
#' @docType package
#' @name deployrUtils
#' @author Microsoft Corporation
#' @references \url{http://go.microsoft.com/fwlink/?LinkId=692163}
#' 
#' \url{https://github.com/deployr/deployrUtils}
NULL