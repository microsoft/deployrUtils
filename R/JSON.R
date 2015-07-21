#
# Defines the JSON.parse for `the deployrInputs(jsonStr)`
# 
# @private
#
getJSON <- function(json) {
  source <- json;
  at <- 1;
  ch <- ' ';
  
  white <- function () {
    
    ## Skip whitespace.
    
    while (TRUE) {
      JSON_nextc();
      if(ch != ' ')break;
    }
  }
  
  JSON_nextc <- function (c=NULL) {    
    ## If a c parameter is provided, verify that it matches the current 
    ## character.
    
    if (!is.null(c) && c != ch) {
      JSON_error(paste("Expected '", c, "' instead of '", ch, "'", sep=""))
    }
    
    ## Get the nextc character. When there are no more characters,
    ## return the empty string.
    while(TRUE) {
      ch <<- substr(source,at,at);
      at <<- at + 1;
      if(ch != ' ')return(ch)           
    }
  }
  
  JSON_number <- function () {    
    ## Parse a number value.    
    number <- 0
    string <- '';
    
    if (ch == '-') {
      string <- '-';
      JSON_nextc('-');
    }
    while ((ch >= '0' && ch <= '9') || ch == '.' ) {
      string <- paste(string,ch,sep="")
      JSON_nextc();
    }
   
    if (ch == 'e' || ch == 'E') {
      string <- paste(string,ch,sep="")
      JSON_nextc();
      if (ch == '-' || ch == '+') {
        string <- paste(string,ch,sep="")
        JSON_nextc();
      }
      while (ch >= '0' && ch <= '9') {
        string <- paste(string,ch,sep="")
        JSON_nextc();
      }
    }
    number = as.numeric(string);
    return(number);   
  }
  
  JSON_string <- function () {    
    ## Parse a string value.    
    hex <- ''
    i <- 0;
    string <- ''
    uffff <- '';
        
    while (JSON_nextc() != "") {
      if (ch == '"' || ch == "'") {
        JSON_nextc();
        return(string);
      }                   
      string <- paste(string,ch,sep="")
    }
    JSON_error("Bad string");
  }
  
  JSON_word <- function () {    
    if(ch == 'T') {
      JSON_nextc('T');
      JSON_nextc('R');
      JSON_nextc('U');
      JSON_nextc('E');
      return(TRUE);
    } else if(ch == 'F') {
      JSON_nextc('F');
      JSON_nextc('A');
      JSON_nextc('L');
      JSON_nextc('S');
      JSON_nextc('E');
      return(FALSE);
    } else if(ch == 'N') {
      JSON_nextc('N');
      JSON_nextc('U');
      JSON_nextc('L');
      JSON_nextc('L');
      return(NULL);
    }
    JSON_error(paste("Unexpected '" , ch , "'", sep=""));
  }
  
  JSON_array <- function () {    
    ## Parse an array value.    
    array <- "";
    array <- as.numeric(array);
    
    if (ch == '[') {
      JSON_nextc('[');
      if (ch == ']') {
        JSON_nextc(']');
        return(array);   ## empty array
      }
      array <- JSON_value();
      JSON_nextc(',');
      while (ch != "") {
        array <- append(array, JSON_value())
        if (ch == ']') {
          JSON_nextc(']');
          return(array);
        }
        JSON_nextc(',');
      }
    }
    JSON_error("Bad array");
  }
  
  JSON_object <- function () {    
    ## Parse an object value.    
    key <- ""
    object <- list();
    
    if (ch == '{') {
      JSON_nextc('{');
      if (ch == '}') {
        JSON_nextc('}');
        return(object)   ## empty object
      }
      while (ch != "") {
        key <- JSON_string();
        JSON_nextc(':');
        object[[key]] <- JSON_value();
        if (ch == '}') {
          JSON_nextc('}');
          return(object);
        }
        JSON_nextc(',');
      }
    }
    JSON_error("Bad object");
  }
  
  JSON_value <- function () {    
    ## Parse a JSON value. It could be an object, an array, a string, a number,
    ## or a word.    
    if(ch == '{') return(JSON_object())
    else if(ch == '[') return(JSON_array())
    else if(ch == '"' || ch == "'") return(JSON_string())
    else if(ch == '-') return(JSON_number())
    else {
      if((ch >= '0' && ch <= '9') || ch == '.' ) return(JSON_number())
      else return(JSON_word())
    }
  }
  
  JSON_error <- function (m) {    
    ## Call stop when something is wrong.
    stop(paste("error in JSON",m,sep="-"))
    
  }
  
  JSON_nextc()
  result <- JSON_value();
  if (ch != "") {
    JSON_error("Syntax error");
  }
  return(result)
}