######################################################################################################
# plot1.R
#
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
######################################################################################################
#
# Known Issues
# 2015-05-21: Needs more color to show plotted points.
######################################################################################################


require(dplyr)

if(!file.exists("./data")) {dir.create("./data")}

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

sourceFile <- "exdata-data-NEI_data.zip"
neiFile  <- "./data/summarySCC_PM25.rds"
sccFile <- "./data/Source_Classification_Code.rds"

# Download file and extract it.
if(!file.exists(sourceFile)) {
    if (Sys.info()['sysname'] == "Windows") {
        # needed for my Windows PC
        download.file(fileURL, destfile=sourceFile)
    } else {
        # needed for my Mac
        download.file(fileURL, destfile=sourceFile, method = "curl")
    }
    unzip(sourceFile, exdir="./data", junkpaths=TRUE)
}

if (exists("NEI") == FALSE) {
    NEI <- readRDS(neiFile)
}

df <- NEI %>% select(one_of(c("year","Emissions")))

#png("plot1.png", width=480, height=480)


dat <- by(df$"Emissions"/1000, INDICES=df$year, FUN=sum)
barplot(dat
     , main = "Total PM2.5 Emissions in United States"
     , xlab="Year"
     , ylab="Total PM2.5 Emissions in kilotons"
     )




#dev.off()