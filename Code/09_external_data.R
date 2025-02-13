# Importing External Data into R

# Until now, we have used data from R packages.
# Now we will import external data, such as images downloaded from Earth Observatory.

library(terra)

# Set the working directory (modify based on your file location)
# Windows users: Change backslashes to double forward slashes (C:\path\Downloads -> C://path/Downloads)
setwd("C:/Users/Erika Zanetti/Downloads")
getwd()  # Verify the correct working directory

# Import the Scotland image (JPEG file)
scotland <- rast("scotland_outerhebrides_oli_20240918_lrg.jpg")  # Import raster data

# Warning: Unknown extent message appears because the file lacks georeferencing, but it does not affect visualization

# Plot the RGB composite of the Scotland image
plotRGB(scotland, r=1, g=2, b=3)

# Alternative way to visualize the image
plot(scotland)  # Displays the image similarly to plotRGB()

# Exercise: Download another image from the same site and import it
setwd("C:/Users/Erika Zanetti/Downloads")  # Ensure correct directory
lakegarda <- rast("ISS053-E-136542_lrg.jpg")  # Import the second image

# Plot the RGB composite of the Lake Garda image
plotRGB(lakegarda, r=1, g=2, b=3)
