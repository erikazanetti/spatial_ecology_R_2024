# Measuring Variability Using Standard Deviation in Remote Sensing

# Higher variability -> Higher system complexity -> Higher biodiversity (Ecologists)
# Higher texture -> Higher morphological complexity (Geologists)

library(imageRy)
library(terra)

# List available datasets
im.list()

# Import Sentinel satellite image
sent <- im.import("sentinel.png")  # Contains three bands

# Band Information:
# - Band 1 = NIR (Near Infrared)
# - Band 2 = Red
# - Band 3 = Green

# Visualize RGB composite
im.plotRGB(sent, r=1, g=2, b=3)  # True color composite
im.plotRGB(sent, r=2, g=1, b=3)  # Altered band arrangement

# Measuring standard deviation using a moving window approach
nir <- sent[[1]]  # Select NIR band for analysis

# Applying a 3x3 moving window standard deviation filter
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)  # Highlights high morphological variability regions

# Exercise: Apply a 7x7 moving window standard deviation filter
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7)  # Larger window smooths fine details

# Compare results of 3x3 and 7x7 moving window analyses
par(mfrow=c(1,2))
plot(sd3)
plot(sd7)

