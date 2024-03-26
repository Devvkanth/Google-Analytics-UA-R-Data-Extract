# Set the working directory to a generic path (Modify this to your specific directory)
setwd("<Your_Directory_Path>")

# Install and load the googleAnalyticsR package for Google Analytics API access
install.packages("googleAnalyticsR")
library(googleAnalyticsR)

# Load the dplyr package for data manipulation
library(dplyr)

# Authenticate with Google Analytics
ga_auth()

# Fetch the list of available Google Analytics accounts
account_list <- ga_account_list()

# Increase the max.print option for better visibility during debugging
options(max.print=10000)

# Try printing the account list again to check details
print(account_list)

# Reset the max.print option to its default (optional)
options(max.print=99999)

# Write the account list to a CSV file in a generic directory
write.csv(account_list, "<Your_Directory_Path>/account_list.csv", row.names = FALSE)

# Replace '<Your_View_ID>' with your actual Google Analytics view ID
view_id <- "<Your_View_ID>"

# Define the start and end dates for your Google Analytics query
start_date <- "yyyy-mm-dd"
end_date <- "yyyy-mm-dd"

# Fetch audience overview data from Google Analytics
ga_data_audience_overview <- google_analytics(
  viewId = view_id,
  date_range = c(start_date, end_date),
  metrics = c("ga:exits", "ga:pageviews", "ga:newUsers", "ga:users", "ga:bounces", 
              "ga:timeOnPage", "ga:sessions", "ga:sessionDuration", "ga:uniquePageviews"),
  dimensions = c("ga:date", "ga:clientId"),
  max = -1 # Fetch all rows
)

# Display the first few rows of the audience overview data
head(ga_data_audience_overview)

# Write the audience overview data to a CSV file in a generic directory
write.csv(ga_data_audience_overview, "<Your_Directory_Path>/Google Analytics | Data View - Audience overview.csv", row.names = FALSE)


# Audience Overview Data - Behavior - Engagement
# Fetches engagement data including pageviews and sessions with their respective duration from Google Analytics
ga_data_audience_behavior_engagement <- google_analytics(
  viewId = "your_view_id", # Replace "your_view_id" with your Google Analytics view ID
  date_range = c(start_date, end_date), # Specify the start and end dates for data extraction
  metrics = c("ga:pageviews", "ga:sessions"), # Metrics to be retrieved
  dimensions = c("ga:date", "ga:sessionDurationBucket"), # Dimensions for the metrics
  max = -1 # Fetch all rows available
)
# Convert session duration bucket to numeric for analysis
ga_data_audience_behavior_engagement$sessionDurationBucket <- as.numeric(ga_data_audience_behavior_engagement$sessionDurationBucket)

# Categorize session duration into meaningful buckets for easier analysis
ga_data_audience_behavior_engagement <- ga_data_audience_behavior_engagement %>%
  mutate(DurationBucket = case_when(
    sessionDurationBucket == 0 ~ "0-10 seconds", # Assign session duration to ranges
    sessionDurationBucket <= 10 ~ "0-10 seconds",
    sessionDurationBucket <= 30 ~ "11-30 seconds",
    sessionDurationBucket <= 60 ~ "31-60 seconds",
    sessionDurationBucket <= 180 ~ "61-180 seconds",
    sessionDurationBucket <= 600 ~ "181-600 seconds",
    sessionDurationBucket <= 1800 ~ "601-1800 seconds",
    TRUE ~ "1801+ seconds" # Default case for durations longer than 1801 seconds
  ))

# Preview the processed engagement data
head(ga_data_audience_behavior_engagement)

# Save the engagement data to a CSV file in a generic directory path
write.csv(ga_data_audience_behavior_engagement, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Behavior (Engagement).csv",
          row.names = FALSE)

