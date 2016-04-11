# plot3.R
# Exploratory Data Analysis Assignment
# OS: Windows 10 Pro
# Tools: Visual Studio 2015 (Community Edition) with R Tools

# Question: 
# Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999 –2008 for Baltimore City ? 
# Which have seen increases in emissions from 1999 –2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

# Set Working Directory to the folder where R files and Data files are located

plot3 <- function() {

  # please install ggplot2 using instal.package("ggplot2")
  # using ggplot2 instead of base plot features
  library(ggplot2)
  
  # Read files
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  # Get data only for Baltimore City
  Baltimore <- subset(NEI, fips == '24510')
  Baltimore$year <- factor(Baltimore$year, levels=c('1999', '2002', '2005', '2008'))

  # use ggplot
  ggplot(data = Baltimore, aes(x = year, y = Emissions, fill = type)) +
  geom_bar(stat="identity", position="dodge") +
  ggtitle("Baltimore, MD Emission by Type: 1999-2008")

  # I had to use ggsave explicitly to send the output plot to png file
  ggsave(file = "plot3.png")
  
  dev.off()
}
