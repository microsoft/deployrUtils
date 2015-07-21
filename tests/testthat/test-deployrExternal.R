# 
# Usage: > test_dir("tests/",  reporter = "tap")
#

context("DeployR external `deployrExternal(file, isPublic)`")

describe("deployrExternal", {
  it("can reference external files for reading and writing", { 
    filename <- "output.txt"
    fileConn <- file(deployrExternal(filename))
    writeLines("DeployR", fileConn)
    close(fileConn)
    
    lines <- readLines((deployrExternal(filename)))
    expect_equal(lines[1], "DeployR")
    
    if (file.exists(filename)) {
      file.remove(filename)
    }
  })
})