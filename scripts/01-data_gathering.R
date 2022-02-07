#### Preamble ####
# Purpose: Gather data from open data Toronto
# Author: Samita Prabhasavat
# Data: 28 January 2022
# Contact: samita.prabhasavat@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - None


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(opendatatoronto)


#### Gather data ####
# Base on: https://open.toronto.ca/dataset/police-annual-statistical-report-reported-crimes/
# Each dataset is part of a package of data. These packages have unique IDs.
# We can find the unique ID by going to the webpage for the dataset e.g. see above.
package <- show_package("9d11c7aa-7613-4d3e-95f3-a02e2b1aa2d7")
# Within each package there are a bunch of different resources, e.g. datasets.
# We use the unique ID to get them.
resources <- list_package_resources("9d11c7aa-7613-4d3e-95f3-a02e2b1aa2d7")
# We want a specific dataset that has information about each case.
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))
# Now we get the dataset
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data


#### Save ####
write_csv(data, "inputs/data/police_report_data.csv")

         