# Fetch audience behavior data based on frequency and recency from Google Analytics
ga_data_audience_behavior_Frequency_Recency <- google_analytics(
  viewId = "your_view_id", # Placeholder for the Google Analytics view ID
  date_range = c(start_date, end_date), # Define the date range for the query
  metrics = c("ga:pageviews", "ga:sessions"), # Metrics to be retrieved
  dimensions = c("ga:date", "ga:sessionCount"), # Dimensions for the metrics, focusing on session count
  max = -1 # Option to fetch all available rows
)

# Display the names of the columns in the retrieved data for verification
names(ga_data_audience_behavior_Frequency_Recency)

# Convert sessionCount from character to numeric to enable calculations
ga_data_audience_behavior_Frequency_Recency$sessionCount <- as.numeric(ga_data_audience_behavior_Frequency_Recency$sessionCount)

# Categorize sessions into buckets based on their count for a more granular analysis
ga_data_audience_behavior_Frequency_Recency <- ga_data_audience_behavior_Frequency_Recency %>%
  mutate(CountOfSessions = case_when(
    sessionCount == 0 ~ "0", # Assign session counts to various buckets
    between(sessionCount, 1, 1) ~ "1",
    between(sessionCount, 2, 2) ~ "2",
    between(sessionCount, 3, 3) ~ "3",
    between(sessionCount, 4, 4) ~ "4",
    between(sessionCount, 5, 5) ~ "5",
    between(sessionCount, 6, 6) ~ "6",
    between(sessionCount, 7, 7) ~ "7",
    between(sessionCount, 8, 8) ~ "8",
    between(sessionCount, 9, 14) ~ "9_14",
    between(sessionCount, 15, 25) ~ "15_25",
    between(sessionCount, 26, 50) ~ "26_50",
    between(sessionCount, 51, 100) ~ "51_100",
    between(sessionCount, 101, 200) ~ "101_200",
    sessionCount >= 201 ~ "201+", # Handle large session counts
    TRUE ~ "Unexpected Value" # Catch-all for any unexpected values
  ))

# Preview the processed data to ensure the transformations are as expected
head(ga_data_audience_behavior_Frequency_Recency)

# Save the processed data to a CSV file, with a generic path placeholder
write.csv(ga_data_audience_behavior_Frequency_Recency, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Behavior (Frequency & Recency).csv",
          row.names = FALSE)

# Fetch data on new vs returning users including various metrics and dimensions from Google Analytics
ga_data_audience_behavior_new_Return_user <- google_analytics(
  viewId = "your_view_id", # Placeholder for the Google Analytics view ID
  date_range = c(start_date, end_date), # Define the date range for the query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Metrics to be retrieved
  dimensions = c("ga:date", "ga:userType", "ga:campaign", "ga:sourceMedium",
                 "ga:landingPagePath", "ga:pageTitle", "ga:previousPagePath",
                 "ga:hostname", "ga:clientId"), # Dimensions for the metrics
  max = -1 # Option to fetch all available rows
)

# Preview the first few rows of the new vs returning users data to verify correctness
head(ga_data_audience_behavior_new_Return_user)

# Display the names of the columns in the retrieved data for verification
names(ga_data_audience_behavior_new_Return_user)

# Save the new vs returning user data to a CSV file, using a generic path placeholder
write.csv(ga_data_audience_behavior_new_Return_user, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Behavior (New vs Returning Users).csv",
          row.names = FALSE)

# Fetch data on new vs returning users without secondary dimensions for a simplified view
ga_data_audience_behavior_new_Return_user_wo_sec_dim <- google_analytics(
  viewId = "your_view_id", # Use the same placeholder as above for consistency
  date_range = c(start_date, end_date), # Match the date range to the previous query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Include the same metrics for comparison
  dimensions = c("ga:date", "ga:userType", "ga:clientId"), # Simplify dimensions for this query
  max = -1 # Ensure all available rows are fetched
)

# Preview the first few rows of the simplified new vs returning users data
head(ga_data_audience_behavior_new_Return_user_wo_sec_dim)

# Display the names of the columns in the simplified data set for verification
names(ga_data_audience_behavior_new_Return_user_wo_sec_dim)

