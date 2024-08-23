#Load the data and Packages

website_traffic <- read.csv("website_data.csv")

library(tidyverse)
library(ggplot2)
library(skimr)


# Data Exploration
skim_without_charts(website_traffic)
head(website_traffic)


#Making the graphs
  #Graphs of page views
  ggplot(data = website_traffic) +
    geom_histogram(binwidth = 1, mapping = aes(x=Page.Views),fill = "#79AC78", color = "#618264") +
    labs(title = "Frequency of the page views",
         x = "Page Views") +
    theme(panel.background = element_rect(fill="#B0D9B1"),
            plot.background = element_rect(fill="#D0E7D2"))
  
  #Graphs of Session Duration
  ggplot(data = website_traffic) +
    geom_histogram(binwidth= 1, mapping = aes(x=Session.Duration),fill = "#79AC78", color = "#618264") +
    labs(title = "Frequency of Session Duration",
         x = "Session_Duration in Minutes") +
    theme(panel.background = element_rect(fill="#B0D9B1"),
          plot.background = element_rect(fill="#D0E7D2"))
  
  #Graphs of Traffic Source
  ggplot(data = website_traffic) +
    geom_bar( mapping = aes(x=Traffic.Source),fill = "#79AC78", color = "#618264") +
    labs(title = "Frequency of Traffic Source",
         x = "Traffic Source") +
    theme(panel.background = element_rect(fill="#B0D9B1"),
          plot.background = element_rect(fill="#D0E7D2"))
  
  #Graphs of Bounce Rate
  ggplot(data = website_traffic) +
    geom_histogram(binwidth= 0.05, mapping = aes(x=Bounce.Rate),fill = "#79AC78", color = "#618264") +
    labs(title = "Frequency of Bounce Rate",
         x = "Bounce Rate") +
    theme(panel.background = element_rect(fill="#B0D9B1"),
          plot.background = element_rect(fill="#D0E7D2"))
  
  #Graphs of Time on Page
  ggplot(data = website_traffic) +
    geom_histogram(binwidth= 1, mapping = aes(x=Time.on.Page),fill = "#79AC78", color = "#618264") +
    labs(title = "Frequency of Time on Page",
         x = "Time On Page") +
    theme(panel.background = element_rect(fill="#B0D9B1"),
          plot.background = element_rect(fill="#D0E7D2"))

  #Graphs of Previous Visit
  ggplot(data = website_traffic) +
    geom_histogram(binwidth= 1, mapping = aes(x=Previous.Visits),fill = "#79AC78", color = "#618264") +
    labs(title = "Frequency of Previous Visit",
         x = "Previous Visit") +
    theme(panel.background = element_rect(fill="#B0D9B1"),
          plot.background = element_rect(fill="#D0E7D2"))
  
#relation between session duration and time on page
    ggplot(data = website_traffic) +
      geom_point(mapping = aes(x = Session.Duration, y = Time.on.Page),fill = "#79AC78", color = "#618264")+
    labs(title = "Relation between Session Duration and Time on Page",
         x = "Session Duration",
         Y = "Time on Page") +
      theme(panel.background = element_rect(fill="#B0D9B1"),
            plot.background = element_rect(fill="#D0E7D2"))
    
    
# Understanding Traffic Source
  Traffic_Source <- website_traffic %>% 
    group_by(Traffic.Source) %>% 
    summarize(total_page_views = sum(Page.Views),
              avg_session_duration = mean(Session.Duration),
              avg_bounce_rate = mean(Bounce.Rate),
              avg_time_on_page = mean(Time.on.Page),
              total_previous_visit = sum(Previous.Visits),
              avg_conversion_rate = mean(Conversion.Rate))
  
  view(Traffic_Source)
  
  #Traffic source distribution (Page View) Graph
    ggplot(data = Traffic_Source) +
      geom_bar(stat = "identity" ,mapping = aes(x = Traffic.Source, 
                             y = total_page_views),fill = "#79AC78", color = "#618264") +
      labs(title = "Traffic Source Distribution by Page View",
           x = "Traffic Source",
           y = "Page View") +
      theme(panel.background = element_rect(fill="#B0D9B1"),
            plot.background = element_rect(fill="#D0E7D2"))
    
    
    #Traffic source distribution (Total Previous Visit) Graph
    ggplot(data = Traffic_Source) +
      geom_bar(stat = "identity",mapping = aes(x = Traffic.Source, 
                                                y = total_previous_visit),fill = "#79AC78", color = "#618264") +
      labs(title = "Traffic Source Distribution by Total Previous Visit",
           x = "Traffic Source",
           y = "Total Previous Visit") +
      theme(panel.background = element_rect(fill="#B0D9B1"),
            plot.background = element_rect(fill="#D0E7D2"))

    
# Making Summary
summary <- website_traffic %>% 
      summarize(avg_page_views = mean(Page.Views),
                avg_session_duration = mean(Session.Duration),
                avg_bounce_rate = mean(Bounce.Rate),
                avg_time_on_page = mean(Time.on.Page),
                avg_previous_visits = mean(Previous.Visits),
                avg_conversion_rate = mean(Conversion.Rate)
      )
    view(summary)
    