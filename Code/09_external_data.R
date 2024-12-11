# External data

library(terra)

# set the working directory based on your path:
# setwd("youtpath")
# Windows users: C:\\path\Downloads -> C://path/Downloads
# My own:
setwd("C:/Users/Erika Zanetti/Downloads")
getwd() # to see where the image is (?)
scotland <- rast("scotland_outerhebrides_oli_20240918_lrg.jpg")  # like in im.import()

plotRGB(scotland, r=1, g=2, b=3) # im-plotRGB # plot(scotland) is the same

# Exercise: Download the second image from the same site and import it in R
setwd("C:/Users/Erika Zanetti/Downloads")
lakegarda <- rast("ISS053-E-136542_lrg.jpg")
plotRGB(lakegarda, r=1, g=2, b=3)
