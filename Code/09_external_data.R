# External data

# until now we have used data that were already inside packages
# now we want to import data from outside R

# go to site earth observatory, home, search for image, scotland, click on scotland and download (jpeg), save it (right click)
# in the code we are explaining to R that we are going to use the photo, setting the working folder
# right click on the file where you put it, see properties, copy the path and paste it in the code, the path we see in the properties has back slash "\", the real path is with "//" and we have to change all the slashes and remember the quotes ""

library(terra)

# set the working directory based on your path:
# setwd("yourpath")
# Windows users: C:\\path\Downloads -> C://path/Downloads
# My own:
setwd("C:/Users/Erika Zanetti/Downloads")
getwd() # getwd = getworkingdirectory, to see if i gave the right directory
scotland <- rast("scotland_outerhebrides_oli_20240918_lrg.jpg")  # rast() is the function to import the data in terra
# a warning will say unkown extent because the file has not been georeferenced, but there is no problem

plotRGB(scotland, r=1, g=2, b=3)
plot(scotland) # same of plotRGB to see the picture on R

# Exercise: Download the second image from the same site and import it in R
setwd("C:/Users/Erika Zanetti/Downloads")
lakegarda <- rast("ISS053-E-136542_lrg.jpg")
plotRGB(lakegarda, r=1, g=2, b=3)
