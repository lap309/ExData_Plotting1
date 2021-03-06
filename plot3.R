##Load the packages and the date, organize the data to represent the dates we want to graph
library(dplyr)
library(tidyr)
library(lubridate)

house<- read.csv("~/Downloads/household_power_consumption.txt", sep=";")
house<- house %>% mutate(new_date=dmy(house$Date))
use<- housedate %>% filter(new_date=="2007-02-01" | new_date=="2007-02-02")
house2881<-house[69517:69527, ]
use<-rbind(use,house2881)
use<- use %>% mutate(Day = ifelse(new_date=="2007-02-01", "Thursday", ifelse(new_date=="2007-02-02", "Friday", "Saturday")))


##Change several columns to numeric class so they can be graphed. Also, create a datetime class of the date so we can see the trend over time
use$Global_active_power<- as.numeric(use$Global_active_power)
use<- use %>% mutate( time=strptime(Time, "%T"))
use$datetime<- paste(use$Date, use$Time)
use$datetime<- dmy_hms(use$datetime)
use$Sub_metering_1<- as.numeric(use$Sub_metering_1)
use$Sub_metering_2<- as.numeric(use$Sub_metering_2)
use$Sub_metering_3<- as.numeric(use$Sub_metering_3)


##Create the third plot. First create an empyy plot, then specify the points from the sub metering columns. Graph them with different colors so you can differentiate. Also, add a legend so we cna see which lines are which solumn
g3<- plot(use$datetime, use$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(y=use$Sub_metering_1, x=use$datetime, col="black", type="l")
points(y=use$Sub_metering_2, x=use$datetime, col="red", type="l")
points(y=use$Sub_metering_3, x=use$datetime, col="blue", type="l")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lty=1 )

dev.copy(png,file="plot3.png")
dev.off()

