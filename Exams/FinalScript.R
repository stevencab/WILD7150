library(readr)
library(ggplot2)
library(dplyr)
library(car)
library(carData)
library(nlme)
library(lme4)
library(dagitty)
library(sem)
library(lattice)
library(MASS)
library(boot)

data1 <- read_csv("Exams/Final/Data/FinalData1.csv")

res1 <- glm(data = data1, Offspring~Age+Sex,
            family = poisson)
summary(res1)
exp(0.12770)
exp(confint(res1))

res1new <- data.frame(Age = 5, Sex="Male")
predict1 <- predict(res1,res1new, type = "response")

res2 <- glm(data = data1, Survival~Age+Species,
            family = binomial)
summary(res2)
exp(0.1268)
exp(confint(res2))

#relevel for wolf vs. dog
data1$Species <- factor(data1$Species, levels = c("Wolf","Dog","Coyote"))  

exp(0.6175)
exp(confint(res2))




DAG = dagitty('dag{
              TreeDens [pos="0,3"]
              SoilComp [pos="1,4"]
              SoilMoist [pos="1.5,2.5"]
              Sun [pos="1.5,4"]
              Under [pos="3,3"]
              TreeDens->Sun->Under
              TreeDens->SoilMoist->Under
              TreeDens->Under
              TreeDens->SoilComp->Under
              SoilComp->SoilMoist
              
}')

plot(DAG)
adjustmentSets(DAG,"SoilMoist","Under")

hist(data1$SoilMoist)
res3 <- lm(data = data1, Under~SoilMoist+SoilComp+TreeDens)
summary(res3)
confint(res3)

res4 <- princomp(~ChestGirth+Weight+BodyLength+AntlerSize, data = data1)
summary(res4)  
res4$loadings
