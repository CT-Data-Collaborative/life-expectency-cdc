ToNumeric <- function (factor) {
  return(as.numeric(as.character(factor)))
}

ExtractNumData <- function (factor) {
  return(ToNumeric(factor[1:length(factor)]))
}

WriteDFToTable <- function(df, filename){
  write.table(
    df,
    file = file.path(getwd(), "data", filename),
    sep = ",",
    row.names = FALSE
  )
}

# This function expects a file called ACS-hartford-tracts.csv, which contains FIPS data for tracts in hartford county
getHartfordTracts <- function (path_to_raw){
  tracts <- read.csv(dir(path_to_raw, pattern = "hartford-tracts", full.names = TRUE))
  return(tracts$FIPS)
}

retrieveLifeExpenctencyWithStdErr <- function(filepath, tracts){
  life.expectancy <- read.csv(filepath)
  life.expectancy <- life.expectancy[ToNumeric(life.expectancy$Tract.ID) %in% tracts,]
  
  knownTracts <- life.expectancy$Tract.ID
  expectancy <- life.expectancy$e.0.
  stdErr <- life.expectancy$se.e.0..
  
  sanitised_employment <- data.frame(knownTracts,
                                     expectancy, stdErr
  )
  colnames(sanitised_employment) <- c("ID",
                                      "Life Expectancy at Birth",
                                      "Standard Error of the Life Expectancy at Birth"
  )
  return(sanitised_employment)
}
