# For ecologists: the higher the variability of an area -> the higher the complexity of the system -> the higher the potential biodiversity
# For geologists: the higher the texture of the place -> the higher the morphological complexity of an area

# How to measure variability: package "rasterdiv"
# install here https://cran.r-project.org/web/packages/rasterdiv/index.html
# we are going to measure only the standard deviation. if you have a curve, the standard deviation represents a variability of 68% of data over the mean
# measure the difference between every single data and the mean, so for example measure how much every person is out of the mean value of age -> measure the outlier
# we measure the standard deviation over an image

# What is standard deviation?
# you have the mean of a certain sample (x̅), for example 27
# then to see how much a value is out of the mean we do (x - x̅)^2, for example (25-27)^2 = 2
# we do this for every value, so for example (24-27)^2 = 9
# then we sum the results, so 4+9 = 13
# and then the result is divided by n (n is the number of data). the result is the variance. 13 / 2 = 6,5
# finally you do the square of the result and you have the standard deviation.
# he is explaining the standard deviation formula https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DIaTFpp-uzp0&psig=AOvVaw0Re6licBnhnCErvKL1Aljp&ust=1734097827035000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIDL6PqvoooDFQAAAAAdAAAAABAE
# the higher the amount of outliers in the sample, the higher the variability
library(imageRy)
library(terra)
im.list()

sent <- im.import("sentinel.png") # there are 3 bands (+ one that we don't consider)
# band 1 = NIR (near infra red)
# band 2 = red
# band 3 = green
im.plotRGB(sent, r=1, g=2, b=3)
# green is ??
# dark red are woodlands,
# blue part is bare rock
im.plotRGB(sent, r=2, g=1, b=3) # we can change colors associated to the bands

# we can measure standard deviation from one of the bands
# we use the NIR (it is our choice)

# measuring standard deviation, we use a function called focal
nir <- sent[[1]] # the NIR is the first one in sent
# we are using a method called "moving window"
# he is explaing the pdf "rasterdiv an information theory tallored R package..." https://besjournals.onlinelibrary.wiley.com/doi/epdf/10.1111/2041-210X.13583 image at page 3
# 1) we have an original image. we are using a filter of 3x3 pixels on top of the original image and we are extracting the standard deviation in this window of 3x3 pixels
# 2) so we are going to measure the reflectance of the single values of NIR, we calculate the mean value in this 3x3 window, and measure the standard deviation from the mean in this 3x3 window
# 3) we extract the standard deviation to put it in the central pixel of the original image
# 4) the next window is moving by 1, and we do the same thing, extracting the standard deviation to put it in the central pixel of the original image
# 5) and so on
# 6) in the end we remove the original image and extract the final standard deviation of moving windows of 3x3 pixels

# So now we build the matrix (which is the moving window) considering how many pixels we have in the image, so we are explaining to the software what are the single data
# the single data in a matrix of 3x3 pixels are 1 pixel out of 9. (the single data are the single pixels)
# we are disposing this pixels in a matrix of 3 rows per 3 columns
# the function used is the standard deviation (fun=sd)
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3) # we can detect areas of highest morphological variability in the image, which is north-west, where there was rocks. so if you are a geologist and want to look for different rocks, this is where to do it

# Exercise: calculate standard deviation in a 7x7 pixels (moving window)
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7)
# a 7x7 window covers a larger area, averaging the variability over a bigger area. This reduces fine details and results in a smoother (blurrier) output.

# we can also plot sd3 and sd7 together
par(mfrow=c(1,2))
plot(sd3)
plot(sd7) # wider regions with higher standard deviation
