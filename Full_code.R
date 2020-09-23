##Download these packages for the code below
library(dplyr)
library(tidyr)
library(lubridate)

##Download the dataset and filter to create the dataset we will use with the specific dates. Two columns are added which will be helpful for graphing
house<- read.csv("~/Downloads/household_power_consumption.txt", sep=";")
house<- house %>% mutate(new_date=dmy(house$Date))
use<- housedate %>% filter(new_date=="2007-02-01" | new_date=="2007-02-02")
house2881<-house[69517:69527, ]
use<-rbind(use,house2881)
use<- use %>% mutate(Day = ifelse(new_date=="2007-02-01", "Thursday", ifelse(new_date=="2007-02-02", "Friday", "Saturday")))

##Change the class type of certain columns into date/time class
use$Global_active_power<- as.numeric(use$Global_active_power)
use<- use %>% mutate( time=strptime(Time, "%T"))
use$datetime<- paste(use$Date, use$Time)
use$datetime<- dmy_hms(use$datetime)

##create the histogram with red fillings, a new title and a new x-axis label
g1<- hist(use$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()

##Create the second plot, specifying a line graph and edit the labels on the x and y axis
g2<- plot(use$datetime, use$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png")
dev.off()

##Creating the 3rd graph, change some columns to numeric class. Create a plot that independently will graph 3 different columns, in different colors 
use$Sub_metering_1<- as.numeric(use$Sub_metering_1)
use$Sub_metering_2<- as.numeric(use$Sub_metering_2)
use$Sub_metering_3<- as.numeric(use$Sub_metering_3)
g3<- plot(use$datetime, use$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(y=use$Sub_metering_1, x=use$datetime, col="black", type="l")
points(y=use$Sub_metering_2, x=use$datetime, col="red", type="l")
points(y=use$Sub_metering_3, x=use$datetime, col="blue", type="l")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lty=1 )

dev.copy(png,file="plot3.png")
dev.off()

##Creating the 4th graph
##Change the type of the variables to numerical class
use$Voltage<- as.numeric(use$Voltage)
use$Global_reactive_power<- as.numeric(use$Global_reactive_power)


##Create a grid of plots, and then plot each graph in its designated position
par(mfcol=c(2,2))
g2<- plot(use$datetime, use$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
g3<- plot(use$datetime, use$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(y=use$Sub_metering_1, x=use$datetime, col="black", type="l", cex=1)
points(y=use$Sub_metering_2, x=use$datetime, col="red", type="l", cex=1)
points(y=use$Sub_metering_3, x=use$datetime, col="blue", type="l", cex=1)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lty=1, cex=0.25)
g4<- plot(use$datetime, use$Voltage, type="l", xlab="datetime", ylab="Voltage")
g5<- plot(use$datetime, use$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png")
dev.off()
