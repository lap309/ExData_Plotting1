##Set up the packages, data, and columns to be graphed

library(dplyr)
library(tidyr)
library(lubridate)

house<- read.csv("~/Downloads/household_power_consumption.txt", sep=";")
house<- house %>% mutate(new_date=dmy(house$Date))
use<- housedate %>% filter(new_date=="2007-02-01" | new_date=="2007-02-02")
house2881<-house[69517:69527, ]
use<-rbind(use,house2881)
use<- use %>% mutate(Day = ifelse(new_date=="2007-02-01", "Thursday", ifelse(new_date=="2007-02-02", "Friday", "Saturday")))

use$Global_active_power<- as.numeric(use$Global_active_power)
use<- use %>% mutate( time=strptime(Time, "%T"))
use$datetime<- paste(use$Date, use$Time)
use$datetime<- dmy_hms(use$datetime)


##Plot the second graph, specify a line graph, and edit the x and y labels in the graph
g2<- plot(use$datetime, use$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png")
dev.off()
