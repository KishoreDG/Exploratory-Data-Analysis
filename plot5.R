# plot5.R
# Exploratory Data Analysis Assignment
# OS: Windows 10 Pro
# Tools: Visual Studio 2015 (Community Edition) with R Tools

# Question: 
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Set Working Directory to the folder where R files and Data files are located

plot5 <- function() {

    # PNG File settings (based on previous assignment, I am using 480x480)
    png_file_name <- "plot5.png"
    png_file_width <- 480
    png_file_height <- 480

    # Read files
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")

    NEI$year <- factor(NEI$year, levels = c('1999', '2002', '2005', '2008'))
    Baltimore.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')

    Baltimore.df <- aggregate(Baltimore.onroad[, 'Emissions'], by = list(Baltimore.onroad$year), FUN = sum)
    colnames(Baltimore.df) <- c('year', 'Emissions')

    # Generate the graph in the same directory as the source code
    png(png_file_name, width = png_file_width, height = png_file_height)

    # using barplot and tapply 
    barplot(tapply(X = Baltimore.df$Emissions, INDEX = Baltimore.df$year, FUN = sum),
          main = 'Total Emissions from Motor Vehicle Sources - Baltimore,MD',
          xlab = 'Year', ylab = expression('PM'[2.5]))

    dev.off()

}