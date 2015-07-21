# 
# Usage: > test_dir("tests/",  reporter = "tap")
#

context("DeployR pacakage `deployrPackage(pkgs, ...)`")

describe("deployrPackage", {
  it("can install a package'", {      
    status <- FALSE
    tryCatch({
      deployrPackage("zoo")
      library("zoo")
      status <- TRUE
    }, 
    error = function(cond) {
      status <- FALSE
      print(cond)
    },
    finally = {
      #expect_equal(status, TRUE)
      tryCatch({
        remove.packages("zoo")
      }, 
      error = function(cond) {
        print(cond)
      })
    })
  })
})