# Example for Jags-Ybinom-XnomSsubjCcat-MbinomBetaOmegaKappa.R 
#------------------------------------------------------------------------------- 
# Optional generic preliminaries:
graphics.off() # This closes all of R's graphics windows.
rm(list=ls())  # Careful! This clears all of R's memory!
#------------------------------------------------------------------------------- 
# Read the data 
myData = read.csv("final_dataset.csv")
#------------------------------------------------------------------------------- 
# Load the relevant model into R's working memory:
source("Solution_elections2016_final.R")
#------------------------------------------------------------------------------- 
# Optional: Specify filename root and graphical format for saving output.
# Otherwise specify as NULL or leave saveName and saveType arguments 
# out of function calls.
fileNameRoot = "Elections-POST-" 
graphFileType = "pdf" 
#------------------------------------------------------------------------------- 
# Generate the MCMC chain:
# zName="Hits", NName="AtBats", sName="Player", cName="PriPos",

startTime = proc.time()
mcmcCoda = genMCMC( data=myData , 
                    zName="republican_votes", NName="sum_rep_dem_votes", sName="state", cName="class_median_income",
                    numSavedSteps=11000 , saveName=fileNameRoot ,
                    thinSteps=20 )
stopTime = proc.time()
elapsedTime = stopTime - startTime
show(elapsedTime)
#------------------------------------------------------------------------------- 
# Display diagnostics of chain, for specified parameters:
parameterNames = varnames(mcmcCoda) # get all parameter names for reference
for ( parName in c("omega[1]","omegaO","kappa[1]","kappaO","theta[1]") ) { 
  diagMCMC( codaObject=mcmcCoda , parName=parName , 
            saveName=fileNameRoot , saveType=graphFileType )
}
#------------------------------------------------------------------------------- 
# Get summary statistics of chain:
summaryInfo = smryMCMC( mcmcCoda , compVal=NULL , 
                        diffSVec=c(75,156, 159,844) , 
                        diffCVec=c(1,2,3) , 
                        compValDiff=0.0 , saveName=fileNameRoot )
# Display posterior information:
plotMCMC( mcmcCoda , data=myData , 
          zName="republican_votes", NName="sum_rep_dem_votes", sName="state", cName="class_median_income",
          compVal=NULL ,
          diffCList=list( c("Poor","Rich") ,
                          c("Poor","Middle"),
                          c("Poor","Mid-upper"),
                          c("Rich", "Middle") ), 
          diffSList=list( c("Texas","Oregon") , #
                          c("West Virginia", "Oklahoma") , # South-poor
                          c("West Virginia", "South Dakota"), # South-poor vs midwest-middle
                          c("West Virginia", "District of Columbia"), #south-poor vs south-rich
                          c("South Carolina", "Massachusetts")) , #south-poor vs NE-rich
          compValDiff=0.0, #ropeDiff = c(-0.05,0.05) ,
          saveName=fileNameRoot , saveType=graphFileType )
#------------------------------------------------------------------------------- 
