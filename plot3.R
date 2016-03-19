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

## create line graph of Global Active Power by day
plot3 <- plot(hh_data$date_time, hh_data$Sub_metering_3, main="", type="l", 
              ylab="Energy sub metering", xlab="", col="blue", ylim=c(0,30))
lines(hh_data$date_time, hh_data$Sub_metering_2, type="l", col="red")
lines(hh_data$date_time, hh_data$Sub_metering_1, type="l", col="black")

## add legend 
legend('topright', col=c("black","red","blue"), legend=c("sub_metering_1","sub_metering_2",
              "sub_metering_3"), lwd=1, lty=1, bty="n", inset=.1, cex=0.75)
dev.copy(png, file="plot3.png")
dev.off()