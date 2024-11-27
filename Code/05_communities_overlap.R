# Code to estimate the temporal overlap between species (what is time in which species are connected to each other)

# install.packages("overlap")

library(overlap)

data(kerinci)

# Exercise: show the first 6 rows of kerinci
head(kerinci) # zone = zone of the area ; species ; time = time in which species has been seen

kerinci

summary(kerinci) # to have information about each colon

# the time we see is a range from 0 to 1, now we want to convert the time in hour of the day
kerinci$Timecirc <- kerinci$Time * 2 * pi 
# we're moving from time in a linear dimension to a circular one
# dollaro per assegnare, asterico come moltiplicare, pi come pi-greco
# mettere il dollaro nel nome era necessario per creare la colonna nel dataset kerinci, altrimenti era come creare un oggetto separato dal dataset
# infatti se ora rifacciamo head(kerinci) c'è la nuova colonna Timecirc

# tiger data
# now we want to set only the tiger data with symbol "==" to select only tiger path
tiger <- kerinci[kerinci$Sps=="tiger",] # [] to select, the "," to close the [] sennò da errore

# we do a density plot relating the time to the tigers
# first we set the time for tiger
tigertime <- tiger$Timecirc

densityPlot(tigertime) # remember the capital letter P


# Exercise: select the data for the macaque and assign them to a new ojbect 
macaque <- kerinci[kerinci$Sps=="macaque",]

# Exercise: select the time for the macaque data and make a density plot
macaquetime <- macaque$Timecirc

densityPlot(macaquetime)

# now we can overlap the 2 graphs to see how much they're temporarly overlapped
overlapPlot(tigertime, macaquetime) 
# we see the 2 graphs overlapping to see when they stay in the same place at the same time, with multivar we have a spatial analysis, with overlap we analize the temporal dimension


#----- SQL
macaque <- kerinci[kerinci$Sps=="macaque",]
summary(macaque)

nomacaque <- kerinci[kerinci$Sps!="macaque",]
summary(nomacaque)
