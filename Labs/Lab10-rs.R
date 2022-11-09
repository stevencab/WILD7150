This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:
  
  ```{r, include = F, echo = F,}
data1 <- read_csv("Lab Data/Lab10/BlackburnData2.csv")
### import data


###Log transform the data (as Karels et al. did)
### Be sure to add '1' to all count data - can't log transform 0!
data1$TotalExtinctions=data1$TotalExtinctions+1
data1$Predators=data1$Predators+1
data1LN=log(data1)
head(data1LN)


### first step is to specify the path model, which is done with 'specify.model'
###Build the path diagram
###Arguments are path, variable name, starting value (NA lets R choose starting value)
modelPop=specifyModel()
Area<>Area, AreaVar, NA ### variance in Area
Isolation<>Isolation, IsoVar, NA ###variance in Isolation
NativeBirds<>NativeBirds, BirdVar, NA ### error in No. of avifauna
Predators<>Predators, PredVar, NA ### error in No. of predators
TotalExtinctions<>TotalExtinctions, ExtVar, NA ### error in No. of Extinctions
Area<>Isolation, AreaIso, NA ### correlation between area and isolation
Area>Predators, AreaPred, NA ### link from Area to No. of Predators
Area>NativeBirds, AreaBirds, NA ### link from Area to No. of avifauna
Area>TotalExtinctions, AreaExt, NA ### link from Area to No. of Extinctions
Isolation>NativeBirds, IsoBirds, NA ### link from Isolation to No. of avifauna
Isolation>TotalExtinctions, IsoExt, NA ### link from isloation to No. of Extinctions
Isolation>Predators, IsoPred, NA ### link from isolation to No. of Predators
NativeBirds>TotalExtinctions, BirdsExt, NA ### link from No. of avifauna to No. of Extinctions
Predators>TotalExtinctions, PredExt, NA ### link from No. of Predators to No. of Extinctions
Predators<>NativeBirds, PredNative, NA



### Run the SEM

results=sem(modelPop,data=data1LN)
summary(results)
stdCoef(results)

```
