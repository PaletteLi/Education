rm(list=ls())
setwd("/Users/clingley/Desktop/rFiles/1718/staar")
dat <- read.csv("source.csv")
attach(dat)
names(dat)

expModel <- lm(English.I.EOC.Goal~English.EPAS + Reading.EPAS)
summary(expModel)


axis1 <- seq(0,300,10)
pred <- predict(expModel,list(English.EPAS=axis1))

plot(English.EPAS,English.I.EOC.Goal)
lines(axis1,pred,lwd=2, col = "red")
