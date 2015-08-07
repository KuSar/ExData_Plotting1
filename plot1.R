# plot1.R
# script to import data and save histogram of Global Active Power
# as PNG

# import data from text file
raw <- read.table("household_power_consumption.txt",
	sep = ";",	
	header = TRUE, 
	stringsAsFactor = FALSE, 
	na.strings="?")

# convert Date column to date format
raw$Date <- as.Date(raw$Date, format = "%d/%m/%Y")

# index of rows with date between 2007/02/01 and 2007/02/02
index <- which( raw$Date >= as.Date("2007-02-01", format = "%Y-%m-%d") 
	& raw$Date <= as.Date("2007-02-02", format = "%Y-%m-%d") )

# extract only relevant data
raw <- raw[index,]

# open graphics device PNG
png("plot1.png", 
	width = 480, 
	height = 480, 
	units = "px", 
	bg = "white")

# draw histogram
hist(raw$Global_active_power, 
	main = "Global Active Power", 
	axes = TRUE, 
	xlab = "Global Active Power (kilowatts)", 
	col = "red")

# shut down device
dev.off()