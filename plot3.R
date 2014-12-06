# setwd("C:/Users/Ultrabook Ultra You/Documents/Data Scientist/ExploratoryDataAnalysis/Course Project One")

## Check availability of the original dataset source in your working directory

if (!file.exists("./household_power_consumption.txt")) {
  fileURL<-"https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
  download.file(fileURL, destfile = "household_power_consumption.zip", mode = "wb") 
  unzip("./household_power_consumption.zip",exdir=getwd())
}

# #### Solution 1: Using read.table to read all data (it is slow and too many steps) 
# 
# # Check on source data folder for any .txt files to a list
# FileList <- list.files("./", pattern="consumption\\.txt$",full.names=TRUE) 
# 
# # Using read.table to read all data to a RAW dataset 
# DF_RAW <- read.table(FileList, header = TRUE, sep = ";", na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7)))
# 
# # Check on class for each column
# # sapply(DF_RAW, class)
# #                 Date                  Time   Global_active_power 
# #          "character"           "character"             "numeric" 
# #Global_reactive_power               Voltage      Global_intensity 
# #            "numeric"             "numeric"             "numeric" 
# #       Sub_metering_1        Sub_metering_2        Sub_metering_3 
# #            "numeric"             "numeric"             "numeric" 
# 
# # Convert 'Date' column from character class to Date class
# DF_RAW[,1] <- as.Date(DF_RAW[,1],"%d/%m/%Y")
# 
# # Subsetting DF_RAW by selecting 'Date' between 2007/02/01 to 2007/02/02 
# WorkingDF_RAW <- subset(DF_RAW, (DF_RAW[,1] >= as.Date("2007-02-01") & DF_RAW[,1] <= as.Date("2007-02-02")))
# 
# # Consolidate 'Date' and 'Time' column to date-time column
# WorkingDF_RAW[,2] <- paste(WorkingDF_RAW[,1],WorkingDF_RAW[,2])
#
# # Convert column 2 to class of POSIXct
# WorkingDF_RAW[,2] <- as.POSIXct(strptime(WorkingDF_RAW[,2],format="%Y-%m-%d %H:%M:%S"))
# 
# # Convert 'Date' column to weekdays and make it as factors
# WorkingDF_RAW[,1] <- as.factor(weekdays(WorkingDF_RAW[,1], abbreviate=TRUE))
# 
# # Rename 'Date' column to 'WeekDay'
# names(WorkingDF_RAW)[1] <- "WeekDay"
# 
# # Rename 'Time' column to 'DateTime'
# names(WorkingDF_RAW)[2] <- "DateTime"


#### Solution 2: Using data.table fread() to read selected data (it is fast and simple) 

# Install and load data.table package
library(data.table)

# Check on source data folder for any .txt files to a list
FileList <- list.files("./", pattern="consumption\\.txt$",full.names=TRUE)

# Open source dataset .txt file in Notapad++, 
# search "1/2/2007" to get 66638 as the first line to read -  starting row
# serach "3/2/2007" to get 69517 as the last line to read - end row (2880 rows needs to be read) 
# Select rows from no. 66638 and read only 2880 rows, which are raw data for 2007/02/01-02/02
WorkingDF_RAW <- fread(FileList, header = FALSE, skip=66637, nrows=2880, sep = ";", na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7)))

# Read only the first line to generate a header
WorkingDF_Header <- fread(FileList, header = TRUE, nrows=0, sep = ";")

# Change old header (NULL) to a new one 
setnames(WorkingDF_RAW,names(WorkingDF_RAW),names(WorkingDF_Header))

# Cpnvert WorkingDF_RAW to a data frame
WorkingDF_RAW <- as.data.frame(WorkingDF_RAW)

# Consolidate 'Date' and 'Time' column to date-time column
WorkingDF_RAW[,2] <- paste(WorkingDF_RAW[,1],WorkingDF_RAW[,2])

# Convert column 2 to class of POSIXct
WorkingDF_RAW[,2] <- as.POSIXct(strptime(WorkingDF_RAW[,2],format="%d/%m/%Y %H:%M:%S"))

