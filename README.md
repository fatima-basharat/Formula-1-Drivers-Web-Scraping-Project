# Formula 1 Drivers Web Scraping Project

## Description
This project focuses on web scraping and analyzing data from a Wikipedia page listing Formula 1 drivers. The analysis includes examining various details such as the number of championships won, pole positions, and nationalities of the drivers. The project aims to extract, clean, and analyze the data to answer key questions about the drivers' performance and their associated statistics.

## Data Source
The data for this project was scraped from the Wikipedia page: [List of Formula 1 Drivers](https://en.wikipedia.org/wiki/List_of_Formula_One_drivers) [accessed on 08/26/24].

## Data Cleaning Process
The dataset underwent several cleaning steps to ensure accurate and meaningful analysis. The following steps were taken to clean the data:

- **Variable Selection**:
  - Selected relevant columns from the dataset, focusing on drivers' names, nationalities, championships, and pole positions.
  
- **Row Removal**:
  - Removed unnecessary rows, including the last row which contained summary data.

- **Formatting**:
  - Extracted the number of championships won from a formatted string in the `Drivers' Championships` column, retaining only the numerical value.

## Data Set Questions and Answers

1. **Which country has the largest number of wins?**
   - The analysis shows that certain countries have produced drivers with a high number of championship wins.

   ```r
   drivers_F1 %>%
     group_by(Nationality) %>%
     summarise(championship_country = sum(as.double(`Drivers' Championships`))) %>%
     arrange(desc(championship_country))

2. **Who has the most Championships?**
   - This query identifies the driver(s) with the highest number of championships.

   ```r
    drivers_F1 %>%
      group_by(`Driver name`) %>%
      summarise(championship_pilot = sum(as.double(`Drivers' Championships`))) %>%
      arrange(desc(championship_pilot))


3. **Is there a relation between the number of Championships won and the number of race pole positions?**
   - A scatter plot visualizes the relationship between pole positions and championships won.
     
 ```r
  drivers_F1 %>%
      filter(`Pole positions` > 1) %>%
      ggplot(aes(x = as.double(`Pole positions`), y = as.double(`Drivers' Championships`))) +
      geom_point(position = "jitter") +
      labs(y = "Championships won", x = "Pole positions") +
      theme_minimal()


## Conclusion
This project successfully scrapes and cleans data from a web page, leading to meaningful insights about Formula 1 drivers. The analysis answers key questions related to drivers' performance, providing a foundation for further exploration and study in the world of Formula 1.

 
