##Upload the dataset, change the class of some variables
library(dplyr)
house<- read.csv("~/Downloads/household_power_consumption.txt, sep=";"")
house<- house %>% mutate(new_date=dmy(house$Date))
use<- housedate %>% filter(new_date=="2007-02-01" | new_date=="2007-02-02")
use$Global_active_power<- as.numeric(use$Global_active_power)
use<- use %>% mutate(Day = ifelse(new_date=="2007-02-01", "Thursday", ifelse(new_date=="2007-02-02", "Friday", "Saturday")))

use<- paste(use$Date, use$Time)
use$datetime<- dmy_hms(use$datetime)

##Create the histogram and save the plot
g1<- hist(use$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()
