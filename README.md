# deployrUtils - Develop Portable R Code for Use with DeployR

[![Build Status](http://nicrdepstaging.cloudapp.net:8080/buildStatus/icon?job=deployrUtils)](http://nicrdepstaging.cloudapp.net:8080/job/deployrUtils/)

## Package Overview

The goal of `deployrUtils` is to solve several R portability issues that arise when developing R analytics for use in your local R environment and in the [DeployR](https://deployr.revolutionanalytics.com) server environment. They are package portability, input portability, and portable access to data files.

These portability issues can be solved when you use the following functions in the deployrUtils package.

+ Use the `deployrPackage` function to declare your package dependencies in your R code.
+ Use the `deployrInput` function to declare the required inputs along with default values in your R code.
+ Use the `deployrExternal` function to access big data files from your R code.

## Package Installation

<!--
Get the stable version from CRAN:
```R
install.packages("deployrUtils")
library("deployrUtils")
```
-->

Get the latest stable development version from github:
```R
# Use `devtools` to install directly from github
library(devtools)
install_github("deployr/deployrUtils")
```

See [devtools](https://github.com/hadley/devtools) for more options.

## Usage

Install and load R packages to ensure package portability:

```R
# Use `deployrPackage()` to ensure package dependencies are installed & loaded 
# at the start of your script.
> deployrPackage("checkpoint")
Loading required package: checkpoint
...
...
...
checkpoint: Part of the Reproducible R Toolkit from Revolution Analytics
http://projects.revolutionanalytics.com/rrt/
```

Declare inputs to ensure R script input portability:

```R
# Creates a `character` variable named `char` if it does not exist
> deployrInput('{ "name": "char", "render": "character", "default": "Hello" } ')
> char
[1] "Hello"
```

Access big data files in a portable way across environments:

```R
## Referencing a CSV data file in your external directory
data <- read.csv(file = deployrExternal("data.csv")) 

## Referencing an XDF data file in your external directory
df <- RxXdfData(deployrExternal("data.xdf"))
```

## More Information

**Issues:**

Post an issue at https://github.com/deployr/deployrUtils/issues

**Website:**

Learn more at http://deployr.revolutionanalytics.com/documents/dev/scientist-portable-code/

**Made by:**

Revolution Analytics, wholly owned by Microsoft