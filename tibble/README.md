# tibble

A tibble is a form of a data.frame which includes the useful parts of it and discards the parts that are not so important. So tibbles don’t change variables names or types like data.frames nor do they do partial matching but they bring problems to the forefront much sooner such as when a variable does not exist. So a code with tibbles is much cleaner and effective than before. 

Tibbles is also easier to use with larger datasets that contain more complex objects, in part before an enhanced `print()` method. 

You can create new tibbles from column vectors using the `tibble()` function and you can also create a tibble row-by-row using a `tribble()` function.

## Installation :

The best method is to install the tidyverse using:
```
install.packages("tidyverse"):
```

Or you can just install tibble using:
```
install.packages("tibble")
```

You can also install the development version from GitHub using:
```
devtools::install_github("tidyverse/tibble")
```

## Usage :
``` r
library(tibble)
data <- data.frame(a = 1:3, b = letters[1:3],
				c = Sys.Date() - 1:3)
print(data)
```

Output:
```
  a b          c
1 1 a 2021-11-24
2 2 b 2021-11-23
3 3 c 2021-11-22
```

