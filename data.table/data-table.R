# Installation
install.packages("data.table")

# latest development version:
data.table::update.dev.pkg()

library(data.table)
DT = as.data.table(iris)

DT[Petal.Width > 1.0, mean(Petal.Length), by = Species]

