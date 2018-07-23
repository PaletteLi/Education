rm(list=ls())
setwd("/Users/clingley/Desktop/rFiles/1718/staar/1718final")
dat <- read.csv("source.csv")
attach(dat)

dat["Predicted"] <- NA
dat["GoalTest"] <- NA

#3rd grade
intercept3reading <- 6.282
map3reading <- .005127
intercept3math <- 6.066925
map3math <- .006275

#4th grade
int4math <- 6.041407
map4math <- .006263
int4reading <- 6.31
map4reading <- .004105
int4writing <- 7.007 
map4writing <- .000839

#5th grade
int5math <- 6.339
map5math <- .004824
int5reading <- 6.498
map5reading <- .004105
int5science <- 6.371648
map5science <- .00905

#6th grade
int6math <- 6.293
map6math <- .004949
int6reading <- 6.313681
map6reading <- .004947

#7th grade
int7math <- 6.4466236
map7math <- .004142
int7reading <- 6.484
map7reading <- .004227
int7writing <- 6.478052  #using reading
map7writing <- .008219

#8th grade
int8math <- 6.678
map8math <- .003252
int8reading <- 6.644
map8reading <- .003578
int8science <- 6.223347
map8science <- .009471
int8social <- 6.755477
map8social <- .006632


for(c in 1:length(dat$StudentID)){
  #3 math
  if ((dat$Grade[c] == 3) && (dat$Subject[c] == "Math")){
  dat$Predicted[c] = exp(intercept3math + map3math*dat$MAP[c])
  dat$GoalTest[c] = "STAAR Math"
  }
  #3 reading
  if ((dat$Grade[c] == 3) && (dat$Subject[c] == "Reading")){
    dat$Predicted[c] = exp(intercept3reading + map3reading*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Reading"
  }
  #4 math
  if ((dat$Grade[c] == 4) && (dat$Subject[c] == "Math")){
    dat$Predicted[c] = exp(int4math + map4math*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Math"
  }
  #4 reading
  if ((dat$Grade[c] == 4) && (dat$Subject[c] == "Reading")){
    dat$Predicted[c] = exp(int4reading + map4reading*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Reading"
  }
  #4 writing
  if ((dat$Grade[c] == 4) && (dat$Subject2[c] == "Writing")){
    dat$Predicted[c] = exp(int4writing + map4writing*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Writing"
  }
  #5 math
  if ((dat$Grade[c] == 5) && (dat$Subject[c] == "Math")){
    dat$Predicted[c] = exp(int5math + map5math*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Math"
  }
  #5 reading
  if ((dat$Grade[c] == 5) && (dat$Subject[c] == "Reading")){
    dat$Predicted[c] = exp(int5reading + map5reading*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Reading"
  }
  #5 science
  if ((dat$Grade[c] == 5) && (dat$Subject[c] == "Science")){
    dat$Predicted[c] = exp(int5science + map5science*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Science"
  }  
  #6 math
  if ((dat$Grade[c] == 6) && (dat$Subject[c] == "Math")){
    dat$Predicted[c] = exp(int6math + map6math*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Math"
  }
  #6 reading
  if ((dat$Grade[c] == 6) && (dat$Subject[c] == "Reading")){
    dat$Predicted[c] = exp(int6reading + map6reading*dat$MAP[c]) 
    dat$GoalTest[c] = "STAAR Reading"
  }  
  #7 math
  if ((dat$Grade[c] == 7) && (dat$Subject[c] == "Math")){
    dat$Predicted[c] = exp(int7math + map7math*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Math"
  }
  #7 reading
  if ((dat$Grade[c] == 7) && (dat$Subject[c] == "Reading")){
    dat$Predicted[c] = exp(int7Reading + map7Reading*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Reading"
  }
  #7 writing
  if ((dat$Grade[c] == 7) && (dat$Subject2[c] == "Writing")){
    dat$Predicted[c] = exp(int7writing + map7writing*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Writing"
  }   
  #8 math
  if ((dat$Grade[c] == 8) && (dat$Subject[c] == "Math")){
    dat$Predicted[c] = exp(int8math + map8math*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Math"
  }
  #8 reading
  if ((dat$Grade[c] == 8) && (dat$Subject[c] == "Reading")){
    dat$Predicted[c] = exp(int8reading + map8reading*dat$MAP[c])
    dat$GoalTest[c] = "STAAR Reading"
  }
  #8 science
  if ((dat$Grade[c] == 8) && (dat$Subject[c] == "Science")){
    dat$Predicted[c] = exp(int8science + map8science*dat$MAP[c]) 
    dat$GoalTest[c] = "STAAR Science"
  }
  #8 social studies
  if ((dat$Grade[c] == 8) && (dat$Subject2[c] == "Social Studies")){
    dat$Predicted[c] = exp(int8social + map8social*dat$MAP[c])  
    dat$GoalTest[c] = "STAAR Social Studies"
  }
    
  
}
write.csv(dat, file="science_mismatch.csv")




#line
dat["predicted"] <- NA
dat["regressor"] <- NA
dat["over_under"] <- NA

dat$regressor[c] = dat$STAAR[c] - dat$predicted[c]
sum(dat$over_under)
summary(dat$over_under)
if (dat$regressor[c] < 0)
  dat$over_under[c] = -1
else if (dat$regressor[c] >= 0)
  dat$over_under[c] = 1
