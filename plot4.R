#Download the zipped file if both zip file and txt file don't exist in the current directory
if (!file.exists("exdata-data-household_power_consumption.zip") & !file.exists("household_power_consumption.txt")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  file <- download.file(fileUrl, target <- "exdata-data-household_power_consumption.zip", method = "curl")
  print("Downloaded")
}

#Unzip the file if the text file doesn't exist
if (!file.exists("household_power_consumption.txt")){
  unzip("exdata-data-household_power_consumption.zip") 
  print("Unzipped")
}

#Load data
data <- read.csv("household_power_consumption.txt", sep = ";")

#Choose data for the appropriate dates
uData <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

#Convert data for collumns 3 to 9 from factor to numerical
tempNum <- as.numeric(sapply(uData[,3:9], as.character))
uData[,3:9] <- tempNum

#Create a vector with full time from collumns 1 and 2 of the data
temp <- paste(uData[,1], uData[,2])
time <- strptime(temp, "%d/%m/%Y %H:%M:%S")

#4th plot
par(mfrow = c(2,2))
plot(time, uData$Global_active_power, type = "l", ylab = "Global active power (kilowatts)", xlab = "")
plot(time, uData$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(time, uData$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(time, uData$Sub_metering_2, type = "l", col = "red")
lines(time, uData$Sub_metering_3, type = "l", col = "blue")
plot(time, uData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()