## download archive if file is missing
if (!(file.exists("household_power_consumption.txt"))) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                destfile="household_power_consumption.zip",method="wget")
  unzip(zipfile="household_power_consumption.zip")  
}

## read datafile from dates 2007-02-01 to 2007-02-02
powerData <- read.csv("household_power_consumption.txt", sep = ";", header = F, 
                      nrows=2880, skip=66637)
## add col names
colnames(powerData) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                         "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                         "Sub_metering_3")

## adjusting date and time
powerData$Time <- strptime(paste(powerData$Date,powerData$Time, sep = " "), 
                           format = "%d/%m/%Y %H:%M:%S")

## remove old date colum
powerData <- subset(powerData, select = -c(Date))

## plot
png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")
par(mfrow=c(2,2))

## 1,1
with(powerData, plot(y = Global_active_power, x = Time, type = "n",xlab = "", 
                     ylab="Global Active Power"), bg = NA)
with(powerData, lines(y = Global_active_power, x = Time))

## 1,2
with(powerData, plot(y = Voltage, x = Time, type = "n",xlab = "datetime", 
                     ylab = "Voltage"), bg = NA)
with(powerData, lines(y = Voltage, x = Time))

## 2,1
with(powerData, plot(y = Sub_metering_1, x = Time, type = "n",xlab = "", 
                     ylab = "Energy sub metering", bg = NA))
with(powerData, lines(y = Sub_metering_1, x = Time, col= "black"))
with(powerData, lines(y = Sub_metering_2, x = Time, col= "red"))
with(powerData, lines(y = Sub_metering_3, x = Time, col= "blue"))
legend("topright", lty = "solid", bty = "n", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## 2,2
with(powerData, plot(y = Global_reactive_power, x = Time, type = "n",xlab = "datetime", 
                     ylab = "Global_reactive_power"), bg = NA)
with(powerData, lines(y = Global_reactive_power, x = Time))

dev.off()