# Save the simplified new vs returning user data to a CSV file, with a generic path placeholder
write.csv(ga_data_audience_behavior_new_Return_user_wo_sec_dim, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Behavior (New vs Returning Users)_without_Secondary_Dimensions.csv",
          row.names = FALSE)

# Audience Overview Data - Demographics - Age
# Fetch demographic data based on age from Google Analytics
ga_data_audience_demo_age <- google_analytics(
  viewId = "your_view_id", # Placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Define the date range for the query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Metrics to be retrieved
  dimensions = c("ga:date", "ga:userAgeBracket"), # Dimension to segment data by user age bracket
  max = -1 # Option to fetch all available rows
)

# Preview the first few rows of the age demographics data to ensure correct retrieval
head(ga_data_audience_demo_age)

# Display the column names of the age demographics data for verification
names(ga_data_audience_demo_age)

# Save the age demographics data to a CSV file, using a generic path placeholder
write.csv(ga_data_audience_demo_age, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Demo (Age Bracket).csv",
          row.names = FALSE)

# Audience Overview Data - Demographics - Gender
# Fetch demographic data based on gender from Google Analytics
ga_data_audience_demo_gender <- google_analytics(
  viewId = "your_view_id", # Use the same placeholder as above for consistency
  date_range = c(start_date, end_date), # Match the date range to the previous query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Include the same metrics for comparison
  dimensions = c("ga:date", "ga:userGender"), # Dimension to segment data by user gender
  max = -1 # Ensure all available rows are fetched
)

# Preview the first few rows of the gender demographics data to check accuracy
head(ga_data_audience_demo_gender)

# Display the column names of the gender demographics data for verification
names(ga_data_audience_demo_gender)

# Save the gender demographics data to a CSV file, with a generic path placeholder
write.csv(ga_data_audience_demo_gender, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Demo (Gender).csv",
          row.names = FALSE)

# Extract Google Analytics data for audience overview based on geography (country, metro, and city)
ga_data_audience_geo_country_metro_city <- google_analytics(
  viewId = "your_view_id", # Placeholder for the Google Analytics view ID
  date_range = c(start_date, end_date), # Set the date range for the data query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Define the metrics to retrieve
  dimensions = c("ga:date", "ga:campaign", "ga:sourceMedium", "ga:country",
                 "ga:city", "ga:pageTitle", "ga:hostname", "ga:clientId", "ga:metro"), # Specify dimensions for detailed geographic segmentation
  max = -1 # Retrieve all rows available for the query
)

# Display the first few rows to verify the data fetched
head(ga_data_audience_geo_country_metro_city)

# Save the geographic data (including country, metro, and city details) to a CSV file with a placeholder path
write.csv(ga_data_audience_geo_country_metro_city, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Geo (Country, Metro & City).csv",
          row.names = FALSE)

# Repeat the process for geographic data without secondary dimensions for a simplified overview
ga_data_audience_geo_country_metro_city_wo_Sec_dim <- google_analytics(
  viewId = "your_view_id", # Use the placeholder for consistency
  date_range = c(start_date, end_date), # Match date range to previous query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Include the same metrics
  dimensions = c("ga:date", "ga:country", "ga:city", "ga:clientId", "ga:metro"), # Focus on main geographic dimensions without secondary info
  max = -1 # Ensure all rows are fetched
)

# Preview the simplified geographic data to ensure correctness
head(ga_data_audience_geo_country_metro_city_wo_Sec_dim)

# Save the simplified geographic data to CSV, using a generic path placeholder
write.csv(ga_data_audience_geo_country_metro_city_wo_Sec_dim, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Geo (Country, Metro & City)_without_Secondary_Dimensions.csv",
          row.names = FALSE)

