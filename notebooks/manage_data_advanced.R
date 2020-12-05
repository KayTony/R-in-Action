
## probability function
### density function
x = pretty(c(-3,3), 30)
y = dnorm(x)
plot(x, y, type = "l", xlab = "NormalDeviate", ylab = "Density", yaxs="i")
pnorm(1.96)   # probability distribution function
qnorm(0.9, mean = 500) # quantile function
rnorm(50, mean = 50, sd = 10)  # random sampling

set.seed(123)
runif(5)
set.seed(123)
runif(5)

### sampling multi-variant-normal
library(MASS)
options(digits = 3)
set.seed(1234)
mean = c(230.7, 146.7, 3.6)
sigma = matrix(c(15360.8, 6721.2, -47.1, 
                 6721.2, 4700.9, -16.5,
                 -47.1, -16.5, 0.3), nrow = 3, ncol = 3)
mydata = mvrnorm(500, mean, sigma)
mydata = as.data.frame(mydata)
names(mydata) = c("y", "x1", "x2")
dim(mydata)
head(mydata, n=10)

## char function
### len of chars
x = c("ab", "cde", "fghij")
length(x)
nchar(x[3])
### replace/extract subchar
x = "abcdef"
substr(x, 2, 4)
substr(x, 2, 4) = "33"
### grep some pattern
grep("A", c("b", "A", "c"), fixed = TRUE)
### function in dataframe
a = 5
sqrt(a)
b = c(1.2, 1.3, 1.5)
round(b)
c = matrix(runif(12), nrow = 3)
log(c)
mean(c)  ## mean of all elements in matrix
### mean of row/column
mydata = matrix(rnorm(30), nrow=6)
apply(mydata, 1, mean)
apply(mydata, 2, mean)
apply(mydata, 2, mean, trim=0.2)

## 5.3 solution of example --------------------------------------------
options(digits = 2)

Student<-c("John Davids","Angela Williams","Bullwinkle Moose",
           "David Jones","Janice Markhammer","Cheryl Cushing",
           "Reuven Ytzrhak","Greg Knox","Joel England","Mary Rayburn")
Math<-c(502,600,412,358,495,512,410,625,573,522)
Science<-c(95,99,80,82,75,85,80,95,89,86)
English<-c(25,22,18,15,20,28,15,30,27,18)
roster<-data.frame(Student,Math,Science,English,stringsAsFactors = F)

z = scale(roster[, 2:4])
score = apply(z, 1, mean)
# roster = cbind(roster, z, score)
roster = cbind(roster, score)
y = quantile(score, c(.8, .6, .4, .2))
roster$grade[score >= y[1]] = "A"
roster$grade[score < y[1] & score >= y[2]] = "B"
roster$grade[score < y[2] & score >= y[3]] = "C"
roster$grade[score < y[3] & score >= y[4]] = "D"
roster$grade[score <y[4]] = "F"

name = strsplit(roster$Student, " ")
lastname = sapply(name, "[", 2)
firstname = sapply(name, "[", 1)
roster = cbind(firstname, lastname, roster[, -1])

roster = roster[order(lastname, firstname), ]


## how to write script
### if-else structure
if (!is.factor(grade)) grade = as.factor(grade) else print("Grade already is a factor")

if (FALSE){
  print('yes')
} else{
  print("NO")
}
### ifelse
outcome = ifelse(score > 0.5, "Passed", "Failed")
### switch
feelings = c("sad", "afraid")
for (i in feelings)
  print(
    switch(i, 
           happy = "I am glad you are happy",
           afraid = "There is nothing to fear",
           sad = "Cheer up",
           angry = "Calm down now")
  )

### for
for (i in 1:10) print("Hello")
### while
i = 10
while(i > 0){
  print("Hello")
  i = i - 1
}

### define your function
mystats = function(x, parametric=TRUE, print=FALSE){
  if (parametric){
    center = mean(x)
    spread = sd(x)
  } else {
    center = median(x)
    spread = mad(x)
  }
  if (print & parametric){
    cat("Mean=", center, "\n", "SD=", spread, "\n")
  } else if (print & !parametric){
    cat("Median=", center, "\n", "MAD=", spread, "\n")
  }
  result = list(center=center, spread=spread)
  return(result)
}

set.seed(1234)
x = rnorm(50000)
y = mystats(x)


## intergrate and aggregate
cars = mtcars[1:5, 1:4]
### transposition
t(cars)

### aggregate
options(digits = 3)
attach(mtcars)
aggdata = aggregate(mtcars, by=list(cyl, gear), FUN = mean, na.rm=TRUE)
aggdata

### reshape
library(reshape)
originaldata = data.frame(ID=c(1,1,2,2),Time=c(1,2,1,2),X1=c(5,3,6,2),X2=c(6,5,1,4))
meltdata = melt(originaldata,id=c("ID","Time")) 

### 
mydata = data.frame(ID=c(1,1,2,2),Time=c(1,2,1,2),X1=c(5,3,0,2),X2=c(6,5,1,4))
md = melt(mydata, id=c("ID","Time"))

attach(md)
cast(md,ID~variable,mean)
cast(md,Time~variable,mean)
detach(md)













