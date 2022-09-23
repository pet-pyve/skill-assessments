
#align figures + add captions + label code chunks

library(tidyverse)
library(plotly)

#reading in the gapminder CSV
gapminder <- read_csv("BRN\\skill-assessments\\R for Data Science\\gapminder_clean.csv")
gapminder <- gapminder %>%
  rename(co2 = "CO2 emissions (metric tons per capita)") %>%
  rename(energy = "Energy use (kg of oil equivalent per capita)") %>%
  rename(import = "Imports of goods and services (% of GDP)") %>%
  rename(pop_density = "Population density (people per sq. km of land area)") %>%
  rename(country = "Country Name") %>%
  rename(gapminder, life_exp = "Life expectancy at birth, total (years)")

#filtering for outliers
gapminder <- filter(gapminder, co2 < 20)

#filtered scatter plot with only rows where year is 1962
gapminder_1962 <- filter(gapminder, Year == 1962)


gapminder_1962 %>%
  #filtering for outliers
  ggplot(aes(x = co2, y = gdpPercap)) +
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE)

#scale is off because of an outlier - remove it!
# only removed one outlier - 151 NA, to 152 based on console readouts

#The correlation of 'CO2' and gdpPercap - ignoring NA
cor.test(gapminder_1962$co2, gapminder_1962$gdpPercap, use = "complete.obs")
  
#super small p value - significant

#In what year is the correlation between 'CO2' and gdpPercap the strongest?" 

gapminder %>%
  group_by(Year)  %>%
  summarise(cor = cor(co2, gdpPercap, use = "complete.obs"))  %>%
  ggplot(aes(x = Year, y = cor)) + 
  geom_line() +
  geom_text(aes(label = Year)) 

#create interactive plot 
gapminder_1967 <- filter(gapminder, Year == 1967)

gapminder_1967 %>%
  ggplot(aes(x = co2, y = gdpPercap, color = continent, size = pop)) +
  geom_point()
  ggplotly()
  
#What is the relationship between continent and 'Energy use (kg of oil equivalent per capita)'
gapminder %>%
  ggplot(mapping = aes(x = continent, y = energy)) +
  geom_boxplot()

#anova
continent_energy_aov <- aov(energy ~ continent, data = gapminder)
summary(continent_energy_aov)

#Is there a significant difference between Europe and Asia with respect to 'Imports of goods and services (% of GDP)' in the years after 1990?
gapminder_filtered <- filter(gapminder, (continent == 'Europe' | continent == 'Asia') & Year > 1990)
gapminder_filtered %>%
  ggplot(mapping= aes(x = continent, y = import)) +
  geom_boxplot()
 
#t test
t.test(import ~ continent, data = gapminder_filtered) 

#no statistical difference

#What is the country (or countries) that has the highest 'Population density (people per sq. km of land area)' across all years? 
gapminder %>%
  group_by(country)  %>%
  summarise(pop_mean = mean(pop_density)) %>%
  filter(pop_mean > 1000) %>%
  ggplot(aes(x = country, y = pop_mean)) +
  geom_bar(stat = "identity")
  
#What country (or countries) has shown the greatest increase in 'Life expectancy at birth, total (years)' since 1962?
gapminder %>%
  arrange(Year) %>%
  group_by(country)  %>%
  summarise(diff = last(life_exp) - first(life_exp)) %>%
  filter(diff > 27) %>%
  ggplot(aes(x = country, y = diff)) + 
  geom_bar(stat = "identity")
  
#Tunisia seems to have the highest diff of 30.9 - lets graph its whole trajectory

gapminder %>%
  filter(country == "Tunisia") %>%
  ggplot(aes(x = Year, y = life_exp)) + 
  geom_line()
  ggplotly()

  