# Now, focusing on country, state, and city data for a more granular geographic analysis
ga_data_audience_geo_country_state_city <- google_analytics(
  viewId = "your_view_id", # Maintain placeholder for view ID
  date_range = c(start_date, end_date), # Use same date range for consistency
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Metrics identical to previous queries
  dimensions = c("ga:date", "ga:campaign", "ga:sourceMedium", "ga:country",
                 "ga:city", "ga:pageTitle", "ga:hostname", "ga:clientId", "ga:region"), # Add region for state-level data
  max = -1 # Retrieve all available data
)

# Check the first few rows of the country, state, and city data
head(ga_data_audience_geo_country_state_city)

# Export the detailed geographic data to CSV with a generic directory path
write.csv(ga_data_audience_geo_country_state_city, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Geo (Country, State & City).csv",
          row.names = FALSE)

# Retrieve geographic data from Google Analytics focusing on country, city, and state (region) without secondary dimensions
ga_data_audience_geo_country_state_city_wo_Sec_dim <- google_analytics(
  viewId = "your_view_id", # Replace with your actual Google Analytics view ID
  date_range = c(start_date, end_date), # Define the start and end dates for the data query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Metrics to be retrieved from Google Analytics
  dimensions = c("ga:date", "ga:country", "ga:city", "ga:clientId", "ga:region"), # Geographic dimensions for analysis without secondary dimensions
  max = -1 # Option to fetch all available rows
)

# Preview the first few rows of the dataset to check its structure and data
head(ga_data_audience_geo_country_state_city_wo_Sec_dim)

# Save the geographic data (focusing on country, state, and city) to a CSV file with a generic path
write.csv(ga_data_audience_geo_country_state_city_wo_Sec_dim, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Geo (Country, State & City)_without_Secondary_Dimensions.csv",
          row.names = FALSE)

# Extract Google Analytics data on audience interests based on affinity categories
ga_data_audience_interests_affinity_category <- google_analytics(
  viewId = "your_view_id", # Placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Define the date range for the query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Metrics to be retrieved
  dimensions = c("ga:date", "ga:interestAffinityCategory"), # Dimension focusing on affinity categories
  max = -1 # Option to fetch all available rows
)

# Preview the affinity category data to ensure correct retrieval
head(ga_data_audience_interests_affinity_category)

# Save the affinity category data to a CSV file, replacing path with a placeholder
write.csv(ga_data_audience_interests_affinity_category, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Interests (Affinity Category).csv",
          row.names = FALSE)

# Extract data on audience interests focusing on in-market segments
ga_data_audience_interests_in_market_segments <- google_analytics(
  viewId = "your_view_id", # Use consistent placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Match date range to previous query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Include identical metrics for comparison
  dimensions = c("ga:date", "ga:interestInMarketCategory"), # Dimension for in-market segments
  max = -1 # Ensure all rows are fetched
)

# Check the first few rows of in-market segment data for accuracy
head(ga_data_audience_interests_in_market_segments)

# Save the in-market segment data to CSV, using a generic path placeholder
write.csv(ga_data_audience_interests_in_market_segments, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Interests (In-Market Segments).csv",
          row.names = FALSE)

# Fetch Google Analytics data for audience mobile device usage
ga_data_audience_report_mobile <- google_analytics(
  viewId = "your_view_id", # Maintain placeholder for view ID
  date_range = c(start_date, end_date), # Use same date range for consistency
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Metrics identical to previous queries
  dimensions = c("ga:sourceMedium", "ga:date", "ga:landingPagePath", "ga:hostname",
                 "ga:campaign", "ga:pageTitle", "ga:clientId", "ga:mobileDeviceInfo",
                 "ga:mobileDeviceBranding"), # Dimensions focusing on mobile device information
  max = -1 # Retrieve all available data
)

# Preview the mobile device usage data to verify its structure
head(ga_data_audience_report_mobile)

# Export the mobile device data to CSV with a placeholder for the directory path
write.csv(ga_data_audience_report_mobile, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Mobile (Devices).csv",
          row.names = FALSE)

