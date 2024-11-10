# Why populations disperse over time in a landscape in a certain way
# topics:
# find a file in the package
# function vect()
# Selecting presences



install.packages("sdm") # species distribution modelling
install.packages("terra")

library(sdm)
library(terra)

# we want to make a subset of a data, to select only some points
file <- system.file("external/species.shp", package="sdm")
# [1] "C:/Users/Erika Zanetti/AppData/Local/R/win-library/4.4/sdm/external/species.shp"
# in sdm folder there is a file called "external"  and in it there are some data we're gonna use today. Using system.file finds the name of the file
# species.shp is related to data for species, shp means "shapefile" that is a type of file originally from a company

# let's use the data with a function to traslate .shp to type of file that R can use. spatvector is the one R can use, the function is called vect
rana <- vect(file) # file is the object we named before instead of writing system.file etc...
rana
# the information we find: 1) it is a spatvector, 2) type of file (points), 3) extent, source, coordinates: wgs84, utm zone 30N, EPSG (code used for every single coordinate system), names: for each point there's a data recorded, occurance or not of a certain species, so if the species is present (1) or not (0) we write the numbers in each point 

rana$Occurrence
plot(rana) # in this file some points represent the presence of the species (occurance = 1) and other the absence (occurance = 0)

# Selecting presences
pres <- rana[rana$Occurrence==1] # in sequel language (used here to select only data with occurence of 1) the equal is written with two ==, in sequel all finishes with ";"
pres
pres$Occurrence # and in fact now all occurrences are 1

# exercise: plot presences and absences, one beside the other
par(mfrow=c(1,2))
plot(rana)
plot(pres)

# exercise: select absences
abse <- rana[rana$Occurrence==0]
abse$Occurrence
dev.off()
plot(abse)

# exercise: plot in a multiframe presences besides absences
par(mfrow=c(1,2))
plot(pres)
plot(abse)

# exercise: plot in a multiframe presences on top of absences
par(mfrow=c(2,1))
plot(pres)
plot(abse)

# exercise: plot the presence in blue together with absences in red
plot(pres, col="blue", pch=19, cex=2)
points(abse, col="red", pch=19, cex=2)

# Covariets
elev <- system.file("external/elevation.asc", package="sdm")
elev

elevmap <- rast(elev)
elevmap
plot(elevmap)

# exercise: change the colors of the elevation map by the colorRampPalette function
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(elevmap, col=cl)

# exercise: plot the presence together with the elevation map
points(pres, pch=19) # no need for par() because we put points on a plot made of a map (rast file), i punti sopra la mappa, quindi non separati ma uno sopra l'altro
