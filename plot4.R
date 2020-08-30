library(lubridate)

# Download the files 

        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "Data.zip", method = "curl" )
        unzip("./Data.zip")

        DateCol <- read.table( "./household_power_consumption.txt" , sep=';', header = T, colClasses =c('character', rep("NULL", 8)) )
        DateCol$Date <- dmy(DateCol$Date)

# Getting the row indices so that we can read subset of the huge data
        Start_I <- which(DateCol$Date == "2007-02-01")[1]
        End_I <- tail(which(DateCol$Date == "2007-02-02"),1)

# Reading required data
        Data <- read.table( "./household_power_consumption.txt" , skip = Start_I , nrows =(End_I - Start_I) , sep=';', header = F, stringsAsFactors = F)
        ColNames <- read.table( "./household_power_consumption.txt", sep=';', header = T, nrows = 1)

# Assigning colnames
        colnames(Data) <- names(ColNames)

# Removing unwanted objects
        rm(c("DateCol", "ColNames"))

# Looking for missing data if any encoded as '?
        sapply( Data, function(Col){sum(which(Col == '?'))})

# NA values if any
        sapply( Data, function(Col){sum(which(is.na(Col)))})



        Data$Weekday <- strptime(paste(Data$Date, Data$Time), '%d/%m/%Y %H:%M:%S')

        png("plot4x.png", width = 480, height = 480)
# Plot
        par(mfrow=c(2,2))

# P1
        plot(Data$Weekday, Data$Global_active_power, pch=7, type='l', xlab = "Day", ylab = "Global Active power (in kilowatts)")

# P2
        plot(Data$Weekday, Data$Voltage, pch=7, type='l', xlab = "Day", ylab = "Voltage")

# P3
        plot(Data$Weekday ,Data$Sub_metering_1, col="red", type='l', xlab = "Day", ylab = "Energy submetering")
        lines(Data$Weekday, Data$Sub_metering_2, col="black")
        lines(Data$Weekday, Data$Sub_metering_3, col = "blue")
        legend("topright", pch = 7 ,col = c("red", "blue", "black"), legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

# P4
        plot(Data$Weekday, Data$Global_reactive_power, pch=7, type='l', xlab = "Day", ylab = "Global Reactive power (in kilowatts)")

        dev.off()














