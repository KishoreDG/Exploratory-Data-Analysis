# plot2.R
# Exploratory Data Analysis Assignment
# OS: Windows 10 Pro
# Tools: Visual Studio 2015 (Community Edition) with R Tools

# Question: 
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

# Set Working Directory to the folder where R files and Data files are located

plot2 <- function() {
  
  # PNG File settings 
  png_file_name <- "plot2.png"
  png_file_width <- 480
  png_file_height <- 480
  
  # Read files
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  # Get data only for Baltimore City
  Baltimore <- subset(NEI, fips=='24510')

  # Generate the graph in the same directory as the source code
  png(png_file_name, width=png_file_width, height=png_file_height)
  
  # directly using tapply on the Baltimore data set 
  barplot(tapply(X=Baltimore$Emissions, INDEX=Baltimore$year, FUN=sum), 
          main='Total Emission in Baltimore City, MD', 
          xlab = 'Year',
          ylab=expression('PM'[2.5]))
  dev.off()
}
