install.packages("HistData")
library(HistData)
require(reshape)
install.packages("reshape")
library(reshape)
data("Nightingale")
install.packages("readxl")
library(readxl)
#Nightingale <- read_excel("C:/Users/Arzoo/Desktop/Data Visualization/A1.2/nightingale-data - Copy.xlsx") 
DatasetNight<- Nightingale[,c(1,8:10)]
stacked <- melt(DatasetNight, "Date")

names(stacked) <- c("Date", "Cause", "Deaths")
stacked$Cause <- sub("\\.rate", "", stacked$Cause)
stacked$Regime <- ordered( rep(c(rep('Before', 12), rep('After', 12)), 3), 
                                                    levels=c('Before', 'After'))
DatasetNight <- stacked
View(DatasetNight)

# divide the data based on before or after april 1855
DatasetNight1 <- subset(DatasetNight, Date < as.Date("1855-04-01"))
DatasetNight2 <- subset(DatasetNight, Date >= as.Date("1855-04-01"))
DatasetNight1 <- DatasetNight1[order(DatasetNight1$Deaths, decreasing=TRUE),]
DatasetNight2 <- DatasetNight2[order(DatasetNight2$Deaths, decreasing=TRUE),]

DatasetNight <- rbind(DatasetNight1, DatasetNight2)

require(ggplot2)


#plot the first coxcomb for data before April 1855
p1 <- ggplot(DatasetNight1, aes(x = factor(Date), y=Deaths, fill = Cause)) +theme_bw()+
  geom_bar(width = 1, position="identity", stat="identity", color="black") +
  scale_y_sqrt()
plotcheck1<-p1 + coord_polar(start=3*pi/2) +
  ggtitle("Causes of Mortality in the Army in the East") + 
  xlab("") + scale_fill_manual(values = c("#AED6F1", "#2E86C1", "#F1C40F"))

plot_build1 <- ggplot_build(plotcheck1)
plot_build1[["layout"]][["panel_params"]][[1]][["r.range"]]
plot_build1[["layout"]][["panel_params"]][[1]][["r.range"]][2] <- 32
simplePlot <- ggplot_gtable(plot_build1)
plot(simplePlot)

#plot the second transitioned coxcomb for the data after April 1855

p2 <- ggplot(DatasetNight2, aes(x = factor(Date), y=Deaths, fill = Cause)) +
  geom_bar(width = 1, position="identity", stat="identity", color="black") +
  scale_y_sqrt() 
plotCheck2<-p2 + coord_polar(start=3*pi/2, direction=-1) + theme_bw()+ 
      ggtitle("Causes of Mortality in the Army in the East") + 
      xlab("") + scale_fill_manual(values = c("#AED6F1", "#2E86C1", "#F1C40F"))
plot_build2 <- ggplot_build(plotCheck2)
plot_build2[["layout"]][["panel_params"]][[1]][["r.range"]]
plot_build2[["layout"]][["panel_params"]][[1]][["r.range"]][2] <- 13
transformedPlot <- ggplot_gtable(plot_build2)
plot(transformedPlot)

