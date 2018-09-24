## Coursera - Exploratory Data Analysis
## Course Project 2
##
## Q6: Compare emissions from motor vehicle sources in Baltimore City with emissions from 
## motor vehicle sources in Los Angeles County, California. Which city has seen greater 
## changes over time in motor vehicle emissions?

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

baltimore <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]
dt <- aggregate(Emissions ~ year + fips, baltimore, sum)
dt$fips[dt$fips=="24510"] <- "Baltimore"
dt$fips[dt$fips=="06037"] <- "Los Angeles"

# Generate the plot
g <- ggplot(dt, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity", fill="steelblue")  +
  xlab("Year") +
  ylab(expression("Total PM2.5 Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore Cit vs Los Angeles')

print(g)

# Save plot to file
dev.copy(png, "plot6.png", width=480, height=480, units="px")
dev.off()