# Audience Overview Data - Report - Mobile - Device Category
# Fetch data on mobile device categories used by the audience
ga_data_audience_report_mobile_device_category <- google_analytics(
  viewId = "your_view_id", # Placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Specify the date range for data extraction
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Metrics to be retrieved
  dimensions = c("ga:sourceMedium", "ga:date", "ga:landingPagePath", "ga:hostname",
                 "ga:campaign", "ga:previousPagePath", "ga:clientId", "ga:pageTitle",
                 "ga:deviceCategory"), # Dimensions focusing on mobile device category
  max = -1 # Option to fetch all available rows
)

# Preview the mobile device category data
head(ga_data_audience_report_mobile_device_category)

# Save the mobile device category data to a CSV file with a placeholder path
write.csv(ga_data_audience_report_mobile_device_category, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Mobile Overview (Device Category).csv",
          row.names = FALSE)

# Audience Overview Data - Report - Technology - Browser & OS
# Extract data on technology used by the audience, including browser and operating system
ga_data_audience_report_Technology_Browser_OS <- google_analytics(
  viewId = "your_view_id", # Use consistent placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Match date range to previous queries
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Include identical metrics for comparison
  dimensions = c("ga:date", "ga:browser", "ga:browserSize", "ga:browserVersion",
                 "ga:screenResolution", "ga:operatingSystem", "ga:javaEnabled",
                 "ga:clientId"), # Dimensions for detailed technology data
  max = -1 # Ensure all rows are fetched
)

# Check the first few rows of technology usage data
head(ga_data_audience_report_Technology_Browser_OS)

# Export the technology usage data to CSV, using a generic path placeholder
write.csv(ga_data_audience_report_Technology_Browser_OS, 
          "<Your_Directory_Path>/Google Analytics | Data View - Audience Report by Technology (Browser & OS).csv",
          row.names = FALSE)

# Behavior Data - Report - All Pages
# Retrieve data on all page views to understand audience behavior
ga_data_behavior_report_allpages <- google_analytics(
  viewId = "your_view_id", # Consistent placeholder for view ID
  date_range = c(start_date, end_date), # Use same date range for consistency
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:uniquePageviews",
              "ga:sessionDuration"), # Metrics identical to previous queries
  dimensions = c("ga:sourceMedium", "ga:date", "ga:channelGrouping", "ga:pageTitle",
                 "ga:pagePath", "ga:campaign", "ga:clientId"), # Dimensions for detailed page behavior analysis
  max = -1 # Retrieve all available data
)

# Preview the all pages behavior data
head(ga_data_behavior_report_allpages)

# Save the all pages behavior data to CSV with a placeholder for the directory path
write.csv(ga_data_behavior_report_allpages, 
          "<Your_Directory_Path>/Google Analytics | Data View - Behavior - All Pages.csv",
          row.names = FALSE)

# Behavior Data - Event - Top Events
# Retrieve top event data to analyze user interactions with the site
ga_data_behavior_event_topevent <- google_analytics(
  viewId = "your_view_id", # Placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Specify the date range for data extraction
  metrics = c("ga:totalEvents", "ga:uniqueEvents"), # Metrics focused on event tracking
  dimensions = c("ga:sourceMedium", "ga:date", "ga:campaign", "ga:clientId",
                 "ga:pagePath", "ga:pageTitle", "ga:eventAction", "ga:eventCategory",
                 "ga:eventLabel"), # Dimensions to provide context to the events
  max = -1 # Option to fetch all available rows
)

# Preview top events data to ensure accuracy
head(ga_data_behavior_event_topevent)

# Save top events data to a CSV file with a generic path
write.csv(ga_data_behavior_event_topevent, 
          "<Your_Directory_Path>/Google Analytics | Data View - Behavior - Events - Top Events.csv",
          row.names = FALSE)

