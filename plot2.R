
#Download data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,
              destfile='power.zip',
              method="curl" # for OSX / Linux 
) # "wb" means "write binary," and is used for binary files

#Unzip the file
unzip(zipfile = "power.zip") # unpack the files into subdirectories 

#Read the file into R
EDA_power<-read.table(file='C:/Users/Kevin/Desktop/Data Analytics/JHU R/Course 4 EDA/household_power_consumption.txt',header = TRUE, sep = ";")

#Convert Date from Factor to Date
EDA_power$Date <- dmy(as.character(EDA_power$Date))

#Filter the EDA_power data.frame to our two days of interest
EDA_power_feb01<-filter(EDA_power, Date=='2007-02-01' )
EDA_power_feb02<-filter(EDA_power, Date=='2007-02-02' )
EDA_power_feb<-rbind(EDA_power_feb01,EDA_power_feb02)

#Convert Time from Factor to Time
library(chron)
EDA_power_feb$Time<-chron(times=EDA_power_feb$Time)

#Merge Date and Time
EDA_power_Feb_transform<-transform(EDA_power_feb, date_time=paste(Date, Time, sep=" "))
EDA_power_Feb_transform$date_time<-strptime(as.character(EDA_power_Feb_transform$date_time),format ="%Y-%m-%d %H:%M:%S" )


#Convert Global Active Power from factor to numeric
EDA_power_Feb_transform$Global_active_power<-as.numeric(as.character(EDA_power_feb$Global_active_power))

#Convert Sub_metering_1/2/3 from factor to numeric
EDA_power_Feb_transform$Sub_metering_1<-as.numeric(as.character(EDA_power_Feb_transform$Sub_metering_1))
EDA_power_Feb_transform$Sub_metering_2<-as.numeric(as.character(EDA_power_Feb_transform$Sub_metering_2))
EDA_power_Feb_transform$Sub_metering_3<-as.numeric(as.character(EDA_power_Feb_transform$Sub_metering_3))

#Convert Voltage & Global_reactive_power to numeric
EDA_power_Feb_transform$Voltage<-as.numeric(as.character(EDA_power_Feb_transform$Voltage))
EDA_power_Feb_transform$Global_reactive_power<-as.numeric(as.character(EDA_power_Feb_transform$Global_reactive_power))


png(filename = "plot2.png")

#plot 2
with(EDA_power_Feb_transform, plot(date_time, Global_active_power, type='l', xlab=' ',ylab='Global Active Powe (kilowatts)'))

dev.off()
