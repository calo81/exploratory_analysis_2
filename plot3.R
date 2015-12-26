library(ggplot2)
library(dplyr)

NEI <- readRDS("./data/summarySCC_PM25.rds")
NEI <- mutate(NEI, Emissions = as.numeric(as.character(Emissions)))
SCC <- readRDS("./data/Source_Classification_Code.rds")

filtered <- filter(NEI, fips == "24510")
byYearAndType <- group_by(filtered, year, type)

summary <- summarise(byYearAndType, total_emissions_in_baltimore = sum(Emissions))

png("./plot3.png")

plot <- qplot(year, total_emissions_in_baltimore, data = summary, facets = type ~ ., geom = c("point", "smooth"))

print(plot)

dev.off()
