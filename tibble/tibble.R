# The best method is to install the tidyverse using:
install.packages("tidyverse"):
  
# Or you can just install tibble using:
install.packages("tibble")

# You can also install the development version from GitHub using:
devtools::install_github("tidyverse/tibble")



library(tibble)
data <- data.frame(a = 1:3, b = letters[1:3],
                   c = Sys.Date() - 1:3)
print(data)
