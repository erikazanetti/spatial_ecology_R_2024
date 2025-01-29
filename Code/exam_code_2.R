setwd("C:/Users/Erika Zanetti/OneDrive - Alma Mater Studiorum Università di Bologna/spatial ecology in r/nuovo proj/2017")

# Import images while assigning them to an object
r17 <- rast("2017-06-28-00_00_2017-06-28-23_59_Sentinel-2_L2A_True_color.jpg") # True color (bands R, G and B)
r17f <- rast("2017-06-28-00_00_2017-06-28-23_59_Sentinel-2_L2A_False_color.jpg") # False color (bands NIR, G and B)
setwd("C:/Users/Erika Zanetti/OneDrive - Alma Mater Studiorum Università di Bologna/spatial ecology in r/nuovo proj/2023")
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

# Doing the same thing for 2018
r23r <- r23[[1]]  # Red band
r23g <- r23[[2]] # Green band
r23b <- r23[[3]] # Blue band 
r23nir <- r23f[[1]] # NIR band
bandsr23 <- c(r23r, r23g, r23b, r23nir) # Uniting all the bands
bandsr23c <- im.classify(bandsr23,num_clusters=2) # Directly classifying the image with all the bands
plot(bandsr23c)

cl <- colorRampPalette(c("darkblue","yellow"))(100) 

par(mfrow=c(1,2)) 
plot(bandsr17c, col=cl)
plot(bandsr23c, col=cl)

dev.off()

f17 <- freq(bandsr17c)
tot17 <- ncell(bandsr17c)

f23 <- freq(bandsr23c)
tot23 <- ncell(bandsr23c)

perc17 = f17*100/tot17
# cleared forest = 41
# original forest = 59
perc23 = f23*100/tot23
# cleared forest = 56
# original forest = 44

year_2017 <- c(41,59)
year_2023 <- c(56,44)
classes <- c("Cleared", "Original")
data <- data.frame(classes,year_2017,year_2023)

r1 <- ggplot(data, aes(x=classes, y=year_2017, fill=classes)) + geom_bar(stat="identity") + scale_fill_manual(values=c("Cleared"="darkblue", "Original"="yellow")) + scale_fill_manual(values=c("Cleared"="darkblue", "Original"="yellow")) + ylim(c(0, 100))
r2 <- ggplot(data, aes(x=classes, y=year_2023, fill=classes)) + geom_bar(stat="identity") + scale_fill_manual(values=c("Cleared"="darkblue", "Original"="yellow")) + scale_fill_manual(values=c("Cleared"="darkblue", "Original"="yellow")) + ylim(c(0, 100))
r1 + r2
