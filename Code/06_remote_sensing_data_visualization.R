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
# presentation "3_remote_sensing.pdf" and also "continuous_vs_discontinuous_monitoring":
# we use a passive sensor: a satellite recording the reflectance of object based on their external energy (the sun: sunlight passes the atmosphere, passes an object and comes back to the satellite); active sensors (laser, radar) are emicting a signal and receving back an output
# incident radiant flux = energy coming on top of the object. Part of this radiation is reflect (reflected radiant flux). The reflectance is an index, ranging from 0 to 1, of reflected radiation given a certain amount of incident radiation 
# example: a plant is reflecting the green colour, it means that - given the incident radiation of the green - most of that is reflected.
# Plants are absorbing the red light due to photosynthesis. They absorb all incident radiation (of the red light), so nothing is coming out -> the reflectance is 0.
# let's condier the green: of 1000 watt coming as green, 80 watt are reflected (which is 0.8 of reflectance).

# green data: around 560 nm of wavelength, the resolution is 10 meters (the pixel is 10 meters)
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=cl)

# red data: around 600 nm of wavelength
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=cl)

# NIR data (near infrared): around 840 nm of wavelngth. Rocchini did not put b5, b6, and b7 in the data of the package because of the resolution, that is 20 meters (it means that every single pixel is 1/4 of the previous one)
# why is it called near infrared? The infrared can be divided into 3 regions:
# 1) near infrared ("near" bc it's near to the visible part) 
# 2) the far part of infrared, called thermal, related to temperature-related sensors (but not measuring, but measuring the reflectance in the thermal infrared) (??) 
# 3) middle region, called middle infrared or short wave, between near infrared and thermal.
# let's import the NIR band:
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col=cl) # we can see that the amount of objects discriminated in this image is high, since the NIR is striclty related to vegetation. 

# plot the bands altogether
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# stacking images together
sentstack <- c(b2, b3, b4, b8) # we stack them by considering them as elements of the same arrey, so we use function c()
plot(sentstack, col=cl) # appare come plot ma è come se fossero sovrapposti, te li fa comunque vedere plottati, se scrivi su R sentstack ti dice in "sources" che ci sono

# now we want to plot one layer
dev.off() # we remove the mfrowù
plot(sentstack[[1]], col=cl) # 1 because the first band we put was the number 2 (b2)
plot(sentstack[[4]], col=cl) # 4 is the b8

# Plot the images with different color ramp palettes
# the original color ramp palette of b2 was from blue to yellow, the best legend for daltonic people
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
# we can see that the NIR band has higher disciminating power with respect to the others, it is gathering a lot of information. That's why most of the papers related to ecology are using the NIR.

# Moreover, there is the possibility to mount all bands together to form new colours.
# So rather than plotting single images like we've done before, we can combine them together in a scheme called "RGB" (= red, green and blue), a scheme that every single device uses to show colours. The overlapping of these colors is composing all others colours.
im.plotRGB(sentstack, r=3, g=2, b=1) # we have 3 components (red, green, blue), for each of these components we can put the corrisponding band. For ex., for the red component, in our stack the third layer was the red. For the green, the layer was 2. For the blue, the layer was 1.
# This will lead to "natural color imagery" = how our eyes see landscapes

# now we want to use near infrared. RGB has 3 components but we have 4 bands. What we can do is moving 3 to 4, 2 to 3 and 1 to 2.
# instead of layer 3, we are using layer 4 (NIR); the number 3 (red); the number 2 (green).
# This is called "false colour", since we are using the NIR (bc it's ultra-reflected by plants)

im.plotRGB(sentstack, r = 4, g = 3, b = 2) # false color image -> all vegetation becomes red because it's reflecting. If we use the visible it's showing us few infos, using the other colors of the infra-red we are adding more information from another part of the spectrum.
# since we've put the NIR on top of the red component of the RGB, all the vegetation will become red, since it's reflected. 

day2

library(terra)
terra 1.7.83
library(imageRy)
im.list()

# recall b2, b3, b4, b8

b2 <- im.import("sentinel.dolomites.b2.tif")
b3 <- im.import("sentinel.dolomites.b3.tif")
b4 <- im.import("sentinel.dolomites.b4.tif")
b8 <- im.import("sentinel.dolomites.b8.tif")
sentstack <- c(b2,b3,b4,b8)
plot(sentstack)

# why we want to stack? vegetation is now represented by infrared beause vegetation reflects a lot in NIR. it's common to put NIR on top of red band of RGB
im.plotRGB(sentstack, r=3, g=2, b=1) # RGB has 3 components but we have 4 bans. facciamo scorrere i nueri we get false colorus image so to add addittional information that our eyes cannot see 
im.plotRGB(sentstack, r=3, g=3, b=2)
im.plotRGB(sentstack, r=3, g=4, b=2) # let's try to put NIR on top of green band obtaining  another false colour image 

# a NIR on top of blue band

im.plotRGB(sentstack, r=3, g=2, b=4)
