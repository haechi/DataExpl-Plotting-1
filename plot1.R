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
png(filename = "plot1.png", width = 480, height = 480, bg = "transparent")

hist(powerData$Global_active_power,col="red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)", bg = NA)

dev.off()