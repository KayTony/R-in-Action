vars = c("mpg", "hp", "wt")
head(mtcars[vars])

summary(mtcars[vars])

## skew, kurt
mystats = function(x, na.omit=FALSE){
  if (na.omit)
    x = x[!is.na(x)]
  m = mean(x)
  n = length(x)
  s = sd(x)
  skew = sum((x-m)^3/s^3)/n
  kurt = sum((x-m)^4/s^4)/n - 3
  return(c(n=n, mean=m, stdev=s, skew=skew, kurosis=kurt))
}
sapply(mtcars[vars], mystats)

library(pastecs)
stat.desc(mtcars[vars])

library(psych)
describe(mtcars[vars])

## statistics by group
aggregate(mtcars[vars], by=list(am=mtcars$am), mean)
aggregate(mtcars[vars], by=list(am=mtcars$am), sd)

### error in by function
dstats = function(x)(c(mean=mean(x), sd=sd(x)))
by(mtcars[vars], mtcars$am, sd)

### psych
describe.by(mtcars[vars], mtcars$am)

library(reshape)
dstats = function(x)(c(n=length(x),mean=mean(x), sd=sd(x)))
dfm = melt(mtcars, measure.vars=c("mpg", "hp", "wt"), id.vars = c("am", "cyl"))
cast(dfm, am+cyl+variable ~ ., dstats)

## visualizing result
library(vcd)
head(Arthritis)

### Frequency table
mytable = with(Arthritis, table(Improved))
prop.table(mytable)*100

mytable = xtabs(~ Treatment+Improved, data=Arthritis)
margin.table(mytable, 1)
prop.table(mytable, 1)

prop.table(mytable)   # element / all

addmargins(mytable)
addmargins(prop.table(mytable, 1), 2)
addmargins(prop.table(mytable, 2), 1)


## Test of denpendency
library(vcd)
### chisq test
mytable = xtabs(~Treatment+Improved, data = Arthritis)
chisq.test(mytable)
mytable = xtabs(~Improved+Sex, data = Arthritis)
chisq.test(mytable)

### fisher test
mytable = xtabs(~Treatment+Improved, data = Arthritis)
fisher.test(mytable)

### COCHRAN MANTEL HAENSZEL TEST
mytable = xtabs(~Treatment+Improved+Sex, data = Arthritis)
mantelhaen.test(mytable)


## Test of association
mytable = xtabs(~Treatment+Improved, data = Arthritis)
assocstats(mytable)





