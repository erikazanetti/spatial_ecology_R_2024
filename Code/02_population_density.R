# how to calculate the density of individuals in a population
# topics:
# using a dataset
# extracting data
# plotting a density map
# plotting the maps one beside the other
# changing colors to maps
# increase the gradient

# A package is needed for point pattern analysis, installing the spatstat package
install.packages("spatstat")

# Recalling the package
library(spatstat)

# let's use the bei dataset:
bei

plot(bei)
plot(bei, pch=19)
plot(bei, pch=19, cex=0.5)

# additional datasets
bei.extra
plot(bei.extra) # it shows me two images, one is elevation and one is graduation

# extracting data
elevation <- bei.extra$elev
plot(elevation) # now i only see elevation

elevation <- bei.extra[[1]]

# density map starting from points
densitymap <- density(bei)

plot(densitymap)
points(bei, col="green")

# plotting the maps one beside the other
par(mfrow=c(1,2))
plot(elevation2)
plot(densitymap)

# exercise: make a multiframe with maps one on top of the other
par(mfrow=c(2,1))
plot(elevation2)
plot(densitymap)

# let's go back to the original plot(s)
dev.off()
plot(elevation2)

# changing colors to maps
cl <- colorRampPalette(c("red", "orange", "yellow"))(3)
plot(densitymap,col=cl)

# increase the gradient
cl <- colorRampPalette(c("red", "orange", "yellow"))(10)
plot(densitymap,col=cl)

# increase again
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(densitymap,col=cl)

# search in your browser for "colors in R"

# Exercise: change the color ramp palette using different colors
cl <- colorRampPalette (c("lightpink", "plum3", "mistyrose2"))(100)

# Exercise: build a multiframe and plot the densitymap with two different color ramp palettes one beside the other
par(mfrow=c(1,2))

cln <- colorRampPalette(c("purple1", "orchid2", "palegreen3", "paleturquoise"))(100)
plot(densitymap, col=cln)

clg <- colorRampPalette(c("green4", "green3", "green2", "green1", "green"))(100)
plot(densitymap, col=clg)

dev.off()
