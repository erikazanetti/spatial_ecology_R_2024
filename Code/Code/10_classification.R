# Classifying imagery data

# PRESENTATION "CLASSIFICATION"
# we can take one pixel and see the reflectance
# i took 3 ... pixels and saw that some are related bc they have same reflectance
# satellite image reflectance to classes
# once we know the classes we can see the amount of pixels per class
# we see how many pixels are in each class
# today we use a classification method called unsupervised classification

# classification process in R using imageRy

library(terra)
library(imageRy)
im.list()

im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

sunc <- im.classify(sun, num_clusters=3) # cluster 1 has higher energy ...?? 

# let's use the same concept for Mato Grosso example to see change of forest or non forest
# firs let's import an image

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# let's start the classification of the first image
m1992c <- im.classify(m1992, num_clusters=2)
# class 1 = human related areas + water
# class 2 = forest

m2006c <- im.classify(m2006, num_clusters=2)
# class 1 = human related areas + water
# class 2 = forest

# we want to calculate the frequencies of pixels inside each class
f1992 <- freq(m1992c)

# let's calculate percentage
tot1992 <- ncell(m1992)
p1992 <- f1992 * 100 / tot1992 # we can also use "=" instead of "<-"
# percentages 1992
# human related areas: 17
# forest: 83

# let's do the same for 2006
f2006 <- freq(m2006c)
tot2006 <- ncell(m2006c)
p2006 <- f2006 * 100 / tot2006
# percentages 2006
# human related areas: 55
# forest: 45

# let's build a dataframe (final table)
# columns:
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006)

# Final ggplot graph
library(ggplot2)
ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

install.packages("patchwork")
library(patchwork) # this composes the graphs in a single graph

p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

# but these graphs are not correct because ....

p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
p1 / p2 # to have one graph on top of the other instead of one next to each other
