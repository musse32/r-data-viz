---
title: "plotlycharts-markdown"
author: "musse32"
date: "1/27/2020"
output: html_document
---
# Interactive Data Viz

Start by loading the plotly library


```r
# Import plotly
library(plotly)
data(diamonds, package= "ggplot2")

str(diamonds)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	53940 obs. of  10 variables:
##  $ carat  : num  0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
##  $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
##  $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
##  $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
##  $ depth  : num  61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
##  $ table  : num  55 61 65 58 58 57 57 55 61 61 ...
##  $ price  : int  326 326 327 334 335 336 336 337 337 338 ...
##  $ x      : num  3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
##  $ y      : num  3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
##  $ z      : num  2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
```

```r
head(diamonds)
```

```
## # A tibble: 6 x 10
##   carat cut       color clarity depth table price     x     y     z
##   <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
## 1 0.23  Ideal     E     SI2      61.5    55   326  3.95  3.98  2.43
## 2 0.21  Premium   E     SI1      59.8    61   326  3.89  3.84  2.31
## 3 0.23  Good      E     VS1      56.9    65   327  4.05  4.07  2.31
## 4 0.290 Premium   I     VS2      62.4    58   334  4.2   4.23  2.63
## 5 0.31  Good      J     SI2      63.3    58   335  4.34  4.35  2.75
## 6 0.24  Very Good J     VVS2     62.8    57   336  3.94  3.96  2.48
```

```r
# Visualizing categorical data

cut_freq <- plot_ly(diamonds, x = ~cut)
#cut_freq

clarity_freq_bycut <- plot_ly(diamonds, x=~cut, color=~clarity)
clarity_freq_bycut
```

```
## No trace type specified:
##   Based on info supplied, a 'histogram' trace seems appropriate.
##   Read more about this trace type -> https://plot.ly/r/reference/#histogram
```

```
## Error in loadNamespace(name): there is no package called 'webshot'
```

```r
# Gapminder dataviz
library(gapminder)

gapminder
```

```
## # A tibble: 1,704 x 7
##    country     continent  year lifeExp      pop gdpPercap pop_m
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl> <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.  8.43
##  2 Afghanistan Asia       1957    30.3  9240934      821.  9.24
##  3 Afghanistan Asia       1962    32.0 10267083      853. 10.3 
##  4 Afghanistan Asia       1967    34.0 11537966      836. 11.5 
##  5 Afghanistan Asia       1972    36.1 13079460      740. 13.1 
##  6 Afghanistan Asia       1977    38.4 14880372      786. 14.9 
##  7 Afghanistan Asia       1982    39.9 12881816      978. 12.9 
##  8 Afghanistan Asia       1987    40.8 13867957      852. 13.9 
##  9 Afghanistan Asia       1992    41.7 16317921      649. 16.3 
## 10 Afghanistan Asia       1997    41.8 22227415      635. 22.2 
## # ... with 1,694 more rows
```

```r
## Each row represents uniq country and year, with variables of lifeExp, pop, and GDPpercap
library(dplyr)
#head(gapminder)
#str(gapminder)

gapminder <- gapminder


# Convert pop to millions

# Create total gdp field

gapminder2 = gapminder %>%
              mutate(tot_gdp = pop*gdpPercap)
gapminder2 = gapminder %>%
            mutate(pop_m = pop/1000000)


# Data Visualization
library(ggplot2)
#Scatter plot of two variables, label with country using color
gapminder2007 <- gapminder2 %>%
                  filter(year == 2007)
gapminder2007
```

```
## # A tibble: 142 x 7
##    country     continent  year lifeExp       pop gdpPercap   pop_m
##    <fct>       <fct>     <int>   <dbl>     <int>     <dbl>   <dbl>
##  1 Afghanistan Asia       2007    43.8  31889923      975.  31.9  
##  2 Albania     Europe     2007    76.4   3600523     5937.   3.60 
##  3 Algeria     Africa     2007    72.3  33333216     6223.  33.3  
##  4 Angola      Africa     2007    42.7  12420476     4797.  12.4  
##  5 Argentina   Americas   2007    75.3  40301927    12779.  40.3  
##  6 Australia   Oceania    2007    81.2  20434176    34435.  20.4  
##  7 Austria     Europe     2007    79.8   8199783    36126.   8.20 
##  8 Bahrain     Asia       2007    75.6    708573    29796.   0.709
##  9 Bangladesh  Asia       2007    64.1 150448339     1391. 150.   
## 10 Belgium     Europe     2007    79.4  10392226    33693.  10.4  
## # ... with 132 more rows
```

```r
pop_bygdp <- ggplot(
  gapminder2007 %>%
    filter((pop_m > 50) & (pop_m < 1000)),
  aes(x = pop_m, y=gdpPercap, color=country)) +
    geom_point()

# Make the plot interactive by wrapping it with plotly
plotly_popgdp <- ggplotly(pop_bygdp)

plotly_popgdp
```

```
## Error in loadNamespace(name): there is no package called 'webshot'
```
