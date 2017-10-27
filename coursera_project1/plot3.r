#Reading data
data <- read.csv("household_power_consumption.txt", sep = ';', stringsAsFactors = FALSE) #hoped this would automatically finds the right type, but it defaulted to <chr>

#Fixing data types
data$Datetime <- as.POSIXct(strptime(paste(data$Date,data$Time), format = '%d/%m/%Y %H:%M:%S')) #Need to convert to POSIXct, because strptime output is POSIXlt, which is a list and don't do well on a dataframe
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

#Subsetting data
data <- subset(data, Datetime  >= '2007-02-01' & Datetime < '2007-02-03')

#Plotting and saving
png(filename = 'plot3.png', width = 480, height = 480, bg = NA) #bg = NA gives us the nice png proeperty of transparent background
plot(x = data$Datetime, 
     y = data$Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
lines(x = data$Datetime, 
      y = data$Sub_metering_2, 
      col = "red")
lines(x = data$Datetime, 
      y = data$Sub_metering_3, 
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lwd = c(2,2), #because we want lines on the legend
       col =c("black","red","blue"), #and we want them in the right color
       bty = "n") #bty = "n" gets rid of the legend box borders
dev.off()