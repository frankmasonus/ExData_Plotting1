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


#plot2
if(dev.cur() == 1) dev.new()
par(mfrow=c(1,1), bg="white")
plot(cdt$PDT, cdt$GAP,  type="l", xlab="", ylab="Global Active Power (kilowatts)")
lines(Sumtq$hour, Sumtq$x,pch=20,col="navy")
dev.copy(png, "plot2.png")
dev.off()
