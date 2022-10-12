library(readr)
library(dplyr)
library(ggplot2)
library(car)
library(nlme)

data1 <- read_csv("Exams/Midterm/Data/Mid1.csv")
data1
res1 <- lm(data=data1, Size~Season)
summary(res1)
confint(res1)
TukeyHSD(aov(res1))
boxplot(data=data1, Size~Season)

data2 <- read_csv("Exams/Midterm/Data/Mid2.csv")
data2
plot(data2, PreyDens~PreyKilled)
abline(res2)
hist(data2$PreyKilled)
res2 <- lm(data=data2, PreyKilled~PreyDens)
summary(res2)
confint(res2)
plot(res2)
residuals(res2)
plot(residuals(res2)~data2$PreyDens)
hist(residuals(res2))
hist(data2$PreyDens)
abline(y=0)
acf(residuals(res2)) [order(data2$PreyDens)]

data3 <- read_csv("Exams/Midterm/Data/Mid3.csv")
data3
plot(data=data3, FlowerDens~Elevation          )
res3 <- lm(data=data3, FlowerDens~Treatment+Elevation)
summary(res3)
confint(res3)

data4 <- read_csv("Exams/Midterm/Data/Mid4.csv")
data4
res4 <- lm(data=data4, HomeRange~Sex*SoftMass)
plot(data=data4, HomeRange~SoftMass*Sex)
summary(res4)
confint(res4)
TukeyHSD(aov(res4))
ggplot(data4, aes(x=SoftMass,y=HomeRange, color = Sex)) +
  geom_point() +
  geom_smooth()


data5 <- read_csv("Exams/Midterm/Data/Mid5.csv")
data5
res5 <- lm(Sediment~Velocity+Volume, data=data5)
summary(res5)
vif(res5)

data6 <- read_csv("Exams/Midterm/Data/Mid6.csv")
data6

res6 <- lme(data=data6, Saturation~Sex+Diet, random=~1|Individual/Diet/Sex)
summary(res6)
