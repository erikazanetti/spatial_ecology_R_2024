# time series analysis in R

library(terra)
library(imageRy)

# im. is the extension for …

EN01 <- im.import("EN_01.png")
# EN = european nitrogen
# let's import the first one EN

# the image is representing the amount of nitrogen from data in january 2020
# non so perché vedo l'immagine ribaltata

EN01 # let's see how it is composed
# it has 3 layers (1,2,3)

EN13 <- im.import("EN_13.png")

# let's see the difference between EN01 (January 2020) and EN13 (March 2020)
difEN = EN01[[1]] - EN13[[1]]
plot(difEN)

# plot the temperatures directly related to icemelt
# import all data related to Greenland just writing Greenland and not writng all data names one by one
gr <- im.import("greenland")

gr # information about images

plot(gr[[1]]) # to plot one single layer, number from 1 to 4 depending which one you want to plot

# Exercise: plot in a multiframe the first and last elements of gr
par(mfrow=(c(1,2)))
plot(gr[[1]])
plot(gr[[4]])
# low temperatures 2000 almost everywhere, while in 2025 low temperatures are only present in a small amount at the centre

# show the difference in temperature 
difgr = gr[[1]] - gr[[4]]
plot(difgr)

# Exercise: compose a RGB image with the years of Greenland 
im.plotRGB(gr, r=1, g=2, b=4) # gr: 2000, 2005, 2010, 2015
# ... .... min 35

# using ridge line plots which are showing variation of frequency in relation to classes (?)
im.ridgeline(gr, scale=2, option="A")

# take-home message: ....
