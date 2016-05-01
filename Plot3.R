
library(data.table)

##Read the entire file into memory
df <- read.table("household_power_consumption.txt", header =TRUE, sep = ";",na="?",colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))


##Conver the Data column to type data
df[,1] <- as.Date(df[,1],format="%d/%m/%Y")

start_date <- as.Date("31/01/2007",format="%d/%m/%Y")
end_date <- as.Date("03/02/2007",format="%d/%m/%Y")

#Fiter only observation from 01/02/2017 to 02/02/2007
data_analysis <- df[(df$Date>start_date & df$Date<end_date),]


##Check for complete case
data_analysis<-data_analysis[complete.cases(data_analysis[,]),]

##Convert the time column to type time
data_analysis$Time <- strptime(paste(as.character(data_analysis$Date), data_analysis$Time), "%Y-%m-%d %H:%M:%S")



png("plot3.png", width = 480, height = 480)
plot(data_analysis$Time, data_analysis$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data_analysis$Time, data_analysis$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering",col="red")
lines(data_analysis$Time, data_analysis$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering",col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, col=c("black", "red", "blue"))
dev.off()

