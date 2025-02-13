# Using Principal Component Analysis (PCA) to Measure Variability

# Instead of using a single band like NIR, PCA helps compact all bands into a single component (PC1),
# which represents the highest variability in the dataset.

library(imageRy)
library(terra)

# List available datasets
im.list()

# Import Sentinel satellite image
sent <- im.import("sentinel.png")

# Analyze correlation between bands
pairs(sent)  # Displays correlation matrix among bands

# Perform Principal Component Analysis (PCA)
sentpc <- im.pca(sent)  # Computes PCA from the image bands

# Plot the principal components
plot(sentpc)  # Visualizing PCA components and explained variance

# Extract the first principal component (PC1), which has the highest variability
pc1 <- sentpc[[1]]  # PC1 captures the most variance

# Apply a moving window standard deviation filter to PC1
pc1sd <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd)  # Visualizes variability based on PC1

# Take-home message:
# - Variability can be measured through moving window analysis.
# - Instead of selecting one specific band (e.g., NIR), PCA allows us to compact multiple bands into PCs.
# - PC1 represents the most significant variation across all bands, making it useful for variability measurement.
