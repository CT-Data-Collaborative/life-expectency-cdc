source("./scripts/utils.R")

#Setup environment
sub_folders <- list.files()
raw_location <- grep("raw", sub_folders, value=T)
path_to_raw <- (paste0(getwd(), "/", raw_location))
raw_data <- dir(path_to_raw, recursive=T, pattern = "CT_A", full.names = TRUE)  # life expectancy data for CT for 2010-2015

# Retrieve census tracts
city.tracts <- getHartfordTracts(path_to_raw);

# extract information and write to CSV file
CDC.expectacy.data <- retrieveLifeExpenctencyWithStdErr(raw_data[1], city.tracts)
WriteDFToTable(CDC.expectacy.data, "cdc-expectancy-data-2010-2015-with-stderr.csv")