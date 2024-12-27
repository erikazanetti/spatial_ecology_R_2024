# This code is related to multivariate analysis in R for monitoring communities to see the relationship in space among different species
# Theory (SEE PRESENTATION OF PROF):
# For communities we will work with plots, where we measure different species
# The multivariate analysis shows how much individuals/species are related to each other
# We move from tables to graphs
# We can create a graph in 3 dimensions, but when we have several plots we need more dimensions (impossible to represent graphically)
# We can compact the data with PCA (principal component analysis)
# PCA helps to compact a multidimensional system in a system made by 2 dimensions (or from 2 to 1)

# TOPICS:
# decorana for analysis
# calculate percentages

install.packages("vegan") # We use a package called vegan (vegetation analysis)
library(vegan)

data(dune)
dune  # we can see all data of plots related to each species
head(dune) # i see just the first 6 plots
View(dune) # to view a table with some data

# Analysis
decorana(dune) # decorana = detrended corresponde analysis, it's a PCA, powerful when we have a disperse range of data and we need to compact everything
multivar <- decorana(dune) # we assign decorana(dune) to multivar
# we passed from an original set of data (dune) to 4 axis 
# we see the lenght of axis, that equals to the amount of range represented from the axis
# the aim is to see the percentage of the original range which is incorporated in 2 axes

dca1 = 3.7004
dca2 = 3.1166
dca3 = 1.30055
dca4 = 1.47888

# we can calculate the percentage of each axis compared to all systems

total = dca1 + dca2 + dca3 + dca4

# to make the percentage we divide (dca1 / total) * 100

# Proportions
prop1 = dca1/total
prop2 = dca2/total
prop3 = dca3/total
prop4 = dca4/total

# Percantages
perc1 = prop1*100
perc2 = prop2*100
perc3 = prop3*100
perc4 = prop4*100

> perc1
[1] 38.56017
> perc2
[1] 32.47666
> perc3
[1] 13.55244
> perc4
[1] 15.41073

# Whole amount of variability
# now to have information about the whole amount of variability in percentage we add perc1 + perc2 
perc1+perc2
# 71.03683
# The first two axes explain 71% of variability, so i'm losing 29% becuase we only used 2 axis.

plot(multivar) 
# this is to see the whole amount of variability of the "dune" plot
# in the graph the name of the species are written by first letters of Species name and first letters of genre name (Achillea millefolium becomes Achimill, Bromus hordeaceus becomes Bromhord)
