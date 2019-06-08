## Loading the data
t1 <- strptime("2006-12-16 17:24:00", format = "%Y-%m-%d %H:%M:%S")
t2 <- strptime("2007-2-1 00:00:00", format = "%Y-%m-%d %H:%M:%S")
t3 <- strptime("2007-2-3 00:00:00", format = "%Y-%m-%d %H:%M:%S")
skiprownum <- as.numeric(t2-t1)*24*60
keeprownum <- as.numeric(t3-t2)*24*60

datacolname <- colnames(read.table("household_power_consumption.txt", nrow = 1, 
                                   sep=";", header = TRUE))

mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                     na.strings = "?", as.is = TRUE, col.names = datacolname,
                     skip = skiprownum, nrows = keeprownum)

mydata$Time <- strptime(paste(mydata$Date,mydata$Time), format="%d/%m/%Y %H:%M:%S")


## Plot3
with(mydata,plot(Time, Sub_metering_1, type = "l", xlab = "", 
                 ylab = "Energy sub metering"))
lines(mydata$Time,mydata$Sub_metering_2, col = "red")
lines(mydata$Time,mydata$Sub_metering_3, col = "blue")
legend("topright",
       lty=1,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Save to PNG
dev.copy(png,file="plot3.png", width = 480, height = 480)
dev.off()