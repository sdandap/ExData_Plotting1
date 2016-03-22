#' plot3.R
#' 
#' @description
#' Generate the third plot required for Project 1. The plot is a line plot
#' of sub-metering data, one line per submeter type.
#' 
#' @docType package
#' @name plot3
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

# Open PNG file
png(plotFilePath("plot3.png"),
    width=480,
    height=480)

# Generate sub_metering plots.
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
           col=c("black", "red", "blue")
           )
})

# Close PNG file
dev.off()
