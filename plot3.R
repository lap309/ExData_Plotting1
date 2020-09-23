##Creating the data set and changing the classes of the variables to numeric
library(dplyr)
house<- read.csv("~/Downloads/household_power_consumption.txt, sep=";"")
house<- house %>% mutate(new_date=dmy(house$Date))
use<- housedate %>% filter(new_date=="2007-02-01" | new_date=="2007-02-02")
use$Global_active_power<- as.numeric(use$Global_active_power)
use<- use %>% mutate(Day = ifelse(new_date=="2007-02-01", "Thursday", ifelse(new_date=="2007-02-02", "Friday", "Saturday")))

use<- use %>% mutate( time=strptime(Time, "%T"))
use<- paste(use$Date, use$Time)
use$datetime<- dmy_hms(use$datetime)

use$Sub_metering_1<- as.numeric(use$Sub_metering_1)
use$Sub_metering_2<- as.numeric(use$Sub_metering_2)
use$Sub_metering_3<- as.numeric(use$Sub_metering_3)

##Creating the third graph
##this originally creates an empty plot, and then we create points for each sub meter (1,2,3) in different colors to understand the relationship
g3<- plot(use$datetime, use$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
points(y=use$Sub_metering_1, x=use$datetime, col="black", type="l")
points(y=use$Sub_metering_2, x=use$datetime, col="red", type="l")
points(y=use$Sub_metering_3, x=use$datetime, col="blue", type="l")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lty=1 )

dev.copy(png,file="plot3.png")
dev.off()
