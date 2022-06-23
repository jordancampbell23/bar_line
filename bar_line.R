library(tidyverse)
library(echarts4r)

df <- data.frame(
  year = c(2015:2020),
  grant = c(100, 110, 117, 130, 130, 140),
  percent = c(0.4, 0.35, 0.3, 0.28, 0.25, 0.26)
)

df |>
  mutate(year = as.character(year)) |>
  e_charts(year, barGap = "0%") |>
  e_bar(grant,
        name = "Grant + Longer Name",
        color = "#6699cc") |>
  echarts4r::e_y_axis(name = "Y-Axis 1",
                      nameLocation = "middle",
                      nameTextStyle = list(
                        fontSize = 14,
                        padding = c(0, 0, 45, 0)
                      ),
                      formatter = htmlwidgets::JS("function (value) {return '$' + echarts.format.addCommas(value) + ' M'}")) |>
  e_line(percent, 
         name = "Percent + Longer Name",
         color = "#ff6633",
         symbol = "none",
         smooth = T,
         lineStyle = list(width = 3),
         y_index = 1) |>
  echarts4r::e_y_axis(name = "Y-Axis 2",
                      index = 1,
                      nameLocation = "middle",
                      splitLine = list(show = F),
                      nameTextStyle = list(
                        fontSize = 14,
                        padding = c(40, 0, 0, 0)
                      ),
                      formatter = e_axis_formatter(style = "percent",
                                                   digits = 0)) |>
  echarts4r::e_x_axis(name = "X Axis Label",
                      nameLocation = "middle",
                      nameTextStyle = list(
                        fontSize = 14,
                        padding = c(10, 0, 0, 0)
                      ),
                      splitLine = list(show = F)) |>
  e_tooltip(trigger = "axis",
            axisPointer = list(lineStyle = list(width=2, type="solid")),
            formatter = htmlwidgets::JS("
                                        function(params){
                                        return(
                                        'Year: ' + params[0].value[0] + '<br/>' +
                                        params[0].marker + 'Grant: $' + echarts.format.addCommas(Math.round(params[0].value[1])) + ' M' + '<br/>' +
                                        params[1].marker + 'Percent: ' + (params[1].value[1] * 100).toFixed(1) + '%'
                                        )
                                        }
                                        ")) |>
  e_theme_custom("echarts_theme.json") |>
  e_legend(top = "9%",
           icons = c("rect", "circle"),
           selectedMode = F) |>
  e_title("Title", subtext="Subtitle") |>
  e_grid(top = "15%",
         left = "12%")
