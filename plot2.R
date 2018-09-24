## Coursera - Exploratory Data Analysis
## Course Project 2
##
## Q2: Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland from 1999 to 2008? Use the base plotting system to make a plot 
## answering this question.

library(dplyr)

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
dt <- aggregate(Emissions ~ year, baltimore, sum)

# Generate the plot
barplot(dt$Emissions, names.arg=dt$year, 
     xlab = "Year", ylab = "Emissions (PM2.5)",
     main = "PM2.5 emissions per year in Baltimore")

# Save plot to file
dev.copy(png, "plot2.png", width=480, height=480, units="px")
dev.off()
