# plot4.R
# Exploratory Data Analysis Assignment
# OS: Windows 10 Pro
# Tools: Visual Studio 2015 (Community Edition) with R Tools

# Question: 
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# using ggplot2

# Set Working Directory to the folder where R files and Data files are located

plot4 <- function() {
  
  # Across the United States, how have emissions 
  # from coal combustion-related sources changed from 1999-2008?
  
  # using ggplot2 instead of base plot features
  library(ggplot2)
  
  # Read files
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")

  # using grep to filter for "coal" on Sector column
  coalFilter <- unique(grep("coal", SCC$EI.Sector, ignore.case=TRUE, value=TRUE))  

  # quick test. check what is in the filter. here is the output
  #[1] "Fuel Comb - Electric Generation - Coal"
  #[2] "Fuel Comb - Industrial Boilers, ICEs - Coal"
  #[3] "Fuel Comb - Comm/Institutional - Coal"

  # filter SCC data   
  sccData <-subset(SCC, EI.Sector %in% coalFilter)   

  #filter NEI data for coal SCC 
  coalData <- subset(NEI, SCC %in% sccData$SCC)

  # Set year (for plotting purpose)
  coalData$year <- factor(coalData$year, levels = c('1999', '2002', '2005', '2008'))
  
  ggplot(data=coalData, aes(x=year, y=Emissions, fill = type)) + 
  geom_bar(stat="identity", position=position_dodge()) + 
  ggtitle("U.S. Coal Combustion-Related Emissions: 1999-2008")

  ggsave(file = "plot4.png")
  
  dev.off()
  
}
