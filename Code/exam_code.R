# Step 1 : Install required packages if not already installed
install.packages("terra") # For handling raster data (e.g., satellite images)

# Load the packages
library(terra) 

# Set the working directory
setwd("C:/Users/Erika Zanetti/OneDrive/Desktop/spatial ecology in r/Browser_images 2017") # da cambiare perché devo mettere tutte immagini in una sola cartella

# Import images while assigning them to an object
m2017 <- rast("2017-01-26-00_00_2017-01-26-23_59_Sentinel-2_L2A_True_color.jpg") # True colors (bands R, G and B)
m2017f <- rast("2017-01-26-00_00_2017-01-26-23_59_Sentinel-2_L2A_False_color.jpg") # False colors (bands NIR, G and B)
m2018 <- rast("2018-01-31-00_00_2018-01-31-23_59_Sentinel-2_L2A_True_color.jpg") # True colors (bands R, G and B)
m2018f <- rast("2018-01-31-00_00_2018-01-31-23_59_Sentinel-2_L2A_False_color.jpg") # False colors (bands NIR, G and B)

# Check if the images are imported correctly
plot(m2017)
plot(m2017f)
plot(m2018)
plot(m2018f)

# Visualize the images altogether in a multiframe
par(mfrow=c(2,2))
plot(m2017)
plot(m2017f)
plot(m2018)
plot(m2018f)

dev.off()

