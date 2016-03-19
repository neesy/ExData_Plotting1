## read plot data and create a png file
## load library for lubridate for date calculations
library(lubridate)

## read household power consumption data - download from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## unzip file to working directory for code to work properly
hh_data <- subset(read.table("household_power_consumption.txt", sep=";", 
                             na.strings="?", header=TRUE), (Date=="2/1/2007" | Date == "2/2/2007"))

## create date_time field from Date and Time using lubridate and add to hh_data
date_time <- mdy(hh_data$Date) + hms(hh_data$Time)
hh_data <- cbind(hh_data,date_time)

par(mfrow=c(2,2))
## create histogram of Global Active Power
plot(hh_data$date_time, hh_data$Global_active_power, main="", type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
plot(hh_data$date_time, hh_data$Voltage, main="", type="l", xlab="date_time",ylab="Voltage")
plot(hh_data$date_time, hh_data$Sub_metering_3, main="", type="l", 
              ylab="Energy sub metering", xlab="", col="blue", ylim=c(0,30))
lines(hh_data$date_time, hh_data$Sub_metering_2, type="l", col="red")
lines(hh_data$date_time, hh_data$Sub_metering_1, type="l", col="black")

## add legend 
legend('topright', col=c("black","red","blue"), legend=c("sub-metering1","sub-metering2",
                            "sub-metering3"), lwd=1, lty=1, cex=0.5, inset=0.1, bty="n")
plot(hh_data$date_time, hh_data$Global_reactive_power, type="l", xlab="date_time",ylab="Global_reactive_power")

dev.copy(png, file="plot4.png")
dev.off()