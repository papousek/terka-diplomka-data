library("scales")

sums.all <- read.csv("./input/sums_by_country_and_year.csv")
sums.all$country <- as.character(sums.all$country)
sums.all <- sums.all[with(sums.all, order(year)),]

zasedani.all <- data.frame()

for (year in unique(sums.all$year)) {
	# load data
	zasedani.countries <- as.character(read.csv(paste0("./input/zasedani-", year, ".csv"), head = F)[[1]])
	zasedani.sums <- sums.all[sums.all$year == year,]
	zasedani.sums <- zasedani.sums[zasedani.sums$country %in% zasedani.countries,]

	zasedani.all <- rbind(zasedani.all,data.frame(zasedani.sums$sum, rep(year, nrow(zasedani.sums))) )

	# export data
	write.csv(zasedani.sums, paste0("./output/zasedani.", year, ".sums.csv"))

	png(paste0("./output/zasedani.", year, ".sums.boxplot.png"));
	boxplot(zasedani.sums$sum, ylim = c(0, 40));
	dev.off()
}

colnames(zasedani.all) <- c("sum", "year")

png("./output/zasedani.all.sums.boxplot.png", width=1400, height=1000)
stripchart(sum ~ year, data = zasedani.all, ylim = c(0, 40), vertical = T, method = "stack", col = alpha("black", 0.2), pch = 16, cex=2)
boxplot(sum ~ year, data = zasedani.all, ylim = c(0, 40), add = T, col = alpha("white", 0))
dev.off()

