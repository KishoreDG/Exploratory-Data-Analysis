# plot1.R
# Exploratory Data Analysis Assignment
# OS: Windows 10 Pro
# Tools: Visual Studio 2015 (Community Edition) with R Tools

# Question: 
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# use base plot feature - barplot

# Set Working Directory to the folder where R files and Data files are located

plot1 <- function() {

  # PNG File settings (based on previous assignment, I am using 480x480)
  png_file_name <- "plot1.png"
  png_file_width <- 480
  png_file_height <- 480

  # Read files
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  # GROUP and SUM by Year on column 'Emissions'
  Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN = sum)

  # Emissions: Amount of PM2.5 emitted, in tons
  # We should convert tons to kilotons. 1 ton is 0.001 kilotons
  Emissions$PM <- round(Emissions[, 2] / 1000, 2)

  # Rename Columns in Emissions data.frame for more readability 
  names(Emissions)[1] <- paste("Year")
  names(Emissions)[2] <- paste("PM25")
  
  # Generate the graph in the same directory as the source code
  png(png_file_name, width=png_file_width, height=png_file_height)
  
  barplot(Emissions$PM,
          names.arg=Emissions$Year, 
          main=expression('Total Emission of PM'[2.5]),
          xlab = 'Year',
          ylab=expression(paste('PM', ''[2.5], ' in Kilotons')))

  dev.off()

}