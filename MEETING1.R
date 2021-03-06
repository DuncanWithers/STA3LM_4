rm(list=ls())
library(data.table)
data.raw <- fread("./2016_app_proj_group_4.txt")
data.2 <- data.raw
data.2[,"BMI"] <- data.raw$weight / (data.raw$height / 100)^2
data.2[,"WHR"] <- data.raw$waist / data.raw$hip

data.2 <- data.2[-22]

# delete weight height waist hip
data.2 <- subset(data.2, select = -c( 3:6 ))

#health.data <- model.matrix(~., data = data.2)

health.lm <- lm(sqrt(hdl)~.^2, data=data.2)

health.lm3 <- lm(sqrt(hdl)~WHR, data=data.2)

summary(health.lm3)


library(MASS)
step <- stepAIC(health.lm, direction = "both", k = 4)
step$anova

summary(step)
help(stepAIC)

par(mfrow = c(1,2), cex = 0.8, mex = 0.8)
plot(step, which = c(1,2))
help(stepAIC)
