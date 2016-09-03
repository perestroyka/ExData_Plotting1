library(data.table)
library(dplyr)
library(graphics)

## Reading file and processing the data. Skipping if object 'power' already exists
if (!exists("power"))
        {
        power <- fread("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?")
        power$DateTime <- as.POSIXct(paste(power$Time,power$Date),format="%T %d/%m/%Y")
        startDate <- as.POSIXct("2007-02-01",format = "%Y-%m-%d")
        endDate <- as.POSIXct("2007-02-03",format = "%Y-%m-%d")
        power <- power %>% select(-Date,-Time) %>% filter (DateTime >= startDate, DateTime < endDate )
        }

png(filename="plot4.png")

par(mfrow=c(2,2))
#1
plot(power$DateTime,power$Global_active_power,type="l",ylab="Global Active Power", xlab="")
#2
plot(power$DateTime,power$Voltage,type="l",ylab="Voltage", xlab="datetime")
#3
plot(power$DateTime,power$Sub_metering_1,type="l",ylab="Energy sub metering", xlab="")
lines(power$DateTime,power$Sub_metering_2,col="red")
lines(power$DateTime,power$Sub_metering_3,col="blue")
legend(x="topright",,names(power[5:7]),lty=1,col=c("red","black","blue"),bty="n")
#4
plot(power$DateTime,power$Global_reactive_power,type="l",ylab="Global_reactive_power", xlab="datetime")

dev.off()