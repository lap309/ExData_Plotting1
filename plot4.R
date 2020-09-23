##Download the data
library(dplyr)
house<- read.csv("~/Downloads/household_power_consumption.txt, sep=";"")
house<- house %>% mutate(new_date=dmy(house$Date))
use<- housedate %>% filter(new_date=="2007-02-01" | new_date=="2007-02-02")
use$Global_active_power<- as.numeric(use$Global_active_power)
use<- use %>% mutate(Day = ifelse(new_date=="2007-02-01", "Thursday", ifelse(new_date=="2007-02-02", "Friday", "Saturday")))

use<- use %>% mutate( time=strptime(Time, "%T"))
use<- paste(use$Date, use$Time)
use$datetime<- dmy_hms(use$datetime)


##Create the layout for multiple plots
par(mfcol=c(2,2))

##Plot the 4 graphs in their respective places
g2<- plot(use$datetime, use$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
g3<- plot(use$datetime, use$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(y=use$Sub_metering_1, x=use$datetime, col="black", type="l", cex=1)
points(y=use$Sub_metering_2, x=use$datetime, col="red", type="l", cex=1)
points(y=use$Sub_metering_3, x=use$datetime, col="blue", type="l", cex=1)
g4<- plot(use$datetime, use$Voltage, type="l", xlab="datetime", ylab="Voltage")
g5<- plot(use$datetime, use$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png")
dev.off()
