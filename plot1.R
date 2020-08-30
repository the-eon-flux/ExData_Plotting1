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

# Plot
        
        png("plot1.png", width = 480, height = 480)
        hist(Data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
        dev.off()