# Behavior Data - Landing Pages
# Extract data on landing pages to understand initial user engagement
ga_data_behavior_landingpages <- google_analytics(
  viewId = "your_view_id", # Consistent placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Match date range to previous queries
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:uniquePageviews", "ga:sessionDuration", "ga:timeOnPage",
              "ga:exits"), # Metrics to analyze landing page performance
  dimensions = c("ga:sourceMedium", "ga:date", "ga:channelGrouping", "ga:campaign",
                 "ga:clientId", "ga:landingPagePath"), # Dimensions focusing on landing page details
  max = -1 # Ensure all rows are fetched
)

# Check the first few rows of landing pages data
head(ga_data_behavior_landingpages)

# Export landing pages data to CSV, using a generic path placeholder
write.csv(ga_data_behavior_landingpages, 
          "<Your_Directory_Path>/Google Analytics | Data View - Behavior - Landing Pages.csv",
          row.names = FALSE)

# Behavior Data - Page Timings
# Retrieve data on page load times to assess site speed and user experience
ga_data_behavior_pagetimings <- google_analytics(
  viewId = "your_view_id", # Maintain placeholder for view ID for consistency
  date_range = c(start_date, end_date), # Use same date range for consistency
  metrics = c("ga:pageviews", "ga:pageLoadTime", "ga:pageLoadSample"), # Metrics focused on page timing
  dimensions = c("ga:sourceMedium", "ga:date", "ga:channelGrouping", "ga:campaign",
                 "ga:clientId", "ga:pagePath", "ga:pageTitle"), # Dimensions to provide context to timing data
  max = -1 # Retrieve all available data
)

# Preview page timing data to ensure it's correctly fetched
head(ga_data_behavior_pagetimings)

# Save page timing data to CSV with a placeholder for the directory path
write.csv(ga_data_behavior_pagetimings, 
          "<Your_Directory_Path>/Google Analytics | Data View - Behavior - Site Speed - Page Timings.csv",
          row.names = FALSE)

# Conversions - Goals URLs
# Retrieve conversion goal URLs data to analyze the effectiveness of goal completions
ga_data_conversion_goalurls <- google_analytics(
  viewId = "your_view_id", # Placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Define the date range for data extraction
  metrics = c("ga:goalCompletionsAll"), # Metric focused on total goal completions
  dimensions = c("ga:goalCompletionLocation", "ga:goalPreviousStep1",
                 "ga:goalPreviousStep2", "ga:goalPreviousStep3", "ga:date"), # Dimensions to understand the path to conversion
  max = -1 # Option to fetch all available rows
)

# Preview the goal URLs data to verify correctness
head(ga_data_conversion_goalurls)

# Export the goal URLs data to a CSV file, using a generic path placeholder
write.csv(ga_data_conversion_goalurls, 
          "<Your_Directory_Path>/Google Analytics | Data View - Conversions - Goal URLs.csv",
          row.names = FALSE)

# Page Tracking
# Extract data on page tracking to understand user interaction across the website
ga_data_page_tracking <- google_analytics(
  viewId = "your_view_id", # Use consistent placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Match date range to previous queries
  metrics = c("ga:sessions", "ga:pageviews", "ga:uniquePageviews",
              "ga:timeOnPage", "ga:exits", "ga:entrances"), # Metrics to analyze page interactions
  dimensions = c("ga:pageTitle", "ga:pagePath", "ga:hostname",
                 "ga:landingPagePath", "ga:previousPagePath", "ga:pagePathLevel1",
                 "ga:pagePathLevel2", "ga:pagePathLevel3", "ga:date"), # Dimensions for detailed page interaction context
  max = -1 # Ensure all rows are fetched
)

# Check the first few rows of page tracking data
head(ga_data_page_tracking)

# Save page tracking data to CSV with a generic directory path placeholder
write.csv(ga_data_page_tracking, 
          "<Your_Directory_Path>/Google Analytics | Data View - Page Tracking.csv",
          row.names = FALSE)

