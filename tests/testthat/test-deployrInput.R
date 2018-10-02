# 
# Usage: > test_dir("tests/",  reporter = "tap")
#

context("DeployR input `deployrInput(content)`")

describe("deployrInput", {
  it("can be configured to assign an 'integer'", {      
    deployrInput('{ "name": "input_integer_default", "render": "integer", "default": 6 } ')
    expect_equal(input_integer_default, 6)
  })
  
  it("can be configured to assign an 'integer' with min/max constraint", {      
    deployrInput('{ "name": "input_integer_min_max", "render": "integer", "default": 7, "min": 5, "max": 10 }')
    expect_equal(input_integer_min_max, 7)
  })

  it("can be configured to assign a 'numberic'", {      
    deployrInput('{ "name": "input_numeric_default", "render": "numeric", "default": 6 } ')
    expect_equal(input_numeric_default, 6)
  })
  
  it("can be configured to assign a 'numberic' with min/max constraint", {      
    deployrInput('{ "name": "input_numeric_min_max", "render": "numeric", "default": 7, "min": 5, "max": 10 } ')
    expect_equal(input_numeric_min_max, 7)
  })
  
  it("can be configured to assign a 'logical'", {      
    deployrInput('{ "name": "input_logical_default", "render": "logical", "default": "TRUE" } ')
    expect_equal(input_logical_default, TRUE)
  })
  
  it("can be configured to assign an 'character'", {      
    deployrInput('{ "name": "input_character_default", "render": "character", "default": "a" } ')
    expect_equal(input_character_default, "a")
  })
  
  it("can be configured to assign a 'List of characters'", {      
    deployrInput( '{ "name": "characterListObj", "render": "character", "default": "a", "labels": [ "a", "b", "c", "d" ] } ')
    expect_equal(characterListObj[1], "a")
  })
  
  it("can be configured to assign a 'factor'", {      
    deployrInput( '{ "name": "input_factor_default", "render": "factor", "default": "b" } ')
    expect_equal(input_factor_default, factor("b"))
  })
  
  it("can be configured to assign a 'factor' with 'levels'", { 
    deployrInput( '{ "name": "input_factor_default_levels", "render": "factor", "levels": [1, 2], "default": 1 } ')
    expect_equal(levels(input_factor_default_levels), c("1", "2"));
    expect_equal(as.integer(input_factor_default_levels), 1)   
    expect_equal(input_factor_default_levels, factor("1", levels = c(1, 2)))
  })
    
  it("can be configured to assign a 'factor' with 'levels' and 'labels'", { 
    deployrInput( '{ "name": "input_factor_default_levels_labels", "render": "factor", "levels": [1, 2], "labels": [ "png", "bmp" ], "default": 2 } ')
    expect_equal(as.character(input_factor_default_levels_labels), "bmp")
    expect_equal(input_factor_default_levels_labels, factor(c(2), levels = c(1,2), labels = c("png", "bmp"))) 
  })
  
  it("can be configured to assign an 'ordered factor'", {      
    deployrInput('{ "name": "input_ordered_default", "render": "ordered", "default": "c" } ')
    expect_equal(input_ordered_default, factor("c", ordered = TRUE))
  })
  
  it("can be configured to assign a 'ordered factor' with 'levels'", { 
    deployrInput( '{ "name": "input_ordered_default_levels", "render": "ordered", "levels": ["5", "6", "7"], "default": "7" } ')
    expect_equal(levels(input_ordered_default_levels), c("5", "6", "7"));
    expect_equal(as.integer(input_ordered_default_levels), 3); # 3 == the level index of default: "7" for ordered
    expect_equal(input_ordered_default_levels, factor("7", levels = c(5, 6, 7), ordered = TRUE))  
  })
    
  it("can be configured to assign a 'ordered factor' with 'levels' and 'labels'", { 
    deployrInput( '{ "name": "input_ordered_default_levels_labels", "render": "ordered", "levels": [1, 2], "labels": [ "car", "truck" ], "default": 2 } ')
    expect_equal(as.character(input_ordered_default_levels_labels), "truck")   
    expect_equal(input_ordered_default_levels_labels, factor(c(2), levels = c(1,2), labels = c("car", "truck"), ordered = TRUE))
  })
  
  it("can be configured to assign a 'file handle'", {      
    deployrInput('{ "name": "input_file_default", "render": "file", "default": "sat.csv" } ')
    expect_equal(input_file_default, 'sat.csv')
  })
})

describe("deployrInput ignore default", {
  it("should use existing 'integer' value", {
    input_integer <- 10
    deployrInput('{ "name": "input_integer", "render": "integer", "default": 1 } ')
    expect_equal(input_integer, 10)
  })

  it("should use existing 'numeric' value", { 
    input_numeric <- 10
    deployrInput('{ "name": "input_numeric", "render": "numeric", "default": 2 } ')
    expect_equal(input_numeric, 10)
  })
   
  it("should use existing 'logical' value", { 
    input_logical <- FALSE
    deployrInput('{ "name": "input_logical", "render": "logical", "default": "TRUE" } ')
    expect_equal(input_logical, FALSE)
  })

  it("should use existing 'character' value", { 
    input_character <- "Hello World"
    deployrInput('{ "name": "input_character", "render": "character", "default": "Sue" } ')
    expect_equal(input_character, "Hello World")
  })

  it("should use existing 'factor' value", { 
    input_factor <- factor(c("bpm"))
    deployrInput( '{ "name": "input_factor", "render": "factor", "default": "png" } ')
    expect_equal(as.character(input_factor), "bpm")
  })
  
  it("should use existing 'factor' value with 'levels' and 'labels'", { 
    input_factor_levels_labels <- factor(c(7), levels = c(5, 6, 7, 8), labels = c("png", "bmp", "jpg", "tiff"))
    deployrInput( '{ "name": "input_factor_levels_labels", "render": "factor", levels": [5, 6, 7, 8], "labels": [ "png", "bmp", "jpg", "tiff" ], "default": 5 } ')
    expect_equal(as.character(input_factor_levels_labels), "jpg")
    expect_equal(input_factor_levels_labels, factor(c(7), levels = c(5, 6, 7, 8), labels = c("png", "bmp", "jpg", "tiff")))
  })

  it("should use existing 'ordered factor' value", {
    input_ordered <- factor(c("Best"), ordered = TRUE)
    deployrInput('{ "name": "input_ordered", "render": "ordered", "levels": [ "Good", "Better", "Best" ], "default": "Good" } ')
    expect_equal(as.character(input_ordered), "Best")
  })
  
  it("should use existing 'ordered factor' value with 'levels' and 'labels'", { 
    input_ordered_levels_labels <- factor(c(3), levels = c(1, 2, 3), labels = c("Good", "Better", "Best"),  ordered = TRUE)
    deployrInput('{ "name": "input_ordered_levels_labels", "render": "ordered", "levels": [1, 2, 3], "labels": [ "Good", "Better", "Best" ], "default": "1" } ')
    expect_equal(as.character(input_ordered_levels_labels), "Best")
  })
})

