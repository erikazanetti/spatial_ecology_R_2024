# the higher the variability the higher the complexity of the system
# the higher variability will lead to have several species living in a certain place
# measure point of variability is the higher the variability the higher the texture of the place, the higher complexity
# how to measure variability: rasterdiv
# install here https://cran.r-project.org/web/packages/rasterdiv/index.html
# we are going to measure only the standard deviation. if you have a curve, the stand dev represents a variability of 68% of data over the mean
# measure the difference between every signle data in the mean , measure how much every person is out of the standard deviation (measure the outlier)
# we measure the standard deviation over an image
# what is standard deviation. you have the mean of a certain sample
# he is explaining at the standard deviation formula https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DIaTFpp-uzp0&psig=AOvVaw0Re6licBnhnCErvKL1Aljp&ust=1734097827035000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIDL6PqvoooDFQAAAAAdAAAAABAE
# the higher the amount of outliers in the sample, the higher the variability
library(imageRy)
library(terra)
im.list()

ssent <- im.import("sentinel.png") # there are 3 bands (+ one that we not consider)
# band 1 = NIR (near infra red)
# band 2 = red
# band 3 = green
im.plotRGB(sent, r=1, g=2, b=3)
# green is ??
# dark red are woodlands
# blue part is bare rock
im.plotRGB(sent, r=2, g=1, b=3) # we can change colors associated to the bands

# we can measure standard deviation
# we use the NIR (it is our choice)

# measuring standard deviation, we use a function called focal
nir <- sent[[1]] # the NIR is the first one in sent
# he is explaing the pdf "rasterdiv an information theory tallored R package..." https://besjournals.onlinelibrary.wiley.com/doi/epdf/10.1111/2041-210X.13583 image at page 3
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # ... 9 pixels in a moving window, 3 rows and 3 columns fun=sd explains the function we want to use which is standard deviation
plot(sd3) # we can detect areas of highest morphological variability in the image, which is north-west, where there was rocks. so if u are a geologist and wnt to look for different rocks, this is the are to do it

# Exercise: calculate standard deviation in a 7x7 pixels (moving window)
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7)

# we can also plot sd3 and sd7 together
par(mfrow=c(1,2))
plot(sd3)
plot(sd7) # wider regions with higher standard 
