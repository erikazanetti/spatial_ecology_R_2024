# Classifying Imagery Data in R

# Classification process using imageRy package

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

# List available datasets
im.list()

# Import image for classification
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# Classify image into three clusters
sunc <- im.classify(sun, num_clusters=3)

# Classify Mato Grosso images to analyze deforestation
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

m1992c <- im.classify(m1992, num_clusters=2)  # 1992 classification
m2006c <- im.classify(m2006, num_clusters=2)  # 2006 classification

# Compute frequency of pixels per class
f1992 <- freq(m1992c)
tot1992 <- ncell(m1992c)  # Total number of pixels
p1992 <- f1992 * 100 / tot1992  # Compute percentage

f2006 <- freq(m2006c)
tot2006 <- ncell(m2006c)
p2006 <- f2006 * 100 / tot2006

# Create a dataframe for visualization
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)
tabout <- data.frame(class, y1992, y2006)

# Create bar plots to visualize changes
ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

# Combine graphs using patchwork
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2  # Side-by-side visualization
p1 / p2  # Stacked visualization

# Take-home message:
# - We can classify satellite images, calculate pixel proportions, and visualize land use changes over time.