# Convert 'Date' column from character class to Date class
WorkingDF_RAW[,1] <- as.Date(WorkingDF_RAW[,1],"%d/%m/%Y")

# Rename 'Time' column to 'DateTime'
names(WorkingDF_RAW)[2] <- "DateTime"

## png device supports transparent backgrounds: use bg = "transparent" below. 
## But not all PNG viewers render files with transparency correctly(Tested OK on Internet Explorer 11). 

# ## Plot 1
# png(file="plot1.png", bg="transparent")
# hist(WorkingDF_RAW[,3], xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
# # dev.copy(png,file="plot1.png")
# dev.off()
# 
# ## Plot 2
# png(file="plot2.png", bg="transparent")
# plot(WorkingDF_RAW[,2], WorkingDF_RAW[,3], xlab="", ylab="Global Active Power (kilowatts)", type="l", axes = FALSE)
# axis.POSIXct(1, at=seq(min(WorkingDF_RAW[,2]), max(WorkingDF_RAW[,2])+60, "days"), format="%a")
# # axis(1, c(1,1440,2880), c("Thu","Fri","Sat"))
# axis(2)
# box()
# # dev.copy(png,file="plot2.png")
# dev.off()

## Plot 3
png(file="plot3.png", bg="transparent")
plot(WorkingDF_RAW[,2], WorkingDF_RAW[,7], xlab="", ylab="Energy sub metering", type='l', axes = FALSE)
axis.POSIXct(1, at=seq(min(WorkingDF_RAW[,2]), max(WorkingDF_RAW[,2])+60, "days"), format="%a")
# axis(1, c(1,1440,2880), c("Thu","Fri","Sat"))
axis(2)
box()
lines(WorkingDF_RAW[,2], WorkingDF_RAW[,8], col="red")
lines(WorkingDF_RAW[,2], WorkingDF_RAW[,9], col="blue")
legend("topright", lty=1, y.intersp = 1.0, x.intersp = 1.0, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# dev.copy(png,file="plot3.png")
dev.off()

# ## Plot 4
# png(file="plot4.png", bg="transparent")
# par(mfcol=c(2,2),mar=c(4,4,1,2))
# 
# plot(WorkingDF_RAW[,2],WorkingDF_RAW[,3], xlab="", ylab="Global Active Power", type="l", axes = FALSE)
# axis.POSIXct(1, at=seq(min(WorkingDF_RAW[,2]), max(WorkingDF_RAW[,2])+60, "days"), format="%a")
# # axis(1, c(1,1440,2880), c("Thu","Fri","Sat"))
# axis(2)
# box()
# 
# plot(WorkingDF_RAW[,2], WorkingDF_RAW[,7], xlab="", ylab="Energy sub metering", type='l', axes = FALSE)
# axis.POSIXct(1, at=seq(min(WorkingDF_RAW[,2]), max(WorkingDF_RAW[,2])+60, "days"), format="%a")
# # axis(1, c(1,1440,2880), c("Thu","Fri","Sat"))
# axis(2)
# lines(WorkingDF_RAW[,2], WorkingDF_RAW[,8], col="red")
# lines(WorkingDF_RAW[,2], WorkingDF_RAW[,9], col="blue")
# legend("topright", lty=1, box.lty=0, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# box()
# 
# plot(WorkingDF_RAW[,2], WorkingDF_RAW[,5], xlab="datetime", ylab="Voltage", type="l", axes = FALSE)
# axis.POSIXct(1, at=seq(min(WorkingDF_RAW[,2]), max(WorkingDF_RAW[,2])+60, "days"), format="%a")
# # axis(1, c(1,1440,2880), c("Thu","Fri","Sat"))
# axis(2)
# box()
# 
# plot(WorkingDF_RAW[,2], WorkingDF_RAW[,4], xlab="datetime", ylab="Global_reactive_power", type="l", axes = FALSE)
# axis.POSIXct(1, at=seq(min(WorkingDF_RAW[,2]), max(WorkingDF_RAW[,2])+60, "days"), format="%a")
# # axis(1, c(1,1440,2880), c("Thu","Fri","Sat"))
# axis(2)
# box()
# 
# # dev.copy(png,file="plot4.png")
# dev.off()