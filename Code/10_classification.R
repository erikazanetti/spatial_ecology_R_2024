# Classifying imagery data

# PRESENTATION "CLASSIFICATION"
# we can take one pixel and see the reflectance
# i took 3 pixels for each class and saw that they are related bc they have same reflectance
# satellite image reflectance to classes
# once we know the classes we can see the amount of pixels per class -> it is useful to understand the class of the object (one pixel is snow, other is wood etc)
# we see how many pixels are in each class
# this is classification (class = object of pixel (wood, plants, grassland, snow etc)
# today we use a classification method called unsupervised classification = classifying random sites

# classification process in R using imageRy

library(terra)
library(imageRy)
im.list()

im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") 
# looking at this image we might think that it has 3 major clusters of pixels, one with high energy on the right, one with low energy in the center, one with medium energy on the left
# So we can classify this image using 3 classes

sunc <- im.classify(sun, num_clusters=3) 
# everyone might have different images: depending on the point where the algorithm starteed to do the classification (a random pixel in the image), that would be the first class
# in my case, cluster 1 has medium energy, cluster 2 has low energy, cluster 3 has high energy 

# Let's use the same concept for Mato Grosso example to see change of forest or non forest
# firs let's import the images

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# Let's start the classification of the first image
m1992c <- im.classify(m1992, num_clusters=2)
# class 1 = forest
# class 2 = human related areas + water
# as before, these are my classes, everyone might have them different

m2006c <- im.classify(m2006, num_clusters=2)
# class 1 = forest
# class 2 = human related areas + water

# We want to calculate the frequencies of pixels inside each class for each map
# frequency = number of pixels for a class. Ex: two classes of ages, threshold is 30 yrs old, how many are oder? 2 people out of 12. The frequency is 2.
f1992 <- freq(m1992c)
f1992 # we can see the number of pixels per each class
# also the numbers might be different for everyone, depending on the classes everyone has

# Let's calculate percentage (because it's difficult to think about that big amount of pixels)
# % is calculated by doing the frequency multiplied by 100 and divided by the total number of pixels
# first of all we need the total
tot1992 <- ncell(m1992c) #ncell() is a function for number of cells
tot1992 # is 1800000
p1992 <- f1992 * 100 / tot1992 # we can also use "=" instead of "<-"
# percentages 1992
# forest: 83
# human related areas: 17

# Let's do the same for 2006
f2006 <- freq(m2006c)
tot2006 <- ncell(m2006c)
p2006 <- f2006 * 100 / tot2006
# percentages 2006
# forest: 45
# human related areas: 55

# Let's build a dataframe (= table used in R are called dataframe)
# columns (we have 3 columns):
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006)

# Final ggplot graph
library(ggplot2) # ggplot2 is a package 
ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
# aes = aestethics (related to what you put in X, Y and final colour)
# we use different colors for different classes so color=class
# geom = what type of graph you want to put in ggplot
# bar = we want to use bars graph (histogram)
# stat = type of statistic you want to use (we want just to use the data, so the identity is mantained)
# fill = the colour
# we can see the percentages of forest and human areas for 1992 and 2006

install.packages("patchwork")
library(patchwork) # this composes the graphs in a single graph

p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

# but these graphs are not correct because the Y axis changes between the two graphs, while they should be the same
# politicians are using these type of incorrect graphs to show statystics and prove that the change is not that much
# we need to fix the scale from 0 to 100 in Y

p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
p1 / p2 # to have one graph on top of the other instead of one next to each other

# Take-home message: we have the tools to take an image from any site and make a classification and a final graph with the amount of pixels in each class
