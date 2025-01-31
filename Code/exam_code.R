# R PROJECT FOCUSING ON TEMPORAL ANALYSIS OF DEFORESTATION IN AN AREA IN RONDONIA

about 4100 km^2

# Install required packages if not already installed
install.packages("terra") # For handling raster data (e.g., satellite images)
install.packages("ggplot2") # For creating graphs
install.packages("patchwork") # For composing graphs in a single graph
install.packages("viridis")
install.packages("devtools") # For managing R packages

# Load the packages
library(terra)
library(ggplot2)
library(patchwork)
library(viridis)
library(devtools)

# Note: The devtools package, is used here to install the imageRy package from GitHub
install_github("ducciorocchini/imageRy")
library(imageRy) # Loading the package

# Set the working directory
setwd("C:/Users/Erika Zanetti/OneDrive - Alma Mater Studiorum Università di Bologna/spatial ecology in r/nuovo proj/2017")

# Import images while assigning them to an object
r17 <- rast("2017-06-28-00_00_2017-06-28-23_59_Sentinel-2_L2A_True_color.jpg") # True color (bands R, G and B)
r17f <- rast("2017-06-28-00_00_2017-06-28-23_59_Sentinel-2_L2A_False_color.jpg") # False color (bands NIR, G and B)
r23 <- rast("2023-06-27-00_00_2023-06-27-23_59_Sentinel-2_L2A_True_color.jpg") # True color (bands R, G and B)
r23f <- rast("2023-06-27-00_00_2023-06-27-23_59_Sentinel-2_L2A_False_color.jpg") # False color (bands NIR, G and B)

# Visualize the images altogether in a multiframe
par(mfrow=c(2,2))
plot(r17, main="True color 2017")
plot(r17f, main="False color 2017")
plot(r23, main="True color 2023")
plot(r23f, main="False color 2023")

dev.off()

# Assigning red, green and blue bands of 2017's true color's image and 2017's false color's NIR band to their relative objects
r17r <- r17[[1]]  # Red band
r17g <- r17[[2]] # Green band
r17b <- r17[[3]] # Blue band 
r17nir <- r17f[[1]] # NIR band
bandsr17 <- c(r17r, r17g, r17b, r17nir) # Uniting all the bands
bandsr17c <- im.classify(bandsr17,num_clusters=2) # Directly classifying the image with all the bands
plot(bandsr17c)

# Doing the same thing for 2023
r23r <- r23[[1]] 
r23g <- r23[[2]]
r23b <- r23[[3]] 
r23nir <- r23f[[1]]
bandsr23 <- c(r23r, r23g, r23b, r23nir)
bandsr23c <- im.classify(bandsr23,num_clusters=2)
plot(bandsr23c)

# Plot the classified images of 2017 and 2023 using colors from the Viridis palette
clv <- viridis(100)
par(mfrow=c(1,2)) 
plot(bandsr17c, col=cl)
plot(bandsr23c, col=cl)

dev.off()

# Calculate the frequency of each class (cleared fores and original forest) for both 2017 and 2023
f17 <- freq(bandsr17c)
tot17 <- ncell(bandsr17c)

f23 <- freq(bandsr23c)
tot23 <- ncell(bandsr23c)

# Calculate the percentage for each class in both years
perc17 = f17*100/tot17
# cleared forest = 41
# original forest = 59
perc23 = f23*100/tot23
# cleared forest = 56
# original forest = 44

forest_loss_percentage <- perc17 - perc23 # 3% of forest loss

# Create a data frame to represent the classes and their corresponding percentages for 2017 and 2023
year_2017 <- c(41,59)
year_2023 <- c(56,44)
classes <- c("Cleared", "Original")
data <- data.frame(classes,year_2017,year_2023)

