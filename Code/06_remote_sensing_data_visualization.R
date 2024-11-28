# REMOTE SENSING: a sensor takes a photo from remote reception
# spectral species: every species over the planet can be recognized thanks to the amount of light reflected
# we transform the information from numbers (reflectances, how much an object reflects light) into colours

# reflectance
# the radiation we see is quite narrow (visible part of the spectrum), there are additional wave lenghts that might use it. different animals can use different waves lenght
# we take an instrument (called APEX), where there are several sensors that can sense different wavelenghts. you mount APEX on top of an aircraft, satellite...
# each sensor is specific to each wavelenght, so we have levels with different wave lenghts
# we can create an image using the different layers

# Code for visualizing remote sensing data

# install.packages("devtools")
# install.packages("terra")

library(devtools)

# installing the imageRy package

# install_github("ducciorocchini/imageRy")

library(imageRy)
library(terra)

im.list() # shows a list of all the data in the function
# in the data we find sentinel.dolomites.b2.tif, that is data in the package provided for sentinels data of the dolomites. sentinel datas are coming from programm like Copernicus that provides data from all planet
# inside every instrument (like sentinel-2 satellite) there may be several sensors and each sensor is recording the landdscape in a certain wavelenght (red, green, blue)
# this wavelenghts are recorded as layers called bands. so bands are how to see the landscape in certain way -> Sentinel-2 bands is the name of the satellite
# among the data we have sentinel.dolomites.b2 (b2 = band 2 -> the blue -> we're working at wavelenght 490 nm)

# importing data
b2 <- im.import("sentinel.dolomites.b2.tif") # the image is made from sensors recording the blue and all the objects reflecting the blue are in this image with this colorRampPalette in yellow and green and the objects absorbing the blue light are in dark blue

# let's change the colorRampPalette
cl <- colorRampPalette(c("black", "grey", "light grey")) (100)
plot(b2, col=cl)

# what is reflectance: how much a signal is reflected and also absorbed at the same moment
# presentation continuous_vs_discontinuous_monitoring:
# we use a passive sensor: a satellite recording the reflectance of object based on their external energy (the sun: sunlight passes the atmosphere, passes an object and comes back to the satellite); active sensors (laser, radar) are emicting a signal and receving back an output
# incident radiant flux = energy coming on top of the object. Part of this radiation is reflect (reflected radiant flux). The reflectance is an index, ranging from 0 to 1, of reflected radiation given a certain amount of incident radiation 

# green data
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=cl)

# red data
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=cl)

# NIR data (near infrared)
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col=cl)

# plot the bands altogether
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# stacking images together
sent <- c(b2, b3, b4, b8)
plot(sent, col=cl)

dev.off()
plot(sent[[4]], col=cl)

# Plot the images with different color ramp palettes
clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)

par(mfrow=c(2,2))
plot(b2, col=clb)

# new color ramp palette for the green band
clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

# new color ramp palette for the red wavelength
clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

# new color ramp palette for the NIR wavelength
cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)
