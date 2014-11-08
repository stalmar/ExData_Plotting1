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

# plots histogram of Global_active_power

hist(usedData$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

# saves graph as PNG 
dev.copy(png,file="./plots/plot1.png")
dev.off()


