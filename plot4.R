## Coursera - Exploratory Data Analysis
## Course Project 2
##
## Q4: Across the United States, how have emissions from coal 
## combustion-related sources changed from 1999-2008?

library(ggplot2)
library(data.table)

# Download data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if(!file.exists("FNEI_data.zip"))  {
  download.file(fileURL, destfile = "FNEI_data.zip", method = "curl")
  
  # Prepare data for use
  unzip(zipfile = "FNEI_data.zip", overwrite = TRUE)
}

# Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(NEI, SCC, by="SCC")

# Filter records to those which contains the word 'coal' in Short.Name
coal <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
coal <- data.table(NEISCC[coal, ])

# Generate the plot
dt <- aggregate(Emissions ~ year, coal, sum)

g <- ggplot(dt, aes(factor(year), Emissions/1000000))
g <- g + geom_bar(stat="identity", fill="steelblue") +
  xlab("Year") + ylab(expression("Total PM2.5 Emissions")) +
  ggtitle('Total Emissions from coal sources')

print(g)

# Save plot to file
dev.copy(png, "plot4.png", width=480, height=480, units="px")
dev.off()
