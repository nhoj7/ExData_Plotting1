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

#1st plot
hist(uData$Global_active_power, xlab = "Global active power (kilowatts)", col = "red", main = paste("Global active power"))
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()