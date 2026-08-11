### This script downloads the data and images that are to be updated daily.

### Source the functions
source("00_app_functions.R")
library(rsconnect)


### Raw data
## Pull iNaturalist and eBird data
inat <- inat_recent("65739", "week", "Saguaro National Park")
ebird <- ebird_recent("US-AZ-019", "Saguaro National Park")

## Make a df with 'groups' to add to the data
groups <- data.frame(iconic.taxon.name = c("Plantae", "Mammalia", "Animalia", "Aves", "Insecta", 
                                 "Reptilia", "Amphibia", "Fungi", "Protozoa", "Chromista",
                                 "Arachnida", "Mullusca"),
           groups = c("Plants", "Mammals", "Other animals", "Birds", "Insects", "Reptiles",
                      "Amphibians", "Fungi and lichens", "Protozoans", "Kelp and seaweeds", 
                      "Spiders", "Mullusks"))

## Combine the two data frames
final_data <- combine_citsci_data(inat, ebird, join = groups)

## Write out the data
write_csv(final_data, "www/datasets/the_data.csv")


### iNaturalist images
## Download the images to the www folder
download_photos(final_data, "www/img/obs")


### Deploy updates to shiny app
## Set up account info:
rsconnect::setAccountInfo(name = "schoodic-institute-data",
               token = Sys.getenv("SHINYAPPS_TOKEN"),
               secret = Sys.getenv("SHINYAPPS_SECRET"),
               server = "shinyapps.io")


## Deploy
rsconnect::deployApp(launch.browser = F, forceUpdate = T)





