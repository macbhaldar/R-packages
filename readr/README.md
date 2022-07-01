# readr

## Overview

This library provides a simple and speedy method to read rectangular data such as that with file formats tsv, csv, delim, fwf, etc. readr can parse many different types of data using a function that parses the total file and another that focuses on the specific column. 

This column specification defines the method to convert the data in the column from a character vector to the data type that is most suited. 

This is done automatically by readr in most cases. readr can read different kinds of file formats using different functions,.

`readr` supports the following file formats with these `read_*()` functions:

- `read_csv()`: comma-separated values (CSV) files
- `read_tsv()`: tab-separated values (TSV) files
- `read_delim()`: delimited files (CSV and TSV are important special cases)
- `read_fwf()`: fixed-width files
- `read_table()`: whitespace-separated files
- `read_log()`: web log files

## Installation :

``` r
# The best method is to install the tidyverse using:
install.packages("tidyverse"). 
```

``` r
# Install just readr using:
install.packages("readr").
```

``` r
# You can also install the development version from GitHub using:
devtools::install_github("tidyverse/readr")
```

## Cheatsheet :

<a href="https://raw.githubusercontent.com/rstudio/cheatsheets/main/data-import.pdf"><img src="https://github.com/rstudio/cheatsheets/raw/main/pngs/thumbnails/data-import-cheatsheet-thumbs.png" height="252"/></a>

## Alternatives

There are two main alternatives to readr: base R and data.table’s
`fread()`. The most important differences are discussed below.

### Base R

Compared to the corresponding base functions, readr functions:

-   Use a consistent naming scheme for the parameters (e.g. `col_names`
    and `col_types` not `header` and `colClasses`).

-   Are generally much faster (up to 10x-100x) depending on the dataset.

-   Leave strings as is by default, and automatically parse common
    date/time formats.

-   Have a helpful progress bar if loading is going to take a while.

-   All functions work exactly the same way regardless of the current
    locale. To override the US-centric defaults, use `locale()`.

### data.table and `fread()`

`data.table` has a function
similar to `read_csv()` called `fread()`. Compared to `fread()`, readr
functions:

-   Are sometimes slower, particularly on numeric heavy data.

-   Can automatically guess some parameters, but basically encourage
    explicit specification of, e.g., the delimiter, skipped rows, and
    the header row.

-   Follow tidyverse-wide conventions, such as returning a tibble, a
    standard approach for column name repair, and a common mini-language
    for column selection.

## Usage :

R program to read csv file using readr package

``` r
# Import the readr library
library(readr)

# Use read_tsv() to read text file
myData = read_csv("Cars.csv", col_names = FALSE)
print(myData)
```
Output :

``` 
# A tibble: 1 x 1
  X1                                  
                                 
1 A computer science portal for geeks.
```
