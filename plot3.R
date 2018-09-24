## Coursera - Exploratory Data Analysis
## Course Project 2
##
## Q3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999-2008 for 
## Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 
## plotting system to make a plot answer this question

library(ggplot2)

# Download data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if(!file.exists("FNEI_data.zip"))  {
  download.file(fileURL, destfile = "FNEI_data.zip", method = "curl")
  
  # Prepare data for use
  unzip(zipfile = "FNEI_data.zip", overwrite = TRUE)
}

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")

# Generate the required metrics
baltimore  <- NEI[NEI$fips=="24510",]
dt <- aggregate(Emissions ~ year + type, baltimore, sum)

# Generate the plot
g <- ggplot(dt, aes(year, Emissions, color = type))
g <- g + geom_line() + xlab("Year") +   ylab(expression("Total PM2.5 Emissions")) +
  ggtitle('Total Emissions in Baltimore City')

print(g)

# Save plot to file
dev.copy(png, "plot3.png", width=480, height=480, units="px")
dev.off()
