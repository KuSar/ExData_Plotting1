# plot3.R
# script to import data and save line chart of Sub_metering_1,
# Sub_metering_2, Sub_metering_3 over time as PNG

# import data from text file
raw <- read.table("household_power_consumption.txt",
	sep = ";",	
	header = TRUE, 
	stringsAsFactor = FALSE, 
	na.strings="?")

# convert Time column to datetime
raw$Time <- strptime( 
	paste(raw$Date, raw$Time), 
	format = "%d/%m/%Y %H:%M:%OS")

# convert Date column to date format
raw$Date <- as.Date(raw$Date, format = "%d/%m/%Y")

# index of rows with date between 2007/02/01 and 2007/02/02
index <- which( raw$Date >= as.Date("2007-02-01", format = "%Y-%m-%d") 
	& raw$Date <= as.Date("2007-02-02", format = "%Y-%m-%d") )

# extract only relevant data
raw <- raw[index,]

# set sys to english (otherwise day of week won't be in english)
# for Unix use Sys.setlocale("LC_TIME", "en_US.UTF-8")
Sys.setlocale("LC_TIME", "English")

# open graphics device PNG
png("plot3.png", 
	width = 480, 
	height = 480, 
	units = "px", 
	bg = "white")

# plot Sub_metering_1
plot(raw$Time,
	raw$Sub_metering_1,
	type = "l",
	xlab = "",
	ylab = "Energy sub metering")

# add line for Sub_metering_2
lines(raw$Time,
	raw$Sub_metering_2,
	type = "l",
	col = "red")

# add line for Sub_metering_3
lines(raw$Time,
	raw$Sub_metering_3,
	type = "l",
	col = "blue")

# add legend
legend("topright", 
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = 1, 
    col = c("black", "red", "blue"),
    xjust = 0, 
    yjust = 0)

# shut down device
dev.off()
