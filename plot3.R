######################################################################################################
# plot3.R
#
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
# a plot answer this question.
######################################################################################################
#
# Known Issues
# 2015-05-21: X Axis labels not showing years
#             Needs more color to show plotted points.
######################################################################################################


require(dplyr)
require(ggplot2)

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
NEI$fips <- as.factor(NEI$fips)
NEI$year <- as.factor(NEI$year)
NEI$type <- as.factor(NEI$type)

df <- NEI %>% filter(fips == '24510') %>% select(one_of(c("year","Emissions","type")))

#png("plot1.png", width=480, height=480)

g <- ggplot(df, aes(year, Emissions))
p <- g + geom_bar(stat="identity") + 
    facet_grid(. ~ type) + 
    xlab("Year") + 
    ylab("PM25 Emissions in Tons") +
    ggtitle("PM25 Emissions in Baltimore by Type and Year")


print (p)

#dev.off()