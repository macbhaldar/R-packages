# The best method is to install the tidyverse using:
install.packages("tidyverse"). 

# Install just readr using:
install.packages("readr").

# You can also install the development version from GitHub using:
devtools::install_github("tidyverse/readr")

# R program to read csv file using readr package
# Import the readr library
library(readr)

# Use read_tsv() to read text file
myData = read_csv("Cars.csv", col_names = FALSE)
print(myData)

