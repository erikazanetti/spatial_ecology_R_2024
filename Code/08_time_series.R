# Time series analysis in R

# We are going to analyze data coming out from Sentinel (satellite of the Copernicus program)

library(terra)
library(imageRy)

im.list() # is the extension for listing all the available files

# Let's import a dataset
EN01 <- im.import("EN_01.png")
# EN = european nitrogen
# let's import the first one EN
# the image is representing the amount of nitrogen from data in January 2020
EN01 # let's see how it is composed
# it has 3 layers (1,2,3)
# you can see parts of Europe and related concentration of nitrogen (due to human activities like industries and traffic)

# Let's import EN13 (from March 2020)
EN13 <- im.import("EN_13.png")
# in this case it's completely different: big decrease in nitrogen dueto the stop of human activities

# Difference between EN01 (January 2020) and EN13 (March 2020)
difEN = EN01[[1]] - EN13[[1]]
plot(difEN)


# Plot the temperatures directly related to icemelt
# import all data related to Greenland by just writing "greenland" and not writing all data names one by one
gr <- im.import("greenland")

gr # information about images

plot(gr[[1]]) # to plot one single layer, number from 1 to 4 depending which one you want to plot

# Plot in a multiframe the first and last elements of gr
par(mfrow=(c(1,2)))
plot(gr[[1]])
plot(gr[[4]])
# low temperatures in 2000 almost everywhere, while in 2025 low temperatures are only present in a small amount at the center

# Difference in temperature 
difgr = gr[[1]] - gr[[4]]
plot(difgr)

# Compose a RGB image with the years of Greenland 
im.plotRGB(gr, r=1, g=2, b=4) # 1 is gr of 2000, 2 is gr of 2005, 4 is the gr of 2015
# all the pixels which will become red will have the higher value of temperature in 2000, all the pixels which will become green will have a higher value in 2005, all the pixels which will become blue will have have higher value in 2015 
# most of the area is blue

# Another way to show these variations: ridge line plots 
# They are showing the variation of frequencies of different datasets given different classes (in our case, the classes are the years, so it shows the variation in time)
im.ridgeline(gr, scale=2, option="A")

# Take-home message: 
# we can have a wide amount of different data and 1) use them altogether or 2) use two data and make the difference between these two data
