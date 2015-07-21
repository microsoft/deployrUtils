# 
# Usage: > test_dir("tests/",  reporter = "tap")
#

context("DeployR input `deployrInput(content)`")

describe("deployrInput", {
  it("can be configured to assign an 'integer'", {      
    deployrInput('{ "name": "intObj", "label": "Integer", "render": "integer", "default": 6 } ')
    expect_equal(intObj[1], 6)
  })
  
  it("can be configured to assign an 'integer' with min/max constraint", {      
    deployrInput('{ "name": "intObj", "label": "Integer", "render": "integer", "default": 6, "min": 5, "max": 10 }')
    expect_equal(intObj[1], 6)
  })

  it("can be configured to assign a 'number'", {      
    deployrInput('{ "name": "numObj", "label": "Number", "render": "number", "default": 6 } ')
    expect_equal(numObj[1], 6)
  })
  
  it("can be configured to assign a 'number' with min/max constraint", {      
    deployrInput('{ "name": "numObj", "label": "Number", "render": "number", "default": 6, "min": 5, "max": 10 } ')
    expect_equal(intObj[1], 6)
  })
  
  it("can be configured to assign a 'logical'", {      
    deployrInput('{ "name": "logicalObj", "label": "Logical", "render": "logical", "default": TRUE } ')
    expect_equal(logicalObj[1], TRUE)
  })
  
  it("can be configured to assign an 'character'", {      
    deployrInput('{ "name": "characterObj", "label": "Character", "render": "character", "default": "a" } ')
    expect_equal(characterObj[1], "a")
  })
  
  it("can be configured to assign a 'List of characters'", {      
    deployrInput( '{ "name": "characterListObj", "label": "CharacterList", "render": "character", "default": "a", "labels": [ "a", "b", "c", "d" ] } ')
    expect_equal(characterListObj[1], "a")
  })
  
  it("can be configured to assign a 'factor'", {      
    deployrInput( '{ "name": "factorObj", "label": "Factor", "render": "factor", "default": "b" } ')
    expect_equal(factorObj, factor("b"))
  })
  
  it("can be configured to assign an 'ordered factor'", {      
    deployrInput('{ "name": "orderedObj", "label": "Ordered", "render": "ordered", "default": "c" } ')
    expect_equal(factorObj, factor("b"))
  })
  
  it("can be configured to assign a 'file handle'", {      
    deployrInput('{ "name": "fileObj", "label": "File", "render": "file", "default": "sat.csv" } ')
    expect_equal(fileObj[1], 'sat.csv')
  })
})
