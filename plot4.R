######################################################################################################
# plot4.R
#
# Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999–2008?
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
if (exists("SCC") == FALSE) {
    SCC <- readRDS(sccFile)
}

# Convert Character data to factor
SCC$SCC <- as.character(SCC$SCC)

coal <- grepl ("Coal", SCC$Short.Name)
combust <- grepl("Comb", SCC$Short.Name)
coal_comb <- SCC[which(with(SCC, coal & combust)),"SCC"]

em <- data.frame(NEI$year, NEI$Emissions, NEI$SCC)
names(em) <- c("year","Emissions","SCC")
em$SCC <- as.character(em$SCC)

#df <- inner_join(em, coal_comb, by = "SCC")



#png("plot1.png", width=480, height=480)


#dat <- by(df$"Emissions"/1000, INDICES=df$year, FUN=sum)
#barplot(dat
#      , main = "Total PM2.5 Emissions in United States"
#      , xlab="Year"
#      , ylab="Total PM2.5 Emissions in kilotons"
#     )
#



#dev.off()