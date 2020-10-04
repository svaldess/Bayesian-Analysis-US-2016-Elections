#------------------------------------------------------------------------------- 
# Optional generic preliminaries:
graphics.off() # This closes all of R's graphics windows.
rm(list=ls())  # Careful! This clears all of R's memory!
#------------------------------------------------------------------------------- 
# Read the data 
#myData = read.csv("BattingAverage.csv")
myData = read.csv("final_dataset.csv")
contrasts = list( 
  list( c("Poor") , c("Rich") , compVal=0.0 , ROPE=NULL ) ,
  list( c("Middle") , c("Rich") , compVal=0.0 , ROPE=NULL ) 
)
#contrasts = list( 
#  list( c("Pitcher") , c("Catcher") , compVal=0.0 , ROPE=NULL ) ,
#  list( c("Catcher") , c("1st Base") , compVal=0.0 , ROPE=NULL ) 
#)
fileNameRoot = "votes-logistic-" 
graphFileType = "eps" 
#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("Jags-Ybinom-Xnom1fac-Mlogistic.R")
# Generate the MCMC chain:
#startTime = proc.time()
mcmcCoda = genMCMC( datFrm=myData, yName="republican_votes", NName="total_votes", xName="class_median_income",
                    numSavedSteps=15000 , thinSteps=10 , saveName=fileNameRoot )
#mcmcCoda = genMCMC( datFrm=myData, yName="Hits", NName="AtBats", xName="PriPos",
#                    numSavedSteps=15000 , thinSteps=10 , saveName=fileNameRoot )
#stopTime = proc.time()
#elapsedTime = stopTime - startTime
#show(elapsedTime)
#------------------------------------------------------------------------------- 
# Display diagnostics of chain, for specified parameters:
parameterNames = varnames(mcmcCoda) # get all parameter names for reference
for ( parName in c("b0","b[1]","omega[1]","kappa") ) { 
  diagMCMC( codaObject=mcmcCoda , parName=parName , 
                saveName=fileNameRoot , saveType=graphFileType )
}
#------------------------------------------------------------------------------- 
# Get summary statistics of chain:
summaryInfo = smryMCMC( mcmcCoda , contrasts=contrasts ,
                        datFrm=myData, xName="class_median_income",
                        #yName="Hits", NName="AtBats", 
                        saveName=fileNameRoot )
show(summaryInfo)
# Display posterior information:
plotMCMC( mcmcCoda , contrasts=contrasts ,
          datFrm=myData, xName="class_median_income", yName="republican_votes", NName="total_votes", 
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 