# Acquisition Report By All Traffic (Channels & Source/Medium)
# Retrieve data on traffic acquisition to analyze sources and mediums contributing to site traffic
ga_data_acquisition_report_all_traffic <- google_analytics(
  viewId = "your_view_id", # Maintain placeholder for view ID for consistency
  date_range = c(start_date, end_date), # Use same date range for consistency
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:sessionDuration"), # Metrics focused on acquisition and user behavior
  dimensions = c("ga:date", "ga:channelGrouping", "ga:campaign", "ga:landingPagePath",
                 "ga:pageTitle", "ga:hostname", "ga:clientId", "ga:sourceMedium",
                 "ga:pagePath"), # Dimensions to provide a comprehensive view of traffic sources
  max = -1 # Retrieve all available data
)

# Preview the acquisition report data to ensure accuracy
head(ga_data_acquisition_report_all_traffic)

# Export the acquisition report data to CSV, using a placeholder for the directory path
write.csv(ga_data_acquisition_report_all_traffic, 
          "<Your_Directory_Path>/Google Analytics | Data View - Acquisition Report By All Traffic (Channels & Source_Medium).csv",
          row.names = FALSE)

# Acquisition Report by Source/Medium
# Extract acquisition data from Google Analytics by source and medium
ga_data_acquisition_report_source_medium <- google_analytics(
  viewId = "your_view_id", # Placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Define the date range for the data query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:sessionDuration"), # Metrics to be retrieved
  dimensions = c("ga:date", "ga:sourceMedium","ga:clientId"), # Dimensions for data segmentation by source and medium
  max = -1 # Option to fetch all available rows
)

# Preview source/medium data to ensure correctness
head(ga_data_acquisition_report_source_medium)

# Export the source/medium data to a CSV file, using a generic path placeholder
write.csv(ga_data_acquisition_report_source_medium, 
          "<Your_Directory_Path>/Google Analytics | Data View - Acquisition Report By sourcemedium.csv",
          row.names = FALSE)

# Acquisition Report by Channel Grouping
# Retrieve acquisition data segmented by default channel grouping
ga_data_acquisition_report_defaultchannelGrouping <- google_analytics(
  viewId = "your_view_id", # Use consistent placeholder for Google Analytics view ID
  date_range = c(start_date, end_date), # Match date range to previous query
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:timeOnPage", "ga:exits", "ga:sessionDuration"), # Include identical metrics for comparison
  dimensions = c("ga:date", "ga:channelGrouping","ga:clientId"), # Dimension focusing on channel grouping
  max = -1 # Ensure all rows are fetched
)

# Check the first few rows of channel grouping data
head(ga_data_acquisition_report_defaultchannelGrouping)

# Save the channel grouping data to CSV, using a generic path placeholder
write.csv(ga_data_acquisition_report_defaultchannelGrouping, 
          "<Your_Directory_Path>/Google Analytics | Data View - Acquisition Report By defaultchannelGrouping.csv",
          row.names = FALSE)

# Acquisition Report by Social Network Referrals
# Analyze acquisition data focusing on social network referrals
ga_data_acquisition_social_networkreferrals <- google_analytics(
  viewId = "your_view_id", # Maintain placeholder for view ID for consistency
  date_range = c(start_date, end_date), # Use same date range for consistency
  metrics = c("ga:newUsers", "ga:sessions", "ga:bounces", "ga:pageviews",
              "ga:users", "ga:uniquePageviews", "ga:sessionDuration", "ga:timeOnPage",
              "ga:exits"), # Metrics focused on social network referral performance
  dimensions = c("ga:date", "ga:socialNetwork", "ga:landingPagePath",
                 "ga:clientId", "ga:hostname", "ga:campaign", "ga:sourceMedium",
                 "ga:pagePath", "ga:pageTitle"), # Dimensions to provide context on social referrals
  max = -1 # Retrieve all available data
)

# Preview the social network referral data
head(ga_data_acquisition_social_networkreferrals)

# Export the social network referral data to CSV, using a placeholder for the directory path
write.csv(ga_data_acquisition_social_networkreferrals, 
          "<Your_Directory_Path>/Google Analytics | Data View - Acquisition By Social (Network Referrals).csv",
          row.names = FALSE)
