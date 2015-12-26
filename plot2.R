library(dplyr)
NEI <- readRDS("./data/summarySCC_PM25.rds")
NEI <- mutate(NEI, Emissions = as.numeric(as.character(Emissions)))
SCC <- readRDS("./data/Source_Classification_Code.rds")

filtered <- filter(NEI, fips == "24510")
byYear <- group_by(filtered, year)

summary <- summarise(byYear, total_emissions_in_baltimore = sum(Emissions))

png("plot2.png")
plot(summary, xaxt="n", type="n")
axis(1, xaxp=c(1999, 2008, 9), las=2)
lines(summary)

dev.off()

