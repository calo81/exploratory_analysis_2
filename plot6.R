library(ggplot2)
library(dplyr)

NEI <- readRDS("./data/summarySCC_PM25.rds")
NEI <- mutate(NEI, Emissions = as.numeric(as.character(Emissions)))
SCC <- readRDS("./data/Source_Classification_Code.rds")

DATA <- merge(NEI, SCC, by.x = "SCC", by.y = "SCC")

filtered <- filter(DATA, fips == "24510" | fips == "06037")
filtered <- filter(filtered, grepl("vehicle", SCC.Level.Two, ignore.case=TRUE))
filtered <- filter(filtered, grepl("Mobile Sources", SCC.Level.One, ignore.case=TRUE))

byYearAndArea <- group_by(filtered, year, fips)

summary <- summarise(byYearAndArea, total_emissions = sum(Emissions))

cityDataFrame <- data.frame(keys = c("24510", "06037"), names = c("Baltimore", "Los Angeles"))

summary <- merge(summary, cityDataFrame, by.x = "fips", by.y = "keys")

png("./plot6.png")

plot <- qplot(year, total_emissions, data = summary, facets = names ~ ., geom = c("point", "smooth"))

print(plot)

dev.off()
