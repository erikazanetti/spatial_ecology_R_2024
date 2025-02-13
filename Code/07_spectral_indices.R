# Spectral Indices Analysis

# Install and load required packages
library(imageRy)
library(terra)

# List available datasets
im.list()

# Import multispectral image stack
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")  # ASTER satellite image
m2006  # Contains three bands: NIR, Red, Green

# Visualizing the RGB composite image
im.plotRGB(m2006, r=1, g=2, b=3)

# View specific bands
plot(m2006[[2]])  # Red band
plot(m2006[[3]])  # Green band

# Experimenting with different RGB combinations
im.plotRGB(m2006, r=3, g=2, b=1)  # NIR on green
im.plotRGB(m2006, r=3, g=1, b=2)  # Vegetation in green, bare soil pink

# Import 1992 image to compare changes over time
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")  # Landsat 5 satellite image

# Visualizing 1992 RGB composite
im.plotRGB(m1992, r=1, g=2, b=3)

# Compare 1992 and 2006 images
par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

# Multiframe analysis with different NIR placements
par(mfrow=c(3,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m2006, r=2, g=1, b=3)
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)

# Vegetation Indices: Spectral Signature & DVI Calculation
# DVI (Difference Vegetation Index) = NIR - Red

dvi1992 <- m1992[[1]] - m1992[[2]]
dvi2006 <- m2006[[1]] - m2006[[2]]

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)

par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# Normalized Difference Vegetation Index (NDVI)
# NDVI = (NIR - Red) / (NIR + Red)

ndvi1992 <- dvi1992 / (m1992[[1]] + m1992[[2]])
ndvi2006 <- dvi2006 / (m2006[[1]] + m2006[[2]])

par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# Viridis color palette for accessibility
# Recommended for colorblind-friendly visualization
