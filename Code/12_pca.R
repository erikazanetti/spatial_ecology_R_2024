# in the previous case we used the NIR to measure variability, but in some cases other bands are better
# how to chose the best band? using multivariate analysis, where we compact all data in few axis. the first axes has the highest variability.
# see picture taken of the blackboard
# so we can pass from a multisystem of b1+b2 to just a system with a single band which is the principal component
# since the standard deviation can be calculated only with a single band, instead of using NIR, we can use PC1
library(imageRy)
library(terra)
im.list()
sent <- im.import("sentinel.png")

pairs(sent) # to see the correlation amongst all of the bands (of sentinel image)
# for example the band 2 and the band 2 are really correlated (0.98), while the NIR (band 1) is not correlated or less correlated with other bands
# we can take all these systems and compact them in one pca

sentpc <- im.pca(sent) # there is the variability explained by the different components (it is called percentage of variance)
plot(sentpc) # because the sentpc is the principal component
# the first pc is that with highest variability (might explain 80% of the variability)
sentpc
pc1 <- sentpc[[1]] # extracting the first principal component (PC1) from sentpc
pc1sd <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd)

# Take-home message:
# - measure variability through moving windows images
# - we can either chose one variable to measure variability (for ex. NIR) or we can do multivariate analysis to extract the PC1 and use it to measure variability
# PCA helps combine these multiple bands into principal components (PCs), and PC1 (the first principal component) captures the most significant variation across all the bands. 
# This means that PC1 represents the combined information from all the bands, focusing on the most important features in the image.
