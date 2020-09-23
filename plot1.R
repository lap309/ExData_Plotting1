##Download the packages needed for the code
library(dplyr)
library(tidyr)
library(lubridate)

##Download the dataset and reorganize the data that will be used to make these graphs
house<- read.csv("~/Downloads/household_power_consumption.txt", sep=";")
house<- house %>% mutate(new_date=dmy(house$Date))
use<- housedate %>% filter(new_date=="2007-02-01" | new_date=="2007-02-02")
house2881<-house[69517:69527, ]
use<-rbind(use,house2881)
use<- use %>% mutate(Day = ifelse(new_date=="2007-02-01", "Thursday", ifelse(new_date=="2007-02-02", "Friday", "Saturday")))

##Change the class of certain columns so they can be graphed. Global Active power needs to be numeric and we need to make the date a date/time class
use$Global_active_power<- as.numeric(use$Global_active_power)
use<- use %>% mutate( time=strptime(Time, "%T"))
use$datetime<- paste(use$Date, use$Time)
use$datetime<- dmy_hms(use$datetime)

##create the histogram with red fillings, a new title and a new x-axis label
g1<- hist(use$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()
