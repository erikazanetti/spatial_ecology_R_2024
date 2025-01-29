# Satellite images of mangroves are useful for:
# Ability to automatically identify conditions of mangroves that are healthy, disturbed, naturally recovering, or declining.
# Ability to predict mangrove resilience, or capability to recover to pre-disturbance conditions.
# Mangroves in Florida are under increased stress due to more intense and frequent hurricanes.


# Install required packages if not already installed
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
setwd("C:/Users/Erika Zanetti/OneDrive - Alma Mater Studiorum Università di Bologna/spatial ecology in r/Browser_images 2017") # da cambiare perché devo mettere tutte immagini in una sola cartella

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
plot(m2017, main="True color 2017")
plot(m2017f, main="False color 2017")
plot(m2018, main="True color 2018")
plot(m2018f, "False color 2018")

dev.off()

# Assigning red, green and blue bands of 2017's true color's image and 2017's false color's NIR band to their relative objects
rm2017 <- m2017[[1]]  # Red band
gm2017 <- m2017[[2]] # Green band
bm2017 <- m2017[[3]] # Blue band 
nirm2017 <- m2017f[[1]] # NIR band
bandsm2017 <- c(rm2017, gm2017, bm2017, nirm2017) # Uniting all the bands
bandsm2017c <- im.classify(bandsm2017,num_clusters=5) # Directly classifying the image with all the bands
plot(bandsm2017c)

# Doing the same thing for 2018
rm2018 <- m2018[[1]]
gm2018 <- m2018[[2]] 
bm2018 <- m2018[[3]] 
nirm2018 <- m2018f[[1]]
bandsm2018 <- c(rm2018, gm2018, bm2018, nirm2018)
bandsm2018c <- im.classify(bandsm2018,num_clusters=5)
plot(bandsm2018c)

cl <- colorRampPalette(c("#21908CFF","#440154FF","#5DC863FF","#3B528BFF","#FDE725FF"))(100) 
par(mfrow=c(1,2)) 
plot(bandsm2017c, col=cl, main="Classified Image 2017") 
plot(bandsm2018c, col=cl, main="Classified Image 2018")




# Since im.classify() assigns class numbers randomly, I need to manually map the class numbers to meaningful names based on their frequency or your domain knowledge.
class_names <- c("Cloudes", "Ocean", "Water bodies", "Dense veg.", "Less dense veg.")
class_colors <- c("Clouds" = "#21908CFF",    # Azzurro per le nuvole
                  "Ocean" = "#440154FF",  # Viola per l'area disturbata
                  "Water bodies" = "#5DC863FF",    # Verde per l'area sana
                  "Dense veg." = "#3B528BFF",      # Blu per l'oceano
                  "Less dense veg." = "#FDE725FF" # Giallo per i corpi idrici
)

# da cambiare perché sono brutti
par(mfrow=c(1,2))
plot(bandsm2017c, col=class_colors, main="Classified Image 2017")
plot(bandsm2018c, col=class_colors, main="Classified Image 2018")

# Add a legend to make things clear  DA SISTEMARE IL POSIZIONAMENTO DELLA LEGENDA
legend("topright", 
        legend = class_names,     # Class names (instead of numbers)
        fill = class_colors,      # Colors corresponding to classes
        title = "Classes",        # Title for the legend
        cex = 0.6,                # Adjust size of the legend text
        xpd = TRUE,               # Allow the legend to go outside the plot area, if it's not what you want remove this line
        inset = c(0, 0.08))       # Adjust position of the legend

dev.off()


cl <- colorRampPalette(c("#21908CFF","#440154FF","#5DC863FF","#3B528BFF","#FDE725FF"))(100)



# Frequencies
f17 <- freq(bandsm2017c)
tot17 <- ncell(bandsm2017c)

f18 <- freq(bandsm2018c)
tot18 <- ncell(bandsm2018c)

prop17 = f17/tot17
perc17 = prop17*100
prop18 = f18/tot18
perc18 = prop18*100


