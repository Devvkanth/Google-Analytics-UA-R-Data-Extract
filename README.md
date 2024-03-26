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

This repository contains scripts and data examples for extracting various types of data from Google Analytics (Universal Analytics) using the `googleAnalyticsR` package in R. The data extracted and processed into CSV files provides comprehensive insights into user behavior, demographics, acquisition channels, technology usage, and conversion paths. Below is a summary of the different types of tables/data views created:

# Overview

## Data Tables / Views

- **Google Analytics Account List**: Contains a list of available Google Analytics accounts.

### Audience Data
- **Audience Overview Data**: Includes metrics like user exits, pageviews, new users, total users, bounces, time on page, sessions, session duration, and unique pageviews.
- **Audience Behavior - Engagement**: Focuses on engagement metrics such as pageviews and sessions, including detailed session duration analysis.
- **Audience Behavior - Frequency & Recency**: Analyzes the frequency and recency of visits.
- **Audience Behavior - New vs. Returning Users**: Differentiates metrics between new and returning users.
- **Audience Demographics - Age and Gender**: Provides insights into the demographic distribution of users by age and gender.
- **Audience Geography**: Offers detailed and simplified views of users' geographic distribution by country, metro, city, and state (region).

### Interests and Mobile Overview
- **Audience Interests - Affinity Categories and In-Market Segments**: Details user interests in affinity categories and in-market segments.
- **Audience Mobile Overview**: Examines mobile device usage, including device info and branding, categorized by device type (e.g., mobile, tablet, desktop).

### Technology and Behavior Reports
- **Audience Technology - Browser & Operating System**: Analyzes the technology used by the audience, including browsers and operating systems.
- **Behavior Report - All Pages**: Provides page-level behavior data.
- **Behavior Report - Events (Top Events)**: Offers insights into user interactions with the site through events.
- **Behavior Report - Landing Pages**: Focuses on landing page performance.
- **Behavior Report - Site Speed (Page Timings)**: Examines page load times.

### Conversions and Page Tracking
- **Conversions - Goal URLs**: Analyzes the effectiveness of goal completions.
- **Page Tracking**: Offers a comprehensive view of user interactions across different website pages.

### Acquisition Reports
- **Acquisition Report By All Traffic**: Covers traffic acquisition by channels and source/medium.
- **Acquisition Report by Source/Medium**: Provides acquisition data segmented by source and medium.
- **Acquisition Report by Channel Grouping**: Segments acquisition data by default channel grouping.
- **Acquisition Report by Social Network Referrals**: Analyzes acquisition data focusing on social network referrals.


## Contributing
Please feel free to fork this repository, make changes, and submit pull requests. We appreciate your contributions to improve the project!
