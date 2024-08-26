# Installing the packages
install.packages("dplyr")
install.packages("rvest")
install.packages("tidyverse")

# Loading the packages
library(rvest)
library(dplyr)
library(tidyverse)

# HTTP GET request
link <- "https://en.wikipedia.org/wiki/List_of_Formula_One_drivers"

page <- read_html(link)

drivers_F1 <- html_element(page, "table.sortable") %>%
  html_table()

head(drivers_F1) # first 6 rows
tail(drivers_F1) # last 6 rows
str(drivers_F1) # structure of the data set

# Now we want to select the variables of interest and eliminate the last row
drivers_F1 <- drivers_F1[c(1:4, 7:9)] # select variables
drivers_F1 <- drivers_F1[-nrow(drivers_F1), ] # remove last row

# Data Cleaning

# Drivers' Championships column has formatting issue
# we want to extract only the number of victories without the years
drivers_F1$`Drivers' Championships` <- substr(drivers_F1$`Drivers' Championships`,
                                              start = 1, stop = 1
)

# Save the dataset
write.csv(drivers_F1, "F1_drivers.csv", row.names = FALSE)


# Data set Questions

# Which country has the largest number of wins?
drivers_F1 %>%
  group_by(Nationality) %>%
  summarise(championship_country = sum(as.double(`Drivers' Championships`))) %>%
  arrange(desc(championship_country))

# Who has the most Championships?
drivers_F1 %>%
  group_by(`Driver name`) %>%
  summarise(championship_pilot = sum(as.double(`Drivers' Championships`))) %>%
  arrange(desc(championship_pilot))

# Is there a relation between the number of Championships won and the number of race pole positions?
drivers_F1 %>%
  filter(`Pole positions` > 1) %>%
  ggplot(aes(x = as.double(`Pole positions`), y = as.double(`Drivers' Championships`))) +
  geom_point(position = "jitter") +
  labs(y = "Championships won", x = "Pole positions") +
  theme_minimal()
  