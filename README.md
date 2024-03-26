# Google-Analytics-UA-R-Data-Extract
This repository provides R scripts specifically designed for extracting data from Google Analytics Universal Analytics (UA).
Google Analytics UA Data Extraction with R
This repository contains R scripts for extracting data from Google Analytics Universal Analytics (UA) using the googleAnalyticsR package. It's designed to help users authenticate with Google Analytics, fetch account lists, and perform various data extraction tasks, including but not limited to user behavior, conversion metrics, and acquisition channels.

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites
You need to have R installed on your machine. If you haven't already, you can download and install it from CRAN. Additionally, you'll need to install the googleAnalyticsR and dplyr packages.

## Installation
1. Clone this repository or download the R script files to your local machine.
2. Open RStudio or your preferred R environment.
3. Set your working directory to where you've saved the script:

```setwd("<Your_Directory_Path>")``` 

4. Install the required packages if you haven't already:

`install.packages("googleAnalyticsR")`
`install.packages("dplyr")`

5. Load the packages in your R session:

`library(googleAnalyticsR)`
`library(dplyr)`

## Usage
1. Begin by authenticating with Google Analytics:
   
`ga_auth()`

Follow the prompts to log in with your Google account. You'll need access to Google Analytics UA properties.

2. Fetch your Google Analytics account list:

`account_list <- ga_account_list()`
`print(account_list)`

3. Modify the script to specify your data extraction queries based on your needs. Example queries are provided in the script for extracting different types of data such as audience overview, conversion goals, page tracking, and acquisition reports.
   
## Saving Data

The script includes commands to write the extracted data to CSV files:


`write.csv(your_data_frame, "<Your_Directory_Path>/your_data_file.csv", row.names = FALSE)`

Replace your_data_frame with the variable containing your fetched data, and adjust the file path and name as needed.

## Contributing
Please feel free to fork this repository, make changes, and submit pull requests. We appreciate your contributions to improve the project!

