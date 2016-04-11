# plot6.R
# Exploratory Data Analysis Assignment
# OS: Windows 10 Pro
# Tools: Visual Studio 2015 (Community Edition) with R Tools

# Question: 

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037"). Baltimore fips = 24510
# Which city has seen greater changes over time in motor vehicle emissions?

# Set Working Directory to the folder where R files and Data files are located

plot6 <- function() {
  
  # using ggplot. please install ggplot2
  library(ggplot2)
  
  # Read files
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

  # Baltimore City, Maryland and for Motor Vehicles
  Baltimore.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')

  # Los Angeles County, California and for Motor Vehicles
  LosAngeles.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')
  
  # Aggregate
  Baltimore.DF <- aggregate(Baltimore.onroad[, 'Emissions'], by = list(Baltimore.onroad$year), FUN = sum)
  colnames(Baltimore.DF) <- c('year', 'Emissions')
  Baltimore.DF$City <- paste(rep('Baltimore', 4))
  
  LosAngeles.DF <- aggregate(LosAngeles.onroad[, 'Emissions'], by = list(LosAngeles.onroad$year), FUN = sum)
  colnames(LosAngeles.DF) <- c('year', 'Emissions')
  LosAngeles.DF$City <- paste(rep('LosAngeles', 4))
  
  combinedDF <- as.data.frame(rbind(Baltimore.DF, LosAngeles.DF))

  ggplot(data = combinedDF, aes(x = year, y = Emissions, fill = year)) + facet_grid(. ~ City) +
  geom_bar(stat="identity", position=position_dodge()) +
  ggtitle(expression(atop("Two City Motor-Vehicle Emission Comparison", 
                            atop(italic("Baltimore, MD and Los Angeles, CA: 1999-2008")))))

  ggsave("plot6.png")

}

