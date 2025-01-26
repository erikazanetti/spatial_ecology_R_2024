# Satellite images of mangroves are useful for:
# Ability to automatically identify conditions of mangroves that are healthy, disturbed, naturally recovering, or declining.
# Ability to predict mangrove resilience, or capability to recover to pre-disturbance conditions.
# Mangroves in Florida are under increased stress due to more intense and frequent hurricanes.



# Step 1 : Install required packages if not already installed
install.packages("terra") # For handling raster data (e.g., satellite images)
install.packages("devtools") # For managing R packages
install.packages("viridis")

# Load the packages
library(terra)
library(devtools)
library(viridis)

# Install the imageRy package from GitHub through
install_github("ducciorocchini/imageRy")

# Load the imageRy package
library(imageRy)

# Set the working directory
setwd("C:/Users/Erika Zanetti/OneDrive/Desktop/spatial ecology in r/Browser_images 2017") # da cambiare perché devo mettere tutte immagini in una sola cartella

# Import images while assigning them to an object
m2017 <- rast("2017-01-26-00_00_2017-01-26-23_59_Sentinel-2_L2A_True_color.jpg") # True color (bands R, G and B)
m2017f <- rast("2017-01-26-00_00_2017-01-26-23_59_Sentinel-2_L2A_False_color.jpg") # False color (bands NIR, G and B)
m2018 <- rast("2018-01-31-00_00_2018-01-31-23_59_Sentinel-2_L2A_True_color.jpg") # True color (bands R, G and B)
m2018f <- rast("2018-01-31-00_00_2018-01-31-23_59_Sentinel-2_L2A_False_color.jpg") # False color (bands NIR, G and B)

# Check if the images are imported correctly
plot(m2017)
plot(m2017f)
plot(m2018)
plot(m2018f)

# Visualize the images altogether in a multiframe
par(mfrow=c(2,2))
plot(m2017)
title("True color 2017")
plot(m2017f)
title("False color 2017")
plot(m2018)
title("True color 2018")
plot(m2018f)
title("False color 2018")

dev.off()

# Assigning red, green and blue bands of 2017's true color's image and 2017's false color's NIR band to their relative objects
r2017 <- m2017[[1]]  # Red band
g2017 <- m2017[[2]] # Green band
b2017 <- m2017[[3]] # Blue band 
nir2017 <- m2017f[[1]] # NIR band
bands2017 <- c(r2017, g2017, b2017, nir2017)

# Doing the same thing for 2018
r2018 <- m2018[[1]]
g2018 <- m2018[[2]] 
b2018 <- m2018[[3]] 
nir2018 <- m2018f[[1]]

#
m2017c <- im.classify(m2017,num_clusters=6)
bands2017c <- im.classify(bands2017,num_clusters=6)

# Since im.classify() assigns class numbers randomly, I need to manually map the class numbers to meaningful names based on their frequency or your domain knowledge.
class_names <- c("Cloudes", "Disturbed", "Healthy", "Water bodies", "Ocean", "Bo")
class_colors <- c("gray", "green", "blue", "lightgreen", "darkblue", "yellow") # da cambiare perché sono brutti
plot(bands2017c, col=class_colors, main="Classified Image")

# Add a legend to make things clear
legend("topright", 
        legend = class_names,     # Class names (instead of numbers)
        fill = class_colors,      # Colors corresponding to classes
        title = "Classes",        # Title for the legend
        cex = 0.6,                # Adjust size of the legend text
        xpd = TRUE,               # Allow the legend to go outside the plot area, if it's not what you want remove this line
        inset = c(-0.1, 0.08))    # Adjust position of the legend
