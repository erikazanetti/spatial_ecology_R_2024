# Spectral indices

library(imageRy)
library(terra)

# Listing the data
im.list()

# Importing data
# we want to import the image "matogrosso_ast_2006209_lrg.jpg", that in this case is directly a stack of different bands
# so we are not importing single layers/bands like before, but we are importing direclty a stack of different bands
im.import("matogrosso_ast_2006209_lrg.jpg") # "ast" is ASTER, another satellite with lower resolution (wider dimension of pixels, > 10 meters) mounted on top of a satellite called TERRA (at NASA)

# let's give it a name
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
m2006 # in section name we can see there are 3 bands (matogrosso_lrg1/2/3)
# what are these bands? This is an image coming out from another source of NASA data called Earth Observatory.
# This image has been moved to Earth Observatory website to Visible Earth website.
# here https://visibleearth.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil we can see the (deforestation) history of this image.
# They directly provide a false colour, in which the first band was the NIR. band 1 = NIR, band 2 = red, band 3 = green . (?)HOW DO WE KNOW THAT BAND 1 IS NIR, 2 IS RED AND 3 IS GREEN??

# we can do RGB of matogrosso image
im.plotRGB(m2006, r=1, g=2, b=3) # we can choose the band we want to see, even if we write here g=3 and b=2 nothing changes, the important thing is that r=1

# how to see a specific band
plot(m2006[[2]])
plot(m2006[[3]])

# back to RGB
im.plotRGB(m2006, r=1, g=2, b=3) # we can see what happens in this area. In 1992 this was completely covered by forest. The humans started to open up this area. This is the current situation of the area (zooming and seeing rectangular shapes is because of human impacts)
# once you put NIR on top of blue everything becomes yellow (it's all the bare soil). The water is yellowish and not black bc it is polluted.

im.plotRGB(m2006, r=3, g=2, b=1) # let's put the NiR on top of the green
im.plotRGB(m2006, r=3, g=1, b=2) # vegetation becomes green, while bare soil becomes pink

# Ancient data
# let's import image from 1992 to understand situation before intervention of humans 
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg") # "l5" means landsat file, the most ancient commercial satellite from NASA

# plot the data using NIR on top of the red component
im.plotRGB(m1992, r=1, g=2, b=3)

# build a multiframe with 1992 and 2006 images
par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

# exercise: make a multiframe with 6 images in pairs with NIR on the same component
# first row: m1992 and m2006 with r=1 (NIR on top of red)
# second row: m1992 and m2006 with g=1 (NIR on top of green)
# third row: m1992 and m2006 with b=1 (NIR on top of blue)
# 3 rows per 2 columns -> the important point as requested from the exercise is where you put the number 1 

par(mfrow=c(3,2))
im.plotRGB(m1992, r=1,g=2, b=3)
im.plotRGB(m2006, r=1,g=2, b=3)

im.plotRGB(m1992, r=2,g=1, b=3)
im.plotRGB(m2006, r=2,g=1, b=3)

im.plotRGB(m1992, r=2,g=3, b=1)
im.plotRGB(m2006, r=2,g=3, b=1)

# VEGETATION INDICES: SPECTRAL SIGNATURE, DVI
# Spectral signature (presentation "remote sensing"): it is a graph of how vegetation (healthy or stressed vegetation) reacts to light. 
# In case of healthy plants: absorbs blue and red, reflects green, reflects a lot of NIR.
# When we have several bands instead of just 4, we will see that there are pics different from one species to the other: each species reflects in a different manner (that's why it's called spetral signature, like a fingerprint).
# In case of a healthy plant: in the NIR it's reflecting a lot, let's say 100. In  red 10. We can mount this information to make a single index, called DVI (different vegetation index). 
# DVI = NIR - red = 100 - 10 = 90 (DVI of the plant).
# Imagine the plant is about to die, the phtosynthesis is going to stop (chloroplasts don't work anymore and don't absorb light), so the plant will not absorb anymore blue or red and reflectance will be higher.
# So now NIR = 80, red = 20 -> DVI = NIR - red = 80 - 20 = 60.
# So once the plant suffers (ex. for climate change), we will see a decrease in DVI.

# With two images you can calculate different DVIs
# We calculate the DVI of 1992 and DVI of 2006

# DVI of 1992
dvi1992 = m1992[[1]] - m1992[[2]] # the 1 is the NIR and the 2 is the red (band 1 = NIR, band 2 = red, band 3 = green). So we do NIR - red (this is called map algebra)  
cl <- colorRampPalette(c("darkblue","yellow","red","black")) (100)
plot(dvi1992, col=cl) # we see the dvi in 1992

# DVI of 2006
dvi2006=m2006[[1]]-m2006[[2]]
plot(dvi2006, col=cl)

# Now plot altogether in a multiframe
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# VEGETATION INDICES: NDVI
# So we saw the capability of satellite image to calculate vegetation indices and swa the difference between two images in time. 
# But problem: one image ranging from 0 to 100 (maximum DVI would be NIR - red = 100 - 0 = 100) and one image ranging from 0 to 1000 (maximum DVI would be NIR - red = 1000 - 0 = 1000).
# For this reason there is another index, NDVI = normalize different vegetation index. Same of DVI (NIR - red ) but also in denominator puts NIR + red.
# ex: 100 - 0 / 100 + 0 = 1 ; 1000 - 0 / 1000 + 0 = 1.
# With NDVI you can compare every image from different ranges.
# It's always better to use NDVI instead on DVI, but if you have images from the same range you can use DVI.

# Calcualte NDVI 1992 and 2006
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# VIRIDIS
# you can use viridis for colorblind people
