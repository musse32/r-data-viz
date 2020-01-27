#' Interactive Data Viz

#' Import plotly
library(plotly)
data(diamonds, package= "ggplot2")

str(diamonds)
head(diamonds)

#' Visualizing categorical data

cut_freq <- plot_ly(diamonds, x = ~cut)
cut_freq

clarity_freq_bycut <- plot_ly(diamonds, x=~cut, color=~clarity)
clarity_freq_bycut
