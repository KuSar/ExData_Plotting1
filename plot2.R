# plot2.R
# script to import data and save line chart of Global Active Power
# over time as PNG

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
png("plot2.png", 
	width = 480, 
	height = 480, 
	units = "px", 
	bg = "white")

# plot data (type l -> lines)
plot(raw$Time, 
	raw$Global_active_power, 
	type = "l", 
	xlab = "",
	ylab = "Global Active Power (kilowatts)")

# shut down device
dev.off()