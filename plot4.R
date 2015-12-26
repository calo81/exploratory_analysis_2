library(ggplot2)
library(dplyr)

NEI <- readRDS("./data/summarySCC_PM25.rds")
NEI <- mutate(NEI, Emissions = as.numeric(as.character(Emissions)))
SCC <- readRDS("./data/Source_Classification_Code.rds")

DATA <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC")

filtered <- filter(DATA, grepl("Coal", SCC.Level.Three, ignore.case=TRUE))
filtered <- filter(filtered, grepl("Combustion", SCC.Level.One, ignore.case=TRUE))
byYear <- group_by(filtered, year)

summary <- summarise(byYear, total_emissions = sum(Emissions))

png("plot4.png")
plot(summary, xaxt="n", type="n")
axis(1, xaxp=c(1999, 2008, 9), las=2)
lines(summary)
dev.off()
