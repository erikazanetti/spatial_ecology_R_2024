# Install and load the required package for point pattern analysis
# We use the spatstat package to deal with population ecology
install.packages("spatstat")  
library(spatstat)  

# Using the 'bei' dataset
bei  # Displays the dataset
plot(bei)  # Basic plot of the points in 'bei'
plot(bei, pch = 19)  # Change point symbols
plot(bei, pch = 19, cex = 0.5)  # Adjust point size

# Additional datasets
bei.extra  # Contains additional data such as elevation
plot(bei.extra)  # Displays two images: elevation and gradient

# Extracting elevation data, first method
elevation <- bei.extra$elev  # Extract elevation data
plot(elevation)  # Plot only elevation

# Extracting elevation data, second method
elevation <- bei.extra[[1]]

# Create a density map from points
densitymap <- density(bei)  
plot(densitymap)
points(bei, col = "green")

# Plotting maps side by side
par(mfrow = c(1,2))  
plot(elevation)
plot(densitymap)

# Plotting maps stacked (one on top of the other)
par(mfrow = c(2,1))  
plot(elevation)  
plot(densitymap)  

dev.off()  # Reset plotting settings

# Changing colors of the density map
cl <- colorRampPalette(c("red", "orange", "yellow"))(3)  # 3-color gradient
plot(densitymap, col = cl)  

# Increasing gradient levels
cl <- colorRampPalette(c("red", "orange", "yellow"))(10)  # More refined gradient
plot(densitymap, col = cl)  

cl <- colorRampPalette(c("red", "orange", "yellow"))(100)  # High-gradient smooth transition
plot(densitymap, col = cl)  

# Search online for "colors in R" for more customization options

# Exercise: change the color ramp palette using different colors
cl <- colorRampPalette(c("lightpink", "plum3", "mistyrose2"))(100)  

# Exercise: build a multiframe and plot the densitymap with two different color ramp palettes one beside the other
par(mfrow = c(1,2))  
cln <- colorRampPalette(c("purple1", "orchid2", "palegreen3", "paleturquoise"))(100)  
plot(densitymap, col = cln)  

clg <- colorRampPalette(c("green4", "green3", "green2", "green1", "green"))(100)  
plot(densitymap, col = clg)  

dev.off()
