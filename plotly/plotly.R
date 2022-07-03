# Install from CRAN:
install.packages("plotly")

# Or install the latest development version (on GitHub) via {remotes}:
remotes::install_github("plotly/plotly")


# import plotly library
library(plotly)


# create plotly visualisation
p <- plot_ly(iris, x = ~Sepal.Width,
             y = ~Sepal.Length)


# adding markers
add_markers(p, color = ~Petal.Length,
            size = ~Petal.Length)
add_markers(p, color = ~Species)


# create plotly visualisation
p <- plot_ly(iris, x = ~Sepal.Width,
             y = ~Sepal.Length)
layout(p, data = NULL)

# create plotly visualisation
p <- plot_ly(iris, x = ~Sepal.Width,
             y = ~Sepal.Length)

# adding trace (lines) to plotly
# visualisation
add_trace(p, type = "scatter",
          mode = "markers+lines")

# adding Animation to plotly
plot_ly(mtcars, x = ~wt, y = ~mpg,
        frame = ~cyl) %>%
  animation_opts(transition = 0)


# Add data to a plotly visualization.
plot_ly() %>% add_data(economics) %>%
  add_trace(x = ~date, y = ~pce)


# create plotly visualisation
p <- plot_ly(iris, x = ~Sepal.Width,
             y = ~Sepal.Length)

# Creates a static image for plotly visualization
# importing plotly visualisation as image files
Png <- plotly_IMAGE(p,
                    out_file = "plotly-test-image.png")
Jpeg <- plotly_IMAGE(p, format = "jpeg",
                     out_file = "plotly-test-image.jpeg")

# importing plotly visualisation as vector graphics
Svg <- plotly_IMAGE(p, format = "svg",
                    out_file = "plotly-test-image.svg")

# importing plotly visualisation as pdf file
Pdf <- plotly_IMAGE(p, format = "pdf",
                    out_file = "plotly-test-image.pdf")



library(lubridate)
econ <- economics %>%
  mutate(yr = year(date), mnth = month(date))

# One trace (more performant, but less interactive)
econ %>%
  group_by(yr) %>%
  plot_ly(x = ~mnth, y = ~uempmed) %>%
  add_lines(text = ~yr)

# Multiple traces (less performant, but more interactive)
plot_ly(econ, x = ~mnth, y = ~uempmed) %>%
  add_lines(color = ~ordered(yr))

# The split argument guarantees one trace per group level (regardless
# of the variable type). This is useful if you want a consistent
# visual property over multiple traces
# plot_ly(econ, x = ~mnth, y = ~uempmed) %>%
#   add_lines(split = ~yr, color = I("black"))


# alpha blending
subplot(
  plot_ly(mpg, x = ~cty, y = ~hwy, name = "default"),
  plot_ly(mpg, x = ~cty, y = ~hwy) %>%
    add_markers(alpha = 0.2, name = "alpha")
)

# color
p <- plot_ly(mpg, x = ~cty, y = ~hwy, alpha = 0.5)
subplot(
  add_markers(p, color = ~cyl, showlegend = FALSE) %>%
    colorbar(title = "Viridis"),
  add_markers(p, color = ~factor(cyl))
)

col1 <- c("#132B43", "#56B1F7")
col2 <- viridisLite::inferno(10)
col3 <- colorRamp(c("red", "white", "blue"))
subplot(
  add_markers(p, color = ~cyl, colors = col1) %>%
    colorbar(title = "ggplot2 default"),
  add_markers(p, color = ~cyl, colors = col2) %>%
    colorbar(title = "Inferno"),
  add_markers(p, color = ~cyl, colors = col3) %>%
    colorbar(title = "colorRamp")
) %>% hide_legend()

col1 <- "Accent"
col2 <- colorRamp(c("red", "blue"))
col3 <- c(`4` = "red", `5` = "black", `6` = "blue", `8` = "green")
subplot(
  add_markers(p, color = ~factor(cyl), colors = col1),
  add_markers(p, color = ~factor(cyl), colors = col2),
  add_markers(p, color = ~factor(cyl), colors = col3)
) %>% hide_legend()
