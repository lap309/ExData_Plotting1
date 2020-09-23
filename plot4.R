##Load the packages and the data into R
library(dplyr)
library(tidyr)
library(lubridate)

house<- read.csv("~/Downloads/household_power_consumption.txt", sep=";")
house<- house %>% mutate(new_date=dmy(house$Date))
use<- housedate %>% filter(new_date=="2007-02-01" | new_date=="2007-02-02")
house2881<-house[69517:69527, ]
use<-rbind(use,house2881)
use<- use %>% mutate(Day = ifelse(new_date=="2007-02-01", "Thursday", ifelse(new_date=="2007-02-02", "Friday", "Saturday")))


##Change the class of these columns. Most need to be changed to a numeric class
use$Global_active_power<- as.numeric(use$Global_active_power)
use<- use %>% mutate( time=strptime(Time, "%T"))
use$datetime<- paste(use$Date, use$Time)
use$datetime<- dmy_hms(use$datetime)
use$Sub_metering_1<- as.numeric(use$Sub_metering_1)
use$Sub_metering_2<- as.numeric(use$Sub_metering_2)
use$Sub_metering_3<- as.numeric(use$Sub_metering_3)
use$Voltage<- as.numeric(use$Voltage)
use$Global_reactive_power<- as.numeric(use$Global_reactive_power)

##Create a grid of plots
par(mfcol=c(2,2))

##Plots 1,2,3,4
g2<- plot(use$datetime, use$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
g3<- plot(use$datetime, use$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(y=use$Sub_metering_1, x=use$datetime, col="black", type="l", cex=1)
points(y=use$Sub_metering_2, x=use$datetime, col="red", type="l", cex=1)
points(y=use$Sub_metering_3, x=use$datetime, col="blue", type="l", cex=1)
g4<- plot(use$datetime, use$Voltage, type="l", xlab="datetime", ylab="Voltage")
g5<- plot(use$datetime, use$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png")
dev.off()
