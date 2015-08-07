# plot4.R


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
png("plot4.png", 
	width = 480, 
	height = 480, 
	units = "px", 
	bg = "white")

# create 2x2 grid
par(mfrow=c(2,2))


# top left plot: Global_active_power over time
plot(raw$Time, 
	raw$Global_active_power, 
	type = "l", 
	xlab = "",
	ylab = "Global Active Power")


# top right plot: Voltage over time
plot(raw$Time, 
	raw$Voltage, 
	type = "l", 
	xlab = "datetime",
	ylab = "Voltage")


# bottom left plot: Sub_metering over time
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


# bottom right plot: Global_reactive_power over time
plot(raw$Time, 
	raw$Global_reactive_power, 
	type = "l", 
	xlab = "datetime",
	ylab = "Global_reactive_power")

# shut down device
dev.off()
