
##Download the dataset and set the classes in the dataframe
library(dplyr)
house<- read.csv("~/Downloads/household_power_consumption.txt, sep=";"")
house<- house %>% mutate(new_date=dmy(house$Date))
use<- housedate %>% filter(new_date=="2007-02-01" | new_date=="2007-02-02")
use$Global_active_power<- as.numeric(use$Global_active_power)
use<- use %>% mutate(Day = ifelse(new_date=="2007-02-01", "Thursday", ifelse(new_date=="2007-02-02", "Friday", "Saturday")))

use<- use %>% mutate( time=strptime(Time, "%T"))
use<- paste(use$Date, use$Time)
use$datetime<- dmy_hms(use$datetime)
##Create the second plot
g2<- plot(use$datetime, use$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png")
dev.off()
