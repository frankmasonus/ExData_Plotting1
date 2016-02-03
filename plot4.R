require(data.table)

#getting data and preparing frame
if(!file.exists("./Project/data")){
    dir.create("./Project/data", recursive="TRUE");
}
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./Project/data/DataSet.zip",method="curl")
dateDownloaded <- date()
unzip("./Project/data/DataSet.zip", exdir = "./Project/data/extracted/" )
list.files("./Project/data/extracted/", recursive=TRUE )
dt <- fread( "./Project/data/extracted/household_power_consumption.txt")
dt$PDT <- as.POSIXct (paste(dt$Date, dt$Time),format="%d/%m/%Y %H:%M:%S")
cdt <- dt[PDT>"2007-02-01" & PDT<"2007-02-03"]
cdt$GAP <- as.numeric(cdt$Global_active_power)

#group
if(dev.cur() == 1) dev.new()
par(mfrow=c(2,2), mar=c(4,5,1,1), bg="white")
plot(cdt$PDT, cdt$GAP,  type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(cdt$PDT, cdt$Voltage,  type="l", xlab="datetime", ylab="Voltage")
plot(cdt$PDT, cdt$Sub_metering_1,  type="l", xlab="", ylab="Energy sub metering")
lines(cdt$PDT, cdt$Sub_metering_2,type="l",col="red")
lines(cdt$PDT, cdt$Sub_metering_3,type="l",col="blue")
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(cdt$PDT, cdt$Global_reactive_power,  type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, "plot4.png")
dev.off()



