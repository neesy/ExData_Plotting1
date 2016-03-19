## read plot data and create a png file
## load library for lubridate for date calculations
library(lubridate)

## read household power consumption data - download from 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## unzip file to working directory for code to work properly
hh_data <- subset(read.table("household_power_consumption.txt", sep=";", 
          na.strings="?", header=TRUE), (Date=="1/2/2007" | Date == "2/2/2007"))

## create date_time field from Date and Time using lubridate and add to hh_data
date_time <- dmy(hh_data$Date) + hms(hh_data$Time)
hh_data <- cbind(hh_data,date_time)

## create histogram of Global Active Power
par(mfrow=c(1,1))
plot1 <- hist(hh_data$Global_active_power, col="red", 
              main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()