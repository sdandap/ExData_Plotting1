#' plot1.R
#' 
#' @description
#' Generate the first plot required for Project 1. The plot is a histogram
#' of global active power in kilowatts.
#' 
#' @docType package
#' @name plot1
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
png(plotFilePath("plot1.png"),
    width=480,
    height=480)

# Generate histogram of global active power readings
hist(dta$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red")

# Close PNG file.
dev.off()
