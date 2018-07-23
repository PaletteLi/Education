rm(list=ls())
setwd("/Users/clingley/Desktop/rFiles/1718/staar/1718final")
dat <- read.csv("source.csv")
attach(dat)

dat["Predicted"] <- NA
dat["eocSubj"] <- NA



intEng1 <- 7
eocEng1 <- .005817

intEng2 <- 7.469
eocEng2 <- .00021

intAlg1 <- 6.622975
eocAlg1 <- .007074

intSoc <- 8.10847
eocSoc <- .01385

intBio <- 6.772171
eocBio <- .007146

for(c in 1:length(dat$StudentID)){
  
  #English 1
  if (dat$Subject2[c] == "English I"){
    dat$Predicted[c] = exp(intEng1 + eocEng1*dat$MAP[c])
    dat$eocSubj[c] = "English I"
  }
  #English 2
  if (dat$Subject2[c] == "English II"){
    dat$Predicted[c] = exp(intEng2 + eocEng2*dat$MAP[c])
    dat$eocSubj[c] = "English II"
  }
  #Algebra
  if (dat$Subject2[c] == "Algebra I"){
    dat$Predicted[c] = exp(intAlg1 + eocAlg1*dat$MAP[c])
    dat$eocSubj[c] = "Algebra I"
  }
  #US History
  if (dat$Subject2[c] == "US History"){
    dat$Predicted[c] = exp(intSoc + eocSoc*dat$MAP[c])
    dat$eocSubj[c] = "US History"
  }
  #Biology
  if (dat$Subject2[c] == "Biology"){
    dat$Predicted[c] = exp(intBio + eocBio*dat$MAP[c])
    dat$eocSubj[c] = "Biology"
  }
  
}

write.csv(dat, file="EOCgoals_history.csv")






for(c in 1:length(dat$EOC)){
  dat$Difference[c] = dat$EOC[c] - dat$Predicted[c]
}

if(dat$Difference[1] < 0){
  dat$count[1] = 1
}else dat$count[1] = 0

for(c in 2:length(dat$EOC)){
  if(dat$Difference[c] < 0){
    dat$count[c] = dat$count[c-1] + 1
  }else dat$count[c] = dat$count[c-1]
}
