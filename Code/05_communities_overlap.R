# Estimating Temporal Overlap Between Species

# Install and load necessary package
install.packages("overlap")  # Package for analyzing temporal overlap
library(overlap)

# Load dataset
data(kerinci)  # Contains species observations with time records

# Display dataset
head(kerinci)  # First 6 rows to inspect structure
summary(kerinci)  # Summary statistics for each column
kerinci  # Full dataset view

# Convert time to a circular scale (0 to 1 transformed to radians)
kerinci$Timecirc <- kerinci$Time * 2 * pi  
# Transforming time from a linear scale to a circular one
# `$` is used to assign a new column within the dataset
# `*` is multiplication, `pi` represents the mathematical constant π

head(kerinci)  # Verify the new column is added

# Extracting data for tigers
tiger <- kerinci[kerinci$Sps == "tiger",]  # Selecting rows where species is 'tiger'

# Extracting time data for tigers
tigertime <- tiger$Timecirc  

# Density plot for tiger activity
densityPlot(tigertime)  # Visual representation of tiger activity over time

# Extracting data for macaques
macaque <- kerinci[kerinci$Sps == "macaque",]  # Selecting rows where species is 'macaque'

# Extracting time data for macaques
macaquetime <- macaque$Timecirc  

# Density plot for macaque activity
densityPlot(macaquetime)  

# Overlapping density plots to analyze temporal overlap
overlapPlot(tigertime, macaquetime)  # Visualizes time overlap between tigers and macaques

# Additional selection: filtering out macaque observations
summary(macaque)  # Summary of macaque observations
nomacaque <- kerinci[kerinci$Sps != "macaque",]  # Select all non-macaque records
summary(nomacaque)  # Summary of dataset excluding macaques

#----- 
macaque <- kerinci[kerinci$Sps=="macaque",] 
summary(macaque)
# "==" means equal, and "!=" means not equal (cioè punto esclamativo assieme a uguale)
nomacaque <- kerinci[kerinci$Sps!="macaque",]
summary(nomacaque)
