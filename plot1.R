library(dplyr)
NEI <- readRDS("./data/summarySCC_PM25.rds")
NEI <- mutate(NEI, Emissions = as.numeric(as.character(Emissions)))
SCC <- readRDS("./data/Source_Classification_Code.rds")

byYear <- group_by(NEI, year)

summary <- summarise(byYear, total_emissions = sum(Emissions))

png("plot1.png")
plot(summary, xaxt="n", type="n")
axis(1, xaxp=c(1999, 2008, 9), las=2)
lines(summary)

dev.off()