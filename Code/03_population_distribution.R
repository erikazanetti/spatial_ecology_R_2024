# Why populations disperse over time in a landscape

# Install and load necessary packages
install.packages("sdm")  # Species distribution modeling
install.packages("terra")

library(sdm)
library(terra)

# Find and load a shapefile from the package
file <- system.file("external/species.shp", package="sdm")  
# [1] "C:/Users/Erika Zanetti/AppData/Local/R/win-library/4.4/sdm/external/species.shp"
# in sdm folder there is a file called "external", using system.file finds the name of the file
# species.shp is related to data for species, shp means "shapefile" that is a type of file originally from a company

# Convert the shapefile to a format R can use
rana <- vect(file)  # Convert .shp file to a SpatVector object
rana  # Display information about the dataset

# Extract and plot occurrence data
rana$Occurrence  
plot(rana)  # Plot all data points (presence = 1, absence = 0)

# Selecting presences (Occurrence = 1)
pres <- rana[rana$Occurrence == 1]  
pres$Occurrence  # Verify only presence points remain


# let's use the data with a function to traslate .shp to type of file that R can use. spatvector is the one R can use, the function is called vect
rana <- vect(file) # file is the object we named before instead of writing system.file etc...
rana # Display information about the dataset
# This includes details such as coordinate system (WGS84, UTM zone 30N)
# and species occurrence data (1 = present, 0 = absent)

# Extract and plot occurrence data
rana$Occurrence 
plot(rana)  # Plot all data points (presence = 1, absence = 0)

# Selecting presences
pres <- rana[rana$Occurrence == 1]  # Select only points where the species is present
pres$Occurrence  # Verify only presence points remain

# Plot presence and all data points side by side
par(mfrow=c(1,2))  
plot(rana)  # All data points
plot(pres)  # Only presences

# Selecting presences
pres <- rana[rana$Occurrence==1] 
# In SQL-like query languages, the equality operator is written as '=='
# Unlike SQL, which ends statements with a ';', R does not require it.
pres
pres$Occurrence # and in fact now all occurrences are 1

dev.off()

# Selecting absences
abse <- rana[rana$Occurrence == 0] 
abse$Occurrence 
plot(abse)  # Plot only absence points

# Plot presences beside absences
par(mfrow=c(1,2))  
plot(pres)  
plot(abse)  

# Plot presences on top of absences
par(mfrow=c(2,1))  
plot(pres)  
plot(abse)  

# Plot presences in blue and absences in red
plot(pres, col="blue", pch=19, cex=2)  # Blue points for presences
points(abse, col="red", pch=19, cex=2)  # Red points for absences

# Load elevation data
elev <- system.file("external/elevation.asc", package="sdm")
elevmap <- rast(elev) # Convert elevation file to raster format
plot(elevmap)  # Plot elevation map

# Change elevation map colors using a color gradient
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(elevmap, col=cl)  

# Overlay presence points on the elevation map
points(pres, pch=19)