# Plot a graph for year 2017 and then for year 2023, showing percentages for "Cleared" and "Original" classes
g1 <- ggplot(data, aes(x=classes, y=year_2017, fill=classes)) + geom_bar(stat="identity") + scale_fill_viridis_d(option = "D") + ylim(c(0, 100)) + labs(title = "Forest Classification in 2017", y = "Percentage", x = "Classes")
g2 <- ggplot(data, aes(x=classes, y=year_2023, fill=classes)) + geom_bar(stat="identity") +  scale_fill_viridis_d(option = "D") + ylim(c(0, 100)) + labs(title = "Forest Classification in 2023", y = "Percentage", x = "Classes")
# aes() -> to define the aethetics of the plot
# x=classes -> for the x-axis will to display the classes ("Cleared" and "Original")
# y=year_2017 -> for the y-axis to represent the values from the relativev year column in the dataset
# fill=classes -> so the bars will be filled with colors based on the classes variable
# geom_bar(stat="identity") -> geom_bar() is used to create a bar graph and stat=identity specifies the data are used just us they are
# scale_fill_viridis_d(option = "D") -> scale_fill_viridis_d() applies Viridis palette when your variable is discrete (i.e., categorical data), option ="D" is the default color palette
# ylim(c(0, 100)) -> sets the limits for the y axis
# labs() -> to customize the labels of the plot

# Combine the two graphs (2017 and 2023)
g1 + g2

# Calculate DVI and NDVI
cl <- colorRampPalette(c("black","white","red"))(100)
dvi17 = bandsr17[[4]] - bandsr17[[1]]
dvi23 = bandsr23[[4]] - bandsr23[[1]]
par(mfrow=c(1,2))
plot(dvi17, col=cl)
plot(dvi23, col=cl)

ndvi17 = dvi17 / (bandsr17[[4]] + bandsr17[[1]])
ndvi23 = dvi23 / (bandsr23[[4]] + bandsr23[[1]])
par(mfrow=c(2,2))
plot(ndvi17,col=cl)
plot(ndvi17,col=clv)
plot(ndvi23,col=cl)
plot(ndvi23,col=clv)

dev.off()

# NDVI difference
difNDVI = ndvi17 - ndvi23
par(mfrow=c(1,2))
plot(difNDVI,col=cl) # red = vegetation got better ; black = vegetation decreased
plot(difNDVI,col=clv)

par(mfrow=c(1,2))
hist17 <- hist(ndvi17,main="NDVI 2017", xlab = "NDVI", nclass=20, freq=F, ylim=c(0,5), col=viridis(5))
hist23 <- hist(ndvi23,main="NDVI 2023", xlab = "NDVI", nclass=20, freq=F, ylim=c(0,5), col=viridis(5))

dev.off()

# Calculate variability
pca17 <- im.pca(bandsr17)
tot17 <- sum(36.612812, 31.971524, 4.963559, 3.076220)
36.612812*100/tot17 # 47.78236 % of variability explained by the first axis
31.971524*100/tot17 # 41.72515 % of variability explained by the second axis
4.963559*100/tot17 # 6.477803 % of probability explained by the third axis
3.076220*100/tot17 # 4.014689 % of probability explained by the fourth axis
pc17comb <- pca17[[1]] + pca17[[2]] # PC1 and PC2 together explain over 89% of the variability, so we can combine them
pcsd17 <- focal(pc17comb, matrix(1/9, 3, 3), fun=sd)

pca23 <- im.pca(bandsr23)
tot23 <- sum(36.612812, 31.971524, 4.963559, 3.076220)
44.297913*100/tot23 # 57.81197 % of variability explained by the first axis
20.766979*100/tot23 # 27.10241 % of variability explained by the second axis
4.477552*100/tot23 # 5.843529 % of probability explained by the third axis
3.009718*100/tot23 # 3.927899 % of probability explained by the fourth axis
pc23comb <- pca23[[1]] + pca23[[2]] # PC! and PC2 together explain over 85% of the variability, so we can combine them
pcsd23 <- focal(pc23comb, matrix(1/9, 3, 3), fun=sd)

par(mfrow=c(1,2))
plot(pcsd17, col=clv)
plot(pcsd23, col=clv)




# NIR (Near Infrared) is indeed a very useful band, especially for vegetation analysis, but it contains only one aspect of the information in the image. By using PCA, you're combining the NIR band with other bands (like Red, Green, Blue, etc.) into a single component (PC1), which might capture more comprehensive information about the scene.


# Conclusions
# Comparing these values, we can infer that your area might not be as severely affected as the overall state of Rondônia
# Rondônia's average annual forest loss (2001-2019) = 1.02% per year. My area’s annual forest loss (2018-2023) = 0.6% per year.
# my area has experienced less deforestation per year compared to the broader trends observed in Rondônia from 2001 to 2019. However, it’s still important to understand the larger dynamics, as deforestation trends can vary significantly within smaller areas depending on the local causes (e.g., land use, agriculture, etc.).
# local variations in deforestation rates occur
