#' Declare inputs to ensure R script input portability.
#'
#' @description The \code{deployrInput} function allows you to declare the required inputs for your R script and provide default values for these inputs.  Default values ensure that your script can run successfully and that your R code is portable across your local environment and in the DeployR server environment.
#' 
#' The inputs can be used to:
#' \itemize{
#'    \item{Test a script locally within your R IDE environment AND again remotely within the DeployR Repository Manager Test page. In both test cases, use the default values to verify consistent behavior across environments.}
#'    \item{Provide client application developers with clear guidance as to which script inputs their application will be required to supply to produce meaningful output.}
#' }
#'
#'    
#' @param content  A valid JSON string configuration using the following 
#'   structure:
#'   \describe{  
#'      \item{\code{name}}{Required. A character string specifying a valid R object name.}
#'      \item{\code{default}}{Required. A default value for the input if one isn't passed by the calling application. If \code{render} is \code{character}, then the default value must be a character string. If \code{render} is \code{factor} or \code{ordered}, then the value can be a character string or a numeric value as long as the value matches either one of the levels or one of the labels. }
#'  	  \item{\code{render}}{Required. A character string specifying the type of input expected. Possible values are the classes \code{integer}, \code{numeric}, \code{logical}, \code{character}, \code{factor}, \code{ordered}, \code{vector}, \code{matrix}, \code{list}, and \code{data.frame}.}
#'		  \item{\code{label}}{A character string specifying the label that can be displayed in the calling application's interface.}
#'      \item{\code{min}}{If the \code{render} value is \code{numeric} or \code{integer}, then the minimum value accepted.}
#'      \item{\code{max}}{If the \code{render} value is \code{numeric} or \code{integer}, then the maximum value accepted.}
#'      \item{\code{levels}}{If the \code{render} is \code{character}, \code{factor}, or \code{ordered}, then an optional vector of possible values. If the \code{render}  is \code{factor}, or \code{ordered}, can be a character string or a numeric value but must match \code{default}. For character strings, enclose each level in quotes.}
#'      \item{\code{labels}}{If the \code{render} value is \code{character}, \code{factor}, or \code{ordered}, then either an optional vector of label strings for the levels in the same order as levels.}
#'      \item{\code{...}}{Additional arguments.}
#'   }
#'
#' 
#' @details
#' The  \code{name}, \code{render}, and \code{default} arguments are required. The entire input to the \code{deployrInput} function must be a valid JSON string. Within that string, JSON dictates that the argument names be double-quoted as should any strings. 
#' \cr Examples: 
#' \itemize{
#'    \item{ \code{deployrInput('{"name": "myName", "render": "integer", "default": 5}')}}
#'	  \item{ \code{deployrInput("{\"name\": \"myName\", \"render\": \"integer\", \"default\": 5}")}}
#'	  \item{ \code{deployrInput('{"name": "myName", "render": "logical", "default": "true"}')}}
#' }
#' \bold{Important!} In order to display an input configuration in the Test page of the DeployR Repository Manager, the argument for the \code{deployrInput} function must be a single literal string, and cannot be another function or variable.  For example, the following code could be used in an R script; however, no controls would appear in the Script Inputs pane in the Test page.
#' \cr 
#' \cr \code{args <- '{"name": "myName", "render": "integer", "default": 5}'}
#' \cr \code{deployrInput(args)}
#'
#'   
#' @examples
#' \dontrun{
#'  # Creates an integer variable named age if it does not exist
#'  deployrInput('{ "name": "age", "label": "Age", "render": "integer", "default": 6 } ')        
#'  
#'  # Creates a number variable named amt if it does not exist
#'  deployrInput('{ "name": "amt", "label": "Amount", "render": "numeric", 
#'     "default": 6, "min": 5, "max": 10 } ')          
#'  
#'  # Creates a number variable named amt if it does not exist
#'  deployrInput('{ "name": "amt", "label": "Amount", "render": "numeric", "default": 6 } ')
#'                  
#'  # Creates a logical variable named ownHome if it does not exist
#'  deployrInput('{ "name": "ownHome", "label": "Homeowner", "render": "logical", 
#'     "default": "TRUE" } ')
#'                  
#'  # Creates a character variable named fname if it does not exist
#'  deployrInput('{ "name": "fname", "label": "First Name", "render": "character", 
#'     "default": "Sue" } ')
#'                   
#'  # Creates a character variable named filetype if it does not exist
#'  deployrInput( '{ "name": "filetype", "label": "File Type", "render": "character", 
#'     "default": "png", "labels": [ "png", "bmp", "jpg", "tiff" ] } ')
#'                   
#'  # Creates a factor variable named filetype if it does not exist
#'  deployrInput( '{ "name": "filetype", "label": "File Type", "render": "factor", 
#'     "default": "png" } ')
#'                   
#'  # Creates an ordered factor variable named rating if it does not exist
#'  deployrInput('{ "name": "rating", "label": "Rating", "render": "ordered", 
#'     "levels": [ "Good", "Better", "Best" ], "default": "Good" } ')
#' }
#' 
#' @export
deployrInput <- function(content) { 
  JSONResult <- getJSON(content)
  name = NULL
  default = NULL
  render = NULL
  label = NULL
  min = NULL
  max = NULL
  levels = NULL
  labels = NULL

  n <- names(JSONResult)
  for(i in 1:length(JSONResult)) {
    assign(n[i], JSONResult[[i]])
  }

  #
  # create an object whose value is either the default or the value set in the
  # name parameter.  This allows the object to exist prior to using the UI
  #
  if (!is.null(default)) {
    x <- default
  }
  
  #
  # if `name` variable exists, use it instead of default
  #
  if (!is.null(name)) {
    if (exists(name)) {
      x <- get(name)  
    }
  }
  
  #
  # If levels are present, set render to factor, otherwise we don't care what
  # it is! Make sure it is not null so that we can test it in the rest of this
  # function
  #
  if (is.null(render)){
    if (!is.null(levels)) {
      render <- "factor"
    } else {
      render <- "unknown"
    }
  }
  
  # 
  # Assigne `factor` and `ordered-factor` with `levels|labels` if present
  # to the `default`. Skip if object already exsists and use that.
  #
  if (!exists(name) && render %in% c("factor", "ordered")) {
    if (!is.null(labels) && !is.null(levels)) {      
      x <- get(render)(x, levels = levels, labels = labels)
    } else if (!is.null(levels)) {
      x <- get(render)(x, levels = levels)
    } else {
      x <- get(render)(x) 
    }
  }
  
  if (!is.null(render)) {
    if( render == "integer" ) {
      x <- as.integer(x)
    } else if( render == "logical" ) {
      x <- as.logical(x)
    }
  }
  
  # Not yet using min, max  
  assign(name, x, envir = .GlobalEnv) 
}

#' Define R Script Inputs \bold{deprecated}.
#' 
#' This function is now \bold{deprecated}. Please transition to 
#' \code{\link{deployrInput}}.
#'
#' @param content A valid JSON string configuration.
#' 
#' @export
revoInput <- function(content) { 
  warning("'revoInput()' had been deprecated. Please use 'deployrInput()'.")
  deployrInput(content)
}