# see picture taken of the blackboard
library(imageRy)
library(terra)
im.list()
sent <- im.import("sentinel.png")

pairs(sent) # to see the correlation amongst all of the bands (of sentinel image)
# we can all these systems and compact them in one pca

sentpc <- im.pca(sent) # there is the variability explained by the principal component
plot(sentpc) # because the sentpc is the principal component
# the first pc is that with highest variability (might explain 80% of the variability)
sentpc
pc1 <- sentpc[[1]]
pc1sd <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd)
