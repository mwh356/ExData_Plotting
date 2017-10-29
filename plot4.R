library(tidyr)
library(tidyverse)
library(lubridate)

# Download and load the datasets

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileurl, destfile = "powerconsumption.zip")

unzip("powerconsumption.zip")

data <- read.csv2("household_power_consumption.txt")

# Subsetting the data

data1 <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]

# Create a DateTime Variable and Convert other columns from factor to numeric.

data2 <- data1 %>% 
  mutate(
    DateTime = dmy_hms(paste(Date, Time)),
    Global_active_power = as.numeric(as.character(Global_active_power)),
    Global_reactive_power = as.numeric(as.character(Global_reactive_power)),
    Voltage = as.numeric(as.character(Voltage)),
    Sub_metering_1 = as.numeric(as.character(Sub_metering_1)),
    Sub_metering_2 = as.numeric(as.character(Sub_metering_2)),
    Sub_metering_3 = as.numeric(as.character(Sub_metering_3))
  )

# Creating Plot 4

# Parameter for multiplot
par(mfrow = c(2,2), mar = c(4,4,2,1),oma = c(0, 0, 2, 0))

# First Plot - Global Active Power
with(data2, plot(type = "l", DateTime, Global_active_power, ylab = "Global Active Power", xlab = ""))

# Second Plot - Voltage
with(data2, plot(type = "l", DateTime, Voltage, xlab = "datetime", ylab = "Voltage"))

# Third Plot - Energy sub metering

with(data2, plot(type = "n", DateTime, Sub_metering_1, ylab = "Energy sub metering", xlab = ""))
with(data2, lines(DateTime, Sub_metering_1, col = "black"))
with(data2, lines(DateTime, Sub_metering_2, col = "red"))
with(data2, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2 , bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Fourth Plot - Global Reactive Power

with(data2, plot(type = "l", DateTime, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power"))

dev.copy(png, file = "plot4.png", width = 480, height = 480)

dev.off()

