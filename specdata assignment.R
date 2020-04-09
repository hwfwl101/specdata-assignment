pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  # Break this function up into a series of smaller functions
  # that do exactly what you expect them to. Your friends
  # will love you for it.
  
  csvFiles = getFilesById(id, directory)
  
  dataFrames = readMultipleCsvFiles(csvFiles)
  
  dataFrame = bindMultipleDataFrames(dataFrames)
  
  getColumnMean(dataFrame, column = pollutant)
}


getFilesById <- function(id, directory = getwd()) {
  allFiles = list.files(directory)
  file.path(directory, allFiles[id])
}

readMultipleCsvFiles <- function(csvFiles) {
  lapply(csvFiles, read.csv)
}

bindMultipleDataFrames <- function(dataFrames) {
  Reduce(function(x, y) rbind(x, y), dataFrames)
}

getColumnMean <- function(dataFrame, column, ignoreNA = TRUE) {
  mean(dataFrame[ , column], na.rm = ignoreNA)
}

OR

pollutantmean2<- function(dir, pollutant, id=1:332) {
  dir<- list.files(dir, full.names = TRUE)     #list files
  dat<- data.frame()                        #make empty dataframe
  for (i in id) {
    dat <- rbind(dat, read.csv(dir[i]))     #rbind all files(bind_rows can also be used but the dplyr package will need to be called. I also dont think one would need the dataframe function. find that out.)
  }
  mean(dat[,pollutant], na.rm = TRUE)       #calculate mean of given column
}


complete<- function(dir, id=1:332) {
  dir<- list.files(dir, full.names = TRUE)     
 dat<- data.frame()                        
 for (i in id) {
   readfiles <-  read.csv(dir[i])
  dataframing<- data.frame(id=c(i), nobs=c(sum(complete.cases(readfiles))))
dat <- rbind(dat, dataframing)     
 }
 dat
}

OR

complete2<- function(dir, id=1:332) {
  dir<- list.files(dir, full.names = TRUE)     
  dat<- data.frame()                        
  for (i in id) {
    readfiles <-  read.csv(dir[i])
    nobs <- sumofcompletecases <- sum(complete.cases(readfiles))
    dataframing<- data.frame(i, nobs)
    dat <- rbind(dat, dataframing)     
  }
  colnames(dat) <- c("id", "nobs")
  dat}