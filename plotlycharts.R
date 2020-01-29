# Interactive Data Viz

# Import plotly
library(plotly)
data(diamonds, package= "ggplot2")

str(diamonds)
head(diamonds)

# Visualizing categorical data

cut_freq <- plot_ly(diamonds, x = ~cut)
cut_freq

clarity_freq_bycut <- plot_ly(diamonds, x=~cut, color=~clarity)
clarity_freq_bycut

# Gapminder dataviz
install.packages("gapminder")
library(gapminder)

gapminder
## Each row represents uniq country and year, with variables of lifeExp, pop, and GDPpercap
library(dplyr)
head(gapminder)
str(gapminder)

gapminder <- gapminder
population

gapminder %>%
  filter(year == 1957)
#142 rows for this year. 

gapminder %>%
  filter(country == "United States", year > 2000)

# Arrange by (order by)

gapminder %>%
  arrange(desc(pop)) %>%
    filter(country=="Japan")
gapminder %>%
    arrange(desc(pop), desc(gdpPercap)) %>%
    filter(year == 2007)

# Mutate to change a variable (or create new ones!)

# Convert pop to millions
gapminder %>%
  mutate(pop = pop/1000000)

# Create total gdp field
gapminder %>%
  mutate(tot_gdp = pop*gdpPercap)

gapminder

gapminder2 = gapminder %>%
              mutate(tot_gdp = pop*gdpPercap)
gapminder2

gapminder2 = gapminder %>%
            mutate(pop_m = pop/1000000)

gapminder2

# Combine the three functions to answer questions: Highest GDP for year 2007.

gapminder2 %>%
  arrange(desc(tot_gdp)) %>%
  filter(year==2007)
 
# Data Visualization
library(ggplot2)
#Scatter plot of two variables
gapminder2007 <- gapminder2 %>%
                  filter(year == 2007)
gapminder2007

pop_bygdp <- ggplot(
  gapminder2007 %>%
    filter((pop_m > 50) & (pop_m < 1000)),
  aes(x = pop_m, y=gdpPercap, color=country)) +
    geom_point()

# Make the plot interactive by wrapping it with plotly
plotly_popgdp <- ggplotly(pop_bygdp)

plotly_popgdp
