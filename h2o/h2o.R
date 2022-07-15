library(h2o)
h2o.init()

prostate.hex = h2o.uploadFile(path = system.file("data", "prostate.csv", package="h2o"), 
                              destination_frame = "prostate.hex")
summary(prostate.hex)

gait.hex <- h2o.uploadFile(path = system.file("data", "walking.csv", package="h2o"), 
                           destination_frame = "gait")
summary(gait.hex)

votes.hex = h2o.uploadFile(path = system.file("data", "housevotes.csv", package="h2o"), 
                           destination_frame = "votes.hex", header = TRUE)
summary(votes.hex)

iris.hex = h2o.uploadFile(path = system.file("data", "iris_wheader.csv", package="h2o"), 
                          destination_frame = "iris.hex")
summary(iris.hex)

iris.hex = h2o.uploadFile(path = system.file("data", "iris.csv", package="h2o"), 
                          destination_frame = "iris.hex")
summary(iris.hex)

australia.hex = h2o.uploadFile(system.file("data", "australia.csv", 
                                           package="h2o"), "australia.hex")
summary(australia.hex)



# Logistic Regression
prostate.glm = h2o.glm(x = c("AGE","RACE","PSA","DCAPS"), y = "CAPSULE", 
                       training_frame = prostate.hex, family = "binomial", alpha = 0.5)
print(prostate.glm)

myLabels = c(prostate.glm@model$x, "Intercept")
plot(prostate.glm@model$coefficients, xaxt = "n", 
     xlab = "Coefficients", ylab = "Values")
axis(1, at = 1:length(myLabels), labels = myLabels)
abline(h = 0, col = 2, lty = 2)
title("Coefficients from Logistic Regression\n of Prostate Cancer Data")

barplot(prostate.glm@model$coefficients, 
        main = "Coefficients from Logistic Regression\n of Prostate Cancer Data")


# k-Mean
prostate.km = h2o.kmeans(prostate.hex, k = 10, 
                         x = c("AGE","RACE","GLEASON","CAPSULE","DCAPS"))
print(prostate.km)

prostate.data = as.data.frame(prostate.hex)

# Plot k-means centers
par(mfrow = c(1,2))
prostate.ctrs = as.data.frame(prostate.km@model$centers)
plot(prostate.ctrs[,1:2])
plot(prostate.ctrs[,3:4])
title("K-Means Centers for k = 10", outer = TRUE, line = -2.0)


# Naive Bayes
votes.nb = h2o.naiveBayes(x = 2:17, y = 1, 
                          training_frame = votes.hex, laplace = 3)
print(votes.nb)
votes.pred = predict(votes.nb, votes.hex)
head(votes.pred)

iris.nb = h2o.naiveBayes(x = 1:4, y = 5, training_frame = iris.hex)
print(iris.nb)


# Random Forest
iris.rf = h2o.randomForest(y = 5, x = c(1,2,3,4), training_frame = iris.hex, 
                           ntrees = 50, max_depth = 100)
print(iris.rf)


# Eigenvectors
australia.pca = h2o.prcomp(australia.hex, k = 8)
print("Eigenvectors of the PCA model...")
print(australia.pca@model$eigenvectors)
screeplot(australia.pca)

print("Eigenvectors of the PCA model...")
australia.pca2 = h2o.prcomp(australia.hex, k = 4, transform = "STANDARDIZE")
print(australia.pca2@model$eigenvectors)
screeplot(australia.pca2)



gait.glrm <- h2o.glrm(training_frame = gait.hex, cols = 2:ncol(gait.hex), k = 5, 
                      init = "PlusPlus", loss = "Quadratic", 
                      regularization_x = "None", regularization_y = "None", 
                      max_iterations = 1000)
print(gait.glrm)

# Archetype to feature mapping
gait.y <- gait.glrm@model$archetypes
print(gait.y)

# Plot first archetype on z-coordinate features
feat_cols <- seq(3, ncol(gait.y), by = 3)
plot(1:length(feat_cols), gait.y[1,feat_cols], xlab = "Feature", 
     ylab = "Archetypal Weight", main = "First Archetype's Z-Coordinate Feature Weights", 
     col = "blue", pch = 19, lty = "solid")
text(1:length(feat_cols), gait.y[1,feat_cols], 
     labels = colnames(gait.y[1,feat_cols]), cex = 0.7, pos = 3)
abline(0, 0, lty = "dashed")




prostate.gbm = h2o.gbm(x = setdiff(colnames(prostate.hex), "CAPSULE"), 
                       y = "CAPSULE", training_frame = prostate.hex, ntrees = 10, 
                       max_depth = 5, learn_rate = 0.1)
print(prostate.gbm)
prostate.gbm2 = h2o.gbm(x = c("AGE", "RACE", "PSA", "VOL", "GLEASON"), 
                        y = "CAPSULE", training_frame = prostate.hex, ntrees = 10, 
                        max_depth = 8, min_rows = 10, learn_rate = 0.2)
print(prostate.gbm2)

iris.gbm = h2o.gbm(x = 1:4, y = 5, training_frame = iris.hex)
print(iris.gbm)




# Set the CAPSULE column to be a factor column then build model.
prostate.hex$CAPSULE = as.factor(prostate.hex$CAPSULE)
model = h2o.deeplearning(x = setdiff(colnames(prostate.hex), c("ID","CAPSULE")), 
                         y = "CAPSULE", training_frame = prostate.hex, 
                         activation = "Tanh", hidden = c(10, 10, 10), epochs = 10000)
print(model@model$model_summary)

# Make predictions with the trained model with training data.
predictions = predict(object = model, newdata = prostate.hex)
# Export predictions from H2O Cluster as R dataframe.
predictions.R = as.data.frame(predictions)
head(predictions.R)
tail(predictions.R)

# Check performance of classification model.
performance = h2o.performance(model = model)
print(performance)




# Set the CAPSULE, DPROS and GLEASON columns to be factor columns
prostate.hex$CAPSULE = as.factor(prostate.hex$CAPSULE)
prostate.hex$DPROS = as.factor(prostate.hex$DPROS)
prostate.hex$GLEASON = as.factor(prostate.hex$GLEASON)

# Build autoencoder model
x = c("AGE", "RACE", "DPROS","PSA", "VOL", "CAPSULE", "GLEASON")
dl_autoencoder = h2o.deeplearning(x = x, training_frame = prostate.hex, 
                                  model_id = "autoencoders", autoencoder = T)

# Detect outliers on the prostate dataset again
anomalies   = h2o.anomaly(object = dl_autoencoder, prostate.hex)
anomalies.R = as.data.frame(anomalies)

# Plot the reconstruction error and add a line for error in the 90th percentile
quantile  = h2o.quantile(anomalies$Reconstruction.MSE)
threshold = quantile["90%"]
plot(anomalies.R$Reconstruction.MSE)
abline(h=threshold)
