## Coursera - Exploratory Data Analysis
## Course Project 2
##
## Q5: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

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

baltimore <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]
dt <- aggregate(Emissions ~ year, baltimore, sum)

# Generate the plot
g <- ggplot(dt, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity", fill="steelblue") +
  xlab("Year") + ylab(expression("Total PM2.5 Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore City')

print(g)

# Save plot to file
dev.copy(png, "plot5.png", width=480, height=480, units="px")
dev.off()
