## Coursera - Exploratory Data Analysis
## Course Project 2
##
## Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all 
## sources for each of the years 1999, 2002, 2005, and 2008.

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
dt <- aggregate(Emissions~year,data = NEI,FUN = sum)

# Generate the plot
barplot(dt$Emissions/1000000, names.arg = dt$year, col = "blue", 
        xlab = "Year", ylab = "Emissions (PM2.5)",
        main = "PM2.5 emissions per year")

# Save plot to file
dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()
