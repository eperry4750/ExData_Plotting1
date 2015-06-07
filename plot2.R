# if the data folder does not exist, create it
if(!file.exists("./data")){dir.create("./data")
}

# if the zip file does not exist download it.
if(!file.exists("./data/Dataset.zip")){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip")
}

# if the text file does not exist down unzip it.
if(!file.exists("./data/household_power_consumption.txt")){
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
}

# creates the data table energy data from 'household_power_consumption.txt'
energy_data <- read.csv(file='./data/household_power_consumption.txt', head=TRUE,
                        sep=';',na.strings = c("?"))

# creates the subset named energy_dates which includes only the dates '1/2/2007' and '/2/2007'
# from the data table energy_data
energy_dates <- subset(energy_data, Date == '1/2/2007'|Date == '2/2/2007')

# merges the columns Date and Time into DateTime and reformats the date and time.
energy_dates$DateTime <- strptime(paste(energy_dates$Date, energy_dates$Time),
                                  format="%d/%m/%Y %H:%M:%S")

# starts the png device saves the the file in ./data/plot2.png'
png(filename="./data/plot2.png", width = 480, height = 480,units = "px")

# creates the line graph 
plot(energy_dates$DateTime,energy_dates$Global_active_power,
     type='l', xlab='', ylab='Global Active Power(kilowatts)')

# closes the png device
dev.off()