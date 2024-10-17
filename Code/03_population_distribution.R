install.packages("sdm")
install.packages("terra")

library(sdm)
library(terra)

file <- system.file("external/species.shp", package="sdm")
# [1] "C:/Users/Erika Zanetti/AppData/Local/R/win-library/4.4/sdm/external/species.shp"

rana <- vect(file)
rana

rana$Occurrence

plot(rana)

# Selecting presences
pres <- rana[rana$Occurrence==1]

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
points(pres, pch=19)
