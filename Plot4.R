#' plot4.R
#' 
#' @description
#' Generate the fourth plot required for Project 1. The plot is contains
#' 4 different line plots. Two of the plots are the second and third plots
#' while the other two are line plots of Voltage and Global_reactive_power.
#' 
#' @docType package
#' @name plot4
#' @author Craig Struble <strubleca@@yahoo.com>
#' 
#' NB: This documentation is in roxygen2 format, but won't format as is.

# Load common declarations and functions
if (file.exists("common.R")) {
    source("common.R") # assumes the working directory contains this file.    
} else {
    stop("working directory does not contain the common.R script.")
}

# Read in the data.
dta <- readProjectData()

# Prepare for plotting
prepareForPlots()

# Open PNG file.
png(plotFilePath("plot4.png"),
    width=480,
    height=480)
# Setup for the 4 plots. Layout the plots in a 2 by 2 grid, filling in
# columnwise.
par(mfcol=c(2,2))

# From plot2.R, but modified to drop kilowatts
with(dta, 
     plot(DateTime, Global_active_power, type="l",
          xlab="", ylab="Global Active Power"))

# From plot3.R
with(dta, {
    # Initial line plot with Sub_metering_1 data
    plot(DateTime, Sub_metering_1, type="l", 
         xlab="", ylab="Energy sub metering") 
    
    # Now add the other sub-metering data with more lines
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    
    # Create the legend in the upper right, setting line width (required)
    # and the colors appropriately for the legend labels.
    legend("topright",
           legend=c("Sub_metering_1",
                    "Sub_metering_2",
                    "Sub_metering_3"),
           lwd=1,
           bty="n", # differs from plot3.R to match plot4
           col=c("black", "red", "blue")
    )
})

# Voltage plot
with(dta,
     plot(DateTime, Voltage, type="l", xlab="datetime"))

# Global_reactive_power plot
with(dta,
     plot(DateTime, Global_reactive_power, type="l", xlab="datetime"))

# Close the PNG
dev.off()

