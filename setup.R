# R package list
.libPaths(".R/library")
install.packages(c("base64enc",
                   "devtools",
                   "digest",
                   "evaluate",
                   "glue",
                   "here",
                   "highr",
                   "htmltools",
                   "httpgd",
                   "jsonlite",
                   "knitr",
                   "languageserver",
                   "leaflet",
                   "lintr",
                   "lubridate",
                   "remotes",
                   "Rcpp",
                   "readr",
                   "magrittr",
                   "markdown",
                   "mime",
                   "R6",
                   "rlang",
                   "rmarkdown",
                   "stringi",
                   "stringr",
                   "testthat",
                   "tidyverse",
                   "tinytex",
                   "xfun"), lib = ".R/library")
devtools::install_github("ManuelHentschel/vscDebugger")