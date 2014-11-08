# Creates the directory for data, if it doesn't exists

if(!file.exists("Electric power consumption")) {
        dir.create("Electric power consumption")
}

# Creates the directory for plots, if it doesn't exist

if(!file.exists("plots")) {
        dir.create("plots")
}

# Downloads the file, if it is not loaded already

if(!file.exists("./Electric power consumption/data.zip")) {
        
        fileUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl,destfile="./Electric power consumption/data.zip")
}

#Recording the date
dateDownloaded<-date()

# Unzipping the files and deleting downloaded zipped file
unzip("./Electric power consumption/data.zip", exdir = getwd() )

# reads all data into data frame
allData<-read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

# adds new column containing whole date and converting it to "POSIXlt" "POSIXt"
allData$dateTime<-paste(allData$Date,allData$Time,sep =" " )
allData$dateTime<-strptime(allData$dateTime, "%d/%m/%Y %H:%M:%S")

# subsets to measurements that took place on 2007-02-01 and 2007-02-02
usedData<-subset(allData, dateTime>="2007-02-01" & dateTime<"2007-02-03")

# removes this large dataset after subsetting
rm(allData)

# plots 4 graphs in one plot (2 rows and 2 columns)

## changes time locale to have english names of days
Sys.setlocale("LC_TIME", "English") 

par(mfrow=c(2,2))

## plots graph 1
plot(usedData$date,usedData$Global_active_power, type="n", xlab =" ", ylab = "Global Active Power")
lines(usedData$date,usedData$Global_active_power)

## plots graph 2
plot(usedData$date,usedData$Voltage, type="n", xlab ="datetime", ylab = "Voltage")
lines(usedData$date,usedData$Voltage)

## plots graph 3
plot(usedData$date,usedData$Sub_metering_1, type="n", xlab =" ", ylab = "Energy sub metering")
lines(usedData$date,usedData$Sub_metering_1)
lines(usedData$date,usedData$Sub_metering_2, col = "red")
lines(usedData$date,usedData$Sub_metering_3, col = "blue")
## plots legend
legend("topright", lty=1, c("Sub_metering_1     ","Sub_metering_2       ","Sub_metering_3       "), col=c("black","red","blue"), horiz=FALSE, cex = .8, bty    = "n", y.intersp = .2)

## plots graph 4
plot(usedData$date,usedData$Global_reactive_power, type="n", xlab ="datetime", ylab = "Global_reactive_power")
lines(usedData$date,usedData$Global_reactive_power)

# saves graph as PNG 
dev.copy(png,file="./plots/plot4.png")
dev.off()
