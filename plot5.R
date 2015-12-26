library(ggplot2)
library(dplyr)

NEI <- readRDS("./data/summarySCC_PM25.rds")
NEI <- mutate(NEI, Emissions = as.numeric(as.character(Emissions)))
SCC <- readRDS("./data/Source_Classification_Code.rds")

DATA <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC")

filtered <- filter(DATA, fips == "24510")
filtered <- filter(filtered, grepl("vehicle", SCC.Level.Two, ignore.case=TRUE))
filtered <- filter(filtered, grepl("Mobile Sources", SCC.Level.One, ignore.case=TRUE))
byYear <- group_by(filtered, year)

summary <- summarise(byYear, total_emissions = sum(Emissions))

png("plot5.png")
plot(summary, xaxt="n")
axis(1, xaxp=c(1999, 2008, 9), las=2)
dev.off()
