rm(list=ls())
setwd("/Users/clingley/Desktop/rFiles/1718/staar")
dat <- read.csv("source.csv")
attach(dat)
names(dat)

expModel <- lm(log(English.I.EOC.Goal)~Language.Usage.MAP)
summary(expModel)


axis1 <- seq(0,300,10)
pred <- exp(predict(expModel,list(Language.Usage.MAP=axis1)))

plot(Language.Usage.MAP,English.I.EOC.Goal)
lines(axis1,pred,lwd=2, col = "red")
