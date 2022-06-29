# dplyr 

The `dplyr` package in R Programming Language is a structure of data manipulation that provides a uniform set of verbs, helping to resolve the most frequent data manipulation hurdles.

## Overview

dplyr is a grammar of data manipulation, providing a consistent set of
verbs that help you solve the most common data manipulation challenges:

-   `filter()` picks cases based on their values.
-   `arrange()` changes the ordering of the rows.
-   `select()` picks variables based on their names.
-   `mutate()` adds new variables that are functions of existing
    variables
-   `summarise()` reduces multiple values down to a single summary.


## Installation

``` r
# The easiest way to get dplyr is to install the whole tidyverse:
install.packages("tidyverse")

# Alternatively, install just dplyr:
install.packages("dplyr")
```

### Development version

``` r
# install.packages("devtools")
devtools::install_github("tidyverse/dplyr")
```

## Cheat Sheet

<a href="https://github.com/rstudio/cheatsheets/blob/main/data-transformation.pdf"><img src="https://raw.githubusercontent.com/rstudio/cheatsheets/main/pngs/thumbnails/data-transformation-cheatsheet-thumbs.png" width="630" height="252"/></a>

## Usage

`filter()` Function: For choosing cases and using their values as a base
```r
# Create a data frame with missing data
data <- data.frame(name=c("name1", "name2",
                        "name3", "name4"),
                 age=c(10, 12, 14, 16),
                 pt=c(76, NA, NA, 65),
                 school=c("yes", "yes", "no", "no"))
data

# Finding rows with NA value
data %>% filter(is.na(ht))

# Finding rows with no NA value
data %>% filter(! is.na(ht))
```

`arrange()` Function: For reordering of the cases
```r
# Create a data frame with missing data
data <- data.frame(name=c("name1", "name2",
                          "anme3", "name4"),
                   age=c(10, 12, 14, 16),
                   pt=c(76, NA, NA, 65),
                   school=c("yes", "yes", "no", "no"))
data

# Arranging name according to the age
data.name<- arrange(data, age)
print(data.name)
```

`select()` and `rename()`: For choosing variables and using their names as a base
```r
# Create a data frame with missing data
data <- data.frame(name=c("name1", "name2",
                          "anme3", "name4"),
                   age=c(10, 12, 14, 16),
                   pt=c(76, NA, NA, 65),
                   school=c("yes", "yes", "no", "no"))
data

# startswith() function to print only ht data
select(data, starts_with("pt"))

# -startswith() function to print
# everything except ht data
select(data, -starts_with("pt"))

# Printing column 1 to 2
select(data, 1: 2)

# Printing data of column
# heading containing 'a'
select(data, contains("a"))

# Printing data of column
# heading which matches 'na'
select(data, matches("na"))
```

`mutate()` and `transmute()`: Addition of new variables which are the functions of prevailing variables.
```r
# Create a data frame with missing data
data <- data.frame(name=c("name1", "name2",
                          "anme3", "name4"),
                   age=c(10, 12, 14, 16),
                   pt=c(76, NA, NA, 65),
                   school=c("yes", "yes", "no", "no"))
data

# Calculating a variable x3 which is sum of height
# and age printing with ht and age
mutate(data, x3 = pt + age)

# Calculating a variable x3 which is sum of height
# and age printing without ht and age
transmute(data, x3 = pt + age)
```

`summarise()`: Condensing various values to one value.

```r
# Create a data frame with missing data
data <- data.frame(name=c("name1", "name2",
                          "anme3", "name4"),
                   age=c(10, 12, 14, 16),
                   pt=c(76, NA, NA, 65),
                   school=c("yes", "yes", "no", "no"))
data

# Calculating mean of age
summarise(data, mean = mean(age))

# Calculating min of age
summarise(data, med = min(age))

# Calculating max of age
summarise(data, med = max(age))

# Calculating median of age
summarise(data, med = median(age))
```

`sample_n()` and `sample_frac()`: For taking random specimens.

```r
# Create a data frame with missing data
data <- data.frame(name=c("name1", "name2",
                          "anme3", "name4"),
                   age=c(10, 12, 14, 16),
                   pt=c(76, NA, NA, 65),
                   school=c("yes", "yes", "no", "no"))
data

# Printing three rows
sample_n(data, 3)

# Printing 50 % of the rows
sample_frac(data, 0.50)
```

## References
1. [R for Data Science](https://r4ds.had.co.nz/transform.html) - Hadley Wickham
