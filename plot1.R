
conn <- file("household_power_consumption.txt", "r")
found <- FALSE
nbRow <-0
startingRow <- 0

while(length(line <- readLines(conn, 1)) > 0 & !found) {
  grepRes <- grepl("1/2/2007",line)
  if(grepRes)
    {
      found <- TRUE
      startingRow <- nbRow
    }  
  nbRow <- nbRow+1
}
close(conn)
eleccons <- read.table("household_power_consumption.txt",skip=startingRow,nrows=2880,sep=";")
colnames(eleccons) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

eleccons$DateTime <- strptime(paste(eleccons$Date,eleccons$Time),"%d/%m/%Y %H:%M:%S")

## Plot 1
hist(eleccons$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

