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

png(filename="plot2.png")

plot(power$DateTime,power$Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab="")

dev.off()