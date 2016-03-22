#' common.R
#' 
#' @description
#' Definition of variables and functions used in all the files. Sourced
#' in each plotting script file used in this project.
#' 
#' @docType package
#' @name common
#' @author Craig Struble <strubleca@@yahoo.com>
#' 
#' NB: This documentation is in roxygen2 format, but won't format as is.

# The data URL
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# The local data directory for where the data should be placed. 
dataDir <- "./data"  

# The plots directory
plotsDir <- "./plots"

# Name of the raw data file
rawDataFile <- file.path(dataDir, "household_power_consumption.zip")

# The top level directory name of the raw data. From the ZIP file.
unzippedDataFile <- file.path(dataDir, "household_power_consumption.txt")

# The file containing the date the raw data was downloaded.
dateFile <- file.path(dataDir, "dateDownloaded.txt")

#' Prepare the current working directory for storing plots.
#' 
#' Prepare the current working directory for storing plots. Creates a
#' directory using the defined plots directory.
prepareForPlots <- function() {
    if (!file.exists(plotsDir)) {
        writeLines(paste("Creating", plotsDir))
        dir.create(plotsDir)
    }
}

#' Generate a file path for a plot file name.
#' 
#' Generate a file path for a plot file name.
#' 
#' @param plotName the name of the plot file
#' @returns a character vector containing the name of the plot in the plotting
#' output directory.
#' @examples
#' plotFilePath("plot1.png") # returns ./plots/plot1.png with default values.
plotFilePath <- function(plotName) {
    file.path(plotsDir, plotName)
}

#' Read in the data.
#' 
#' Reads in the data for this project and returns a data frame.
#' 
#' @returns a data frame containing the project data.
#' @examples
#' readProjectData()
readProjectData <- function() {
    if (file.exists(unzippedDataFile)) {
        writeLines(paste("Reading", unzippedDataFile, "..."))
        dta <- read.delim(unzippedDataFile, sep = ";", na.strings="?",
                          stringsAsFactors = FALSE)
        
        # Create a formatted date column
        dta$DateObj  <- as.Date(dta$Date, format="%d/%m/%Y")
        
        # Get only the subset we want
        dta <- subset(dta, "2007-02-01" <= DateObj & DateObj <= "2007-02-02")

        # Combine date and time into one column.
        # Do this after subsetting because it'll be a little faster.
        dta$DateTime <- strptime(paste(dta$Date, dta$Time), 
                                 format="%d/%m/%Y %H:%M:%S")
        dta$DateTime <- as.POSIXct(dta$DateTime)
        
        # Force to be in correct date and time order. We could assume that
        # data is in order, which it appears to be, but often it's better
        # to be on the safe side. This could be excluded if the data is known
        # for sure to be in order and this takes too long.
        dta <- dta[order(dta$DateTime),]
        dta
    } else {
        stop(paste("download and unzip", rawDataFile, "first"))
    }
}
