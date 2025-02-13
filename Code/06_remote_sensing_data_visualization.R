# Remote Sensing: Visualizing Satellite Data

# Take-home message: Using multiple spectral bands allows us to visualize additional information
# beyond what is visible to the human eye, improving satellite image interpretation.

# Theory:
# - Every species can be identified based on its spectral reflectance (amount of reflected light).
# - The visible spectrum is narrow, but remote sensing utilizes additional wavelengths.
# - Instruments like APEX contain multiple sensors capturing different wavelengths.
# - Each wavelength is recorded as a separate band, forming multi-layer images.

# Install and load required packages
install.packages("devtools")  
library(devtools)

# Installing and loading the imageRy package
# install_github("ducciorocchini/imageRy")
library(imageRy)
library(terra)

# List available datasets
im.list()  # Lists Sentinel satellite bands available in the package

# Import blue band (B2) data
b2 <- im.import("sentinel.dolomites.b2.tif")

# Modify color scale and plot
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(b2, col=cl)

# Green band (B3), ~560 nm
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=cl)

# Red band (B4), ~600 nm
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=cl)

# Near Infrared (NIR) band (B8), ~840 nm
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col=cl)  # NIR provides high vegetation discrimination

# Plot all bands together
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

dev.off()  # Reset plotting settings

# Stacking images together
sentstack <- c(b2, b3, b4, b8)
plot(sentstack, col=cl)

# Visualize individual bands from the stack
plot(sentstack[[1]], col=cl)  # B2 (blue)
plot(sentstack[[4]], col=cl)  # B8 (NIR)

# Assign different color scales per band
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
clg <- colorRampPalette(c("dark green", "green", "light green"))(100)
clr <- colorRampPalette(c("dark red", "red", "pink"))(100)
cln <- colorRampPalette(c("brown", "orange", "yellow"))(100)

par(mfrow=c(2,2))
plot(b2, col=clb)
plot(b3, col=clg)
plot(b4, col=clr)
plot(b8, col=cln)

dev.off()

# RGB image visualization
# Natural color image (true-color composite)
im.plotRGB(sentstack, r=3, g=2, b=1)

# False color image (NIR-enhanced)
im.plotRGB(sentstack, r=4, g=3, b=2)

# Alternative false color combinations
im.plotRGB(sentstack, r=3, g=4, b=2)  # Vegetation in green
im.plotRGB(sentstack, r=3, g=2, b=4)  # Vegetation in blue, bare soil/rocks in yellow
