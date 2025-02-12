# Multivariate Analysis in R for Monitoring Communities
# The goal is to understand the relationships among different species in various plots.

# Install and load necessary package
install.packages("vegan")  # We use the 'vegan' package for vegetation analysis
library(vegan)

# Load dataset
data(dune)  # Species data for different plots
dune  # Display dataset
head(dune)  # View the first 6 plots
View(dune)  # Open a table view of the dataset

# Perform Detrended Correspondence Analysis (DCA)
decorana(dune)  # DCA is a PCA used for compacting dispersed data
multivar <- decorana(dune)  # Assign DCA results to 'multivar'

# DCA extracts four axes representing variability in the dataset
# The goal is to determine how much variability is explained by the first two axes

dca1 <- 3.7004
dca2 <- 3.1166
dca3 <- 1.30055
dca4 <- 1.47888

total <- dca1 + dca2 + dca3 + dca4  # Compute total variation

# Calculate proportions of each axis
prop1 <- dca1 / total
prop2 <- dca2 / total
prop3 <- dca3 / total
prop4 <- dca4 / total

# Convert proportions to percentages
perc1 <- prop1 * 100
perc2 <- prop2 * 100
perc3 <- prop3 * 100
perc4 <- prop4 * 100

# Print percentages
perc1  # 38.56%
perc2  # 32.48%
perc3  # 13.55%
perc4  # 15.41%

# Compute total explained variability of first two axes
perc1 + perc2  # 71.03% of variability is explained

# Plot DCA results
plot(multivar)  # Visualizes species relationships in reduced dimensions
