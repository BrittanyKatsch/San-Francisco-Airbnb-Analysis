
#Brittany Katsch
#Final Project
#Predict Airbnb listings prices in San Francisco

#.................................................................................................................................

#additional packages used in this project

#dplyr - for data transformation
#tidyr - for data transformation
#ggplot2 - for data vizualizations
#gridExtra - for data vizualizations

#.................................................................................................................................

#set working directory for the project
setwd("/Users/B/Desktop/UCLA/Intro to Data Science/SFProject")
getwd()

#load the data frame
listings <- read.csv("./listings.csv")

#get an overview of the dataframe to better understand the data. Using str() shows there are 8,111 observations of 106 variables.

str(listings)
# 'data.frame':	8111 obs. of  106 variables:
# $ id                                          : int  958 3850 5858 7918 8142 8339 8739 9225 10251 10578 ...
# $ listing_url                                 : Factor w/ 8111 levels "https://www.airbnb.com/rooms/10000431",..: 8047 6519 7245 7695 7766 7814 7897 7985 46 108 ...
# $ scrape_id                                   : num  2.02e+13 2.02e+13 2.02e+13 2.02e+13 2.02e+13 ...
# $ last_scraped                                : Factor w/ 1 level "10/14/19": 1 1 1 1 1 1 1 1 1 1 ...
# $ name                                        : Factor w/ 7788 levels " Master bedroom with private bath",..: 1463 1768 2425 634 2947 3405 4300 821 7605 1935 ...
# $ summary                                     : Factor w/ 6524 levels "","    Large and sunny one bedroom with views of Candlestick Park and the Bay. Easy access to the South Bay and Do"| __truncated__,..: 3257 6493 1 3355 3355 3885 6162 533 1 354 ...
# $ space                                       : Factor w/ 5698 levels "","______________________________________ SAN FRANCISCO SHORT-TERM RESIDENTIAL RENTAL REGISTRATION NUMBER: STR-OOO"| __truncated__,..: 2223 4808 5283 3114 3114 2810 5689 1755 2804 1227 ...
# $ description                                 : Factor w/ 7183 levels "","    Large and sunny one bedroom with views of Candlestick Park and the Bay. Easy access to the South Bay and Do"| __truncated__,..: 3653 7153 6729 3756 3756 4328 6795 568 4312 377 ...
# $ experiences_offered                         : Factor w/ 1 level "none": 1 1 1 1 1 1 1 1 1 1 ...
# $ neighborhood_overview                       : Factor w/ 4568 levels "","    The Mission is an interesting spot. You will see colors on the walls and amongst the locals. It's lively an"| __truncated__,..: 62 3807 975 2504 1 1 1251 1101 1644 4023 ...
# $ notes                                       : Factor w/ 3660 levels ""," I do have two rooms that I rent on Airbnb so you may share the house other travelers, my roommate or myself. T"| __truncated__,..: 806 1017 535 3569 3569 2318 3419 1 2122 1 ...
# $ transit                                     : Factor w/ 4504 levels ""," It is a short downhill walk to catch busses, subways or streetcar to take you in any direction. The same bus o"| __truncated__,..: 103 2323 3269 1910 1912 1 1502 3317 2616 2932 ...
# $ access                                      : Factor w/ 4266 levels ""," apartment to yourself, no sharing",..: 64 568 2172 1 1 1246 4165 2023 3462 2449 ...
# $ interaction                                 : Factor w/ 4130 levels "","- My partner and I both live here full time.  - We get ready and leave between 7-10AM weekdays. Wednesdays we m"| __truncated__,..: 35 1101 1 1 1 1 3000 2965 439 2803 ...
# $ house_rules                                 : Factor w/ 4268 levels "","_Where to smoke_ Please don’t smoke in the house, you can smoke on the back patio if you’d like. _Dishes_ There"| __truncated__,..: 1150 1468 3136 2221 2227 1802 3078 4027 1510 2604 ...
# $ thumbnail_url                               : logi  NA NA NA NA NA NA ...
# $ medium_url                                  : logi  NA NA NA NA NA NA ...
# $ picture_url                                 : Factor w/ 7755 levels "https://a0.muscache.com/4ea/air/v2//pictures/00fb272c-95e8-469a-a3ab-a43951f64da1.jpg?t=r:w1200-h720-sfit,e:fjpg-c85",..: 5967 5945 1084 1586 1643 1382 4400 4398 1927 1427 ...
# $ xl_picture_url                              : logi  NA NA NA NA NA NA ...
# $ host_id                                     : int  1169 4921 8904 21994 21994 24215 7149 29674 35199 37049 ...
# $ host_url                                    : Factor w/ 4303 levels "https://www.airbnb.com/users/show/10001067",..: 289 3080 4100 1509 1509 1753 3723 2222 2491 2573 ...
# $ host_name                                   : Factor w/ 2173 levels "","(Email hidden by Airbnb)",..: 788 1101 1580 9 9 1714 833 674 1700 102 ...
# $ host_since                                  : Factor w/ 2324 levels "","1/1/12","1/1/13",..: 1868 717 969 1526 1526 1780 115 2089 2082 2312 ...
# $ host_location                               : Factor w/ 177 levels ""," California, United States",..: 146 146 146 146 146 146 146 146 146 146 ...
# $ host_about                                  : Factor w/ 3134 levels "","\n","\nMy home is very comfortable and relaxed.  I like to provide fine linens and towels.  When I travel I apprecia"| __truncated__,..: 2822 1002 2501 71 71 1861 2051 2722 281 1821 ...
# $ host_response_time                          : Factor w/ 6 levels "","a few days or more",..: 4 6 4 6 6 5 6 6 5 5 ...
# $ host_response_rate                          : Factor w/ 45 levels "","0%","10%",..: 4 4 26 32 32 4 4 4 4 4 ...
# $ host_acceptance_rate                        : Factor w/ 2 levels "","N/A": 2 2 2 2 2 2 2 2 2 2 ...
# $ host_is_superhost                           : Factor w/ 3 levels "","f","t": 3 3 2 3 3 2 3 3 3 2 ...
# $ host_thumbnail_url                          : Factor w/ 4295 levels "","https://a0.muscache.com/defaults/user_pic-50x50.png?v=3",..: 1177 746 4224 3262 3262 1900 4076 3477 3596 2065 ...
# $ host_picture_url                            : Factor w/ 4295 levels "","https://a0.muscache.com/defaults/user_pic-225x225.png?v=3",..: 1177 746 4224 3262 3262 1900 4076 3477 3596 2065 ...
# $ host_neighbourhood                          : Factor w/ 139 levels "","Alameda","Alamo Square",..: 35 57 12 25 25 3 79 98 79 85 ...
# $ host_listings_count                         : int  1 2 2 10 10 2 2 1 1 0 ...
# $ host_total_listings_count                   : int  1 2 2 10 10 2 2 1 1 0 ...
# $ host_verifications                          : Factor w/ 248 levels "['email', 'offline_government_id', 'selfie', 'government_id', 'identity_manual']",..: 54 157 179 157 157 180 179 54 54 157 ...
# $ host_has_profile_pic                        : Factor w/ 3 levels "","f","t": 3 3 3 3 3 3 3 3 3 3 ...
# $ host_identity_verified                      : Factor w/ 3 levels "","f","t": 3 3 3 3 3 3 2 3 3 3 ...
# $ street                                      : Factor w/ 12 levels "Brisbane, CA, United States",..: 7 7 7 7 7 7 7 7 7 7 ...
# $ neighbourhood                               : Factor w/ 56 levels "","Alamo Square",..: 15 24 5 8 8 2 30 40 30 32 ...
# $ neighbourhood_cleansed                      : Factor w/ 37 levels "Bayview","Bernal Heights",..: 37 14 2 12 12 37 17 27 17 18 ...
# $ neighbourhood_group_cleansed                : logi  NA NA NA NA NA NA ...
# $ city                                        : Factor w/ 9 levels "","Brisbane",..: 5 5 5 5 5 5 5 5 5 5 ...
# $ state                                       : Factor w/ 3 levels "","Ca","CA": 3 3 3 3 3 3 3 3 3 3 ...
# $ zipcode                                     : Factor w/ 45 levels "","94014","94015",..: 18 27 11 18 18 18 11 8 11 10 ...
# $ market                                      : Factor w/ 3 levels "","D.C.","San Francisco": 3 3 3 3 3 3 3 3 3 3 ...
# $ smart_location                              : Factor w/ 12 levels "Brisbane, CA",..: 8 8 8 8 8 8 8 8 8 8 ...
# $ country_code                                : Factor w/ 1 level "US": 1 1 1 1 1 1 1 1 1 1 ...
# $ country                                     : Factor w/ 1 level "United States": 1 1 1 1 1 1 1 1 1 1 ...
# $ latitude                                    : num  37.8 37.8 37.7 37.8 37.8 ...
# $ longitude                                   : num  -122 -122 -122 -122 -122 ...
# $ is_location_exact                           : Factor w/ 2 levels "f","t": 2 2 2 2 2 2 2 2 2 2 ...
# $ property_type                               : Factor w/ 26 levels "Aparthotel","Apartment",..: 2 17 2 2 2 17 9 17 17 2 ...
# $ room_type                                   : Factor w/ 4 levels "Entire home/apt",..: 1 3 1 3 3 1 3 3 1 1 ...
# $ accommodates                                : int  3 2 5 2 2 4 3 2 4 2 ...
# $ bathrooms                                   : num  1 1 1 4 4 1.5 1 1 1 1 ...
# $ bedrooms                                    : int  1 1 2 1 1 2 1 1 2 0 ...
# $ beds                                        : int  2 1 3 1 1 2 2 1 3 1 ...
# $ bed_type                                    : Factor w/ 5 levels "Airbed","Couch",..: 5 5 5 5 5 5 5 5 5 5 ...
# $ amenities                                   : Factor w/ 6932 levels "{\"Air conditioning\",Kitchen,Heating,Washer,Dryer,Essentials,\"translation missing: en.hosting_amenity_49\",\""| __truncated__,..: 1572 389 436 3367 3312 3300 730 1558 1131 1654 ...
# $ square_feet                                 : int  NA NA NA NA NA NA NA NA NA NA ...
# $ price                                       : Factor w/ 526 levels "$0.00 ","$1,000.00 ",..: 111 523 188 437 437 494 80 76 178 61 ...
# $ weekly_price                                : Factor w/ 318 levels "","$1,000.00 ",..: 21 1 91 199 201 1 1 2 81 28 ...
# $ monthly_price                               : Factor w/ 311 levels "","$1,000.00 ",..: 187 1 240 33 33 1 310 176 235 108 ...
# $ security_deposit                            : Factor w/ 95 levels "","$0.00 ","$1,000.00 ",..: 20 2 1 41 41 2 2 1 73 73 ...
# $ cleaning_fee                                : Factor w/ 189 levels "","$0.00 ","$10.00 ",..: 4 3 4 150 150 68 150 150 4 174 ...
# $ guests_included                             : int  2 2 2 1 1 2 2 1 1 2 ...
# $ extra_people                                : Factor w/ 79 levels "$0.00 ","$10.00 ",..: 32 27 1 7 7 15 64 1 1 1 ...
# $ minimum_nights                              : int  1 1 30 32 32 6 1 1 30 30 ...
# $ maximum_nights                              : int  30 5 60 60 90 1125 14 365 60 180 ...
# $ minimum_minimum_nights                      : int  1 1 30 32 32 6 1 1 30 30 ...
# $ maximum_minimum_nights                      : int  1 1 30 32 32 6 1 1 30 30 ...
# $ minimum_maximum_nights                      : int  30 5 60 60 90 1125 14 365 60 180 ...
# $ maximum_maximum_nights                      : int  30 5 60 60 90 1125 14 365 60 180 ...
# $ minimum_nights_avg_ntm                      : num  1 1 30 32 32 6 1 1 30 30 ...
# $ maximum_nights_avg_ntm                      : num  30 5 60 60 90 ...
# $ calendar_updated                            : Factor w/ 64 levels "1 week ago","10 months ago",..: 13 25 27 26 26 56 14 12 39 13 ...
# $ has_availability                            : Factor w/ 1 level "t": 1 1 1 1 1 1 1 1 1 1 ...
# $ availability_30                             : int  3 5 0 30 30 30 7 15 13 0 ...
# $ availability_60                             : int  8 32 0 60 60 60 21 41 43 27 ...
# $ availability_90                             : int  16 62 0 90 90 90 47 71 73 57 ...
# $ availability_365                            : int  85 62 0 365 365 90 135 344 348 332 ...
# $ calendar_last_scraped                       : Factor w/ 1 level "10/14/19": 1 1 1 1 1 1 1 1 1 1 ...
# $ number_of_reviews                           : int  217 160 111 18 8 28 704 511 337 18 ...
# $ number_of_reviews_ltm                       : int  52 36 0 1 0 1 87 82 33 0 ...
# $ first_review                                : Factor w/ 2244 levels "","1/1/14","1/1/15",..: 1688 1635 1327 1980 2233 2155 1800 287 2057 595 ...
# $ last_review                                 : Factor w/ 834 levels "","1/1/18","1/1/19",..: 787 819 730 750 753 533 126 130 462 438 ...
# $ review_scores_rating                        : int  97 94 98 86 93 97 98 94 96 99 ...
# $ review_scores_accuracy                      : int  10 10 10 8 9 10 10 10 10 10 ...
# $ review_scores_cleanliness                   : int  10 10 10 8 9 10 10 9 10 10 ...
# $ review_scores_checkin                       : int  10 10 10 9 10 10 10 10 10 10 ...
# $ review_scores_communication                 : int  10 10 10 9 10 10 10 10 10 10 ...
# $ review_scores_location                      : int  10 10 10 9 9 10 10 10 10 10 ...
# $ review_scores_value                         : int  9 10 9 8 9 10 9 9 9 10 ...
# $ requires_license                            : Factor w/ 2 levels "f","t": 2 2 2 2 2 2 2 2 2 2 ...
# $ license                                     : Factor w/ 2555 levels "","\"City registration pending\"",..: 995 627 1 1 1 589 444 540 1100 1 ...
# $ jurisdiction_names                          : Factor w/ 2 levels "","{\"SAN FRANCISCO\"}": 2 2 2 2 2 2 2 2 2 2 ...
# $ instant_bookable                            : Factor w/ 2 levels "f","t": 1 1 1 1 1 1 2 1 1 1 ...
# $ is_business_travel_ready                    : Factor w/ 1 level "f": 1 1 1 1 1 1 1 1 1 1 ...
# $ cancellation_policy                         : Factor w/ 6 levels "flexible","moderate",..: 2 4 4 4 4 2 4 4 2 2 ...
# [list output truncated]


colnames(listings) #get a better look at the variables. The column names seem to be workable; they are in R friendly format and are descriptive.

# [1] "id"                                           "listing_url"                                  "scrape_id"                                   
# [4] "last_scraped"                                 "name"                                         "summary"                                     
# [7] "space"                                        "description"                                  "experiences_offered"                         
# [10] "neighborhood_overview"                        "notes"                                        "transit"                                     
# [13] "access"                                       "interaction"                                  "house_rules"                                 
# [16] "thumbnail_url"                                "medium_url"                                   "picture_url"                                 
# [19] "xl_picture_url"                               "host_id"                                      "host_url"                                    
# [22] "host_name"                                    "host_since"                                   "host_location"                               
# [25] "host_about"                                   "host_response_time"                           "host_response_rate"                          
# [28] "host_acceptance_rate"                         "host_is_superhost"                            "host_thumbnail_url"                          
# [31] "host_picture_url"                             "host_neighbourhood"                           "host_listings_count"                         
# [34] "host_total_listings_count"                    "host_verifications"                           "host_has_profile_pic"                        
# [37] "host_identity_verified"                       "street"                                       "neighbourhood"                               
# [40] "neighbourhood_cleansed"                       "neighbourhood_group_cleansed"                 "city"                                        
# [43] "state"                                        "zipcode"                                      "market"                                      
# [46] "smart_location"                               "country_code"                                 "country"                                     
# [49] "latitude"                                     "longitude"                                    "is_location_exact"                           
# [52] "property_type"                                "room_type"                                    "accommodates"                                
# [55] "bathrooms"                                    "bedrooms"                                     "beds"                                        
# [58] "bed_type"                                     "amenities"                                    "square_feet"                                 
# [61] "price"                                        "weekly_price"                                 "monthly_price"                               
# [64] "security_deposit"                             "cleaning_fee"                                 "guests_included"                             
# [67] "extra_people"                                 "minimum_nights"                               "maximum_nights"                              
# [70] "minimum_minimum_nights"                       "maximum_minimum_nights"                       "minimum_maximum_nights"                      
# [73] "maximum_maximum_nights"                       "minimum_nights_avg_ntm"                       "maximum_nights_avg_ntm"                      
# [76] "calendar_updated"                             "has_availability"                             "availability_30"                             
# [79] "availability_60"                              "availability_90"                              "availability_365"                            
# [82] "calendar_last_scraped"                        "number_of_reviews"                            "number_of_reviews_ltm"                       
# [85] "first_review"                                 "last_review"                                  "review_scores_rating"                        
# [88] "review_scores_accuracy"                       "review_scores_cleanliness"                    "review_scores_checkin"                       
# [91] "review_scores_communication"                  "review_scores_location"                       "review_scores_value"                         
# [94] "requires_license"                             "license"                                      "jurisdiction_names"                          
# [97] "instant_bookable"                             "is_business_travel_ready"                     "cancellation_policy"                         
# [100] "require_guest_profile_picture"                "require_guest_phone_verification"             "calculated_host_listings_count"              
# [103] "calculated_host_listings_count_entire_homes"  "calculated_host_listings_count_private_rooms" "calculated_host_listings_count_shared_rooms" 
# [106] "reviews_per_month"

# There are irrelevent columns that I will not be using in the analysis, so it makes sense to get rid of them now.
# I will remove;"listings_url" "scrape_id" "last_scraped" "name" "summary" "space" "description" "neighborhood_overview" "notes" "transit"
# "access" "interaction" "thumbnail_url" "medium_url" "picture_url" "xl_picture_url" "host_url" "host_name" "host_about" "host_acceptance_rate"
# "host_thumbnail_url" "host_picture_url" "street" "neighbourhood" "neighborhood_group_cleansed" "country""minimum_minimum_nights" "maximum_minimum_nights"
# "minimum_maximum_nights" "maximum_maximum_nights" "minimum_nights_avg_ntm" "maximum_nights_avg_ntm" "calendar_last_scraped" "requires_liscence" "liscence"
# "jurisdiction_names" "country_code" "is_location_exact" "host_listings_count" "host_has_profile_pic" "has_avaliability" "availability_30" "availability_60" 
# "availability_90" "availability_365" "calculated_host_listings_count_private_rooms" "calculated_host_listings_count_shared_rooms"
# "calculated_host_listings_count_entire_homes" "calculated_host_listings_count" "house_rules" "host_location" "host_response_rate" "smart_location"
# "host_response_time" "host_neighbourhood" "state" "calendar_updated" "number_of_reviews_ltm" "first_review" 'last_review" "reviews_per_month" "host_since"
# "id" "host_id" "host_total_listings_count" "host_identity_verified" "require_guest_profile_picture" "require_guest_phone_verification"

new_listings <- subset(listings, select = -c(listing_url,scrape_id, last_scraped, name, summary, space, description, neighborhood_overview, notes, transit,
                                             access, interaction, thumbnail_url, medium_url, picture_url, xl_picture_url, host_url, host_name, host_about, 
                                             host_acceptance_rate, host_thumbnail_url, host_picture_url, street, neighbourhood, neighbourhood_group_cleansed, country, 
                                             minimum_minimum_nights, maximum_minimum_nights, minimum_maximum_nights, maximum_maximum_nights, minimum_nights_avg_ntm, 
                                             maximum_nights_avg_ntm, calendar_last_scraped, requires_license, license, jurisdiction_names, country_code, is_location_exact,
                                             host_listings_count, host_has_profile_pic, has_availability, availability_30, availability_60, availability_90, 
                                             availability_365, calculated_host_listings_count_private_rooms, calculated_host_listings_count_shared_rooms,
                                             calculated_host_listings_count_entire_homes, calculated_host_listings_count, house_rules, host_location, host_response_rate,
                                             smart_location, host_response_time, host_neighbourhood, state, calendar_updated, number_of_reviews_ltm, first_review, last_review,
                                             reviews_per_month, host_since, host_id, id, host_total_listings_count, host_identity_verified, require_guest_profile_picture,
                                             require_guest_phone_verification, host_verifications))

summary(new_listings)  
#from the summary, I am able to see that the variable "experiences_offered" are all 'none'. So, I can get rid of that  column as well. "square_feet"
#has 7,987 NA's, so it makes sense to drop that  column altogether. the variable "is_business_travel_ready" is 'f' for all rows, so I can eliminate that column.
#since the goal is to predict nightly price, I will remove "weekly_price" and "monthly_price" becuase they are not relevent to the project

listings_cleaned <- subset(new_listings, select = -c(experiences_offered, square_feet, is_business_travel_ready, weekly_price, monthly_price))

str(listings_cleaned)
#I now have 8,111 observations of 32 relevent variables.

# # 'data.frame':	8111 obs. of  32 variables:
# $ host_is_superhost          : Factor w/ 3 levels "","f","t": 3 3 2 3 3 2 3 3 3 2 ...
# $ neighbourhood_cleansed     : Factor w/ 37 levels "Bayview","Bernal Heights",..: 37 14 2 12 12 37 17 27 17 18 ...
# $ city                       : Factor w/ 9 levels "","Brisbane",..: 5 5 5 5 5 5 5 5 5 5 ...
# $ zipcode                    : Factor w/ 45 levels "","94014","94015",..: 18 27 11 18 18 18 11 8 11 10 ...
# $ market                     : Factor w/ 3 levels "","D.C.","San Francisco": 3 3 3 3 3 3 3 3 3 3 ...
# $ latitude                   : num  37.8 37.8 37.7 37.8 37.8 ...
# $ longitude                  : num  -122 -122 -122 -122 -122 ...
# $ property_type              : Factor w/ 26 levels "Aparthotel","Apartment",..: 2 17 2 2 2 17 9 17 17 2 ...
# $ room_type                  : Factor w/ 4 levels "Entire home/apt",..: 1 3 1 3 3 1 3 3 1 1 ...
# $ accommodates               : int  3 2 5 2 2 4 3 2 4 2 ...
# $ bathrooms                  : num  1 1 1 4 4 1.5 1 1 1 1 ...
# $ bedrooms                   : int  1 1 2 1 1 2 1 1 2 0 ...
# $ beds                       : int  2 1 3 1 1 2 2 1 3 1 ...
# $ bed_type                   : Factor w/ 5 levels "Airbed","Couch",..: 5 5 5 5 5 5 5 5 5 5 ...
# $ amenities                  : Factor w/ 6932 levels "{\"Air conditioning\",Kitchen,Heating,Washer,Dryer,Essentials,\"translation missing: en.hosting_amenity_49\",\""| __truncated__,..: 1572 389 436 3367 3312 3300 730 1558 1131 1654 ...
# $ price                      : Factor w/ 526 levels "$0.00 ","$1,000.00 ",..: 111 523 188 437 437 494 80 76 178 61 ...
# $ security_deposit           : Factor w/ 95 levels "","$0.00 ","$1,000.00 ",..: 20 2 1 41 41 2 2 1 73 73 ...
# $ cleaning_fee               : Factor w/ 189 levels "","$0.00 ","$10.00 ",..: 4 3 4 150 150 68 150 150 4 174 ...
# $ guests_included            : int  2 2 2 1 1 2 2 1 1 2 ...
# $ extra_people               : Factor w/ 79 levels "$0.00 ","$10.00 ",..: 32 27 1 7 7 15 64 1 1 1 ...
# $ minimum_nights             : int  1 1 30 32 32 6 1 1 30 30 ...
# $ maximum_nights             : int  30 5 60 60 90 1125 14 365 60 180 ...
# $ number_of_reviews          : int  217 160 111 18 8 28 704 511 337 18 ...
# $ review_scores_rating       : int  97 94 98 86 93 97 98 94 96 99 ...
# $ review_scores_accuracy     : int  10 10 10 8 9 10 10 10 10 10 ...
# $ review_scores_cleanliness  : int  10 10 10 8 9 10 10 9 10 10 ...
# $ review_scores_checkin      : int  10 10 10 9 10 10 10 10 10 10 ...
# $ review_scores_communication: int  10 10 10 9 10 10 10 10 10 10 ...
# $ review_scores_location     : int  10 10 10 9 9 10 10 10 10 10 ...
# $ review_scores_value        : int  9 10 9 8 9 10 9 9 9 10 ...
# $ instant_bookable           : Factor w/ 2 levels "f","t": 1 1 1 1 1 1 2 1 1 1 ...
# $ cancellation_policy        : Factor w/ 6 levels "flexible","moderate",..: 2 4 4 4 4 2 4 4 2 2 ...


#from the structure, I notice some immediate issues.

# First: In "market," D.C. is listed as a value, since we are only interested in San Fran Airbnb's, we'll have to delete this observation
listings_fixing <- listings_cleaned[!(listings_cleaned$market=="D.C."), ]
#we can also delete this column now, since all values will be San Francisco
listings_fixing$market <- NULL

#Second: There is an empty factor variable " " in "host_is_superhost","city", "zipcode", "security_deposit", and "cleaning_fee".
#We can assume that an empty factor in "security_deposit", and "cleaning_fee" means that there were no deposits or fees listed. 

# First, I will change these missing values to $0.00 using dplyr na_if and tidyr replace_na

library(dplyr)
#install.packages("tidyr")
library(tidyr)

#turn security_deposit factor variable into character so I can look for empty strings
listings_fixing$security_deposit <- as.character(listings_fixing$security_deposit)

#turn the dataframe into a tibble so I can use dplyr and tidyr
listings_fixing <- as.tbl(listings_fixing)

#turn empty strings "" into NA using dplyr na_if
listings_fixing$security_deposit <-na_if(listings_fixing$security_deposit, "")

#replace the NA variables with $0.00
listings_fixing$security_deposit <- replace_na(listings_fixing$security_deposit, "$0.00")

#repeat this process for cleaning_fee
listings_fixing$cleaning_fee <- as.character(listings_fixing$cleaning_fee)
listings_fixing$cleaning_fee <-na_if(listings_fixing$cleaning_fee, "")
listings_fixing$cleaning_fee <- replace_na(listings_fixing$cleaning_fee, "$0.00")


#second, I will see how many missing variables are in "host_is_superhost"
summary(listings_fixing$host_is_superhost) #there are 8 empty values "" in the "host_is_superhost" variable. Since we cannot determine
#f/t for these missing values, and cannot impute a numerical value, I will remove these 8 observations.
#      f    t 
# 8 4556 3546 

listings_fixing <- listings_fixing[!(listings_fixing$host_is_superhost==""), ]

#Third, I will see how many missing values "" are in the city variable

summary(listings_fixing$city) #there are 10 empty "" values 

#                        Brisbane                   Daly City  Noe Valley - San Francisco 
# 10                           1                          34                           1 
# San Francisco              San Francisco  San Francisco, Hayes Valley                    San Jose 
# 8058                           3                           1                           1 
# 旧金山 
# 1 

#turn city factor variable into character so I can look for empty strings
listings_fixing$city <- as.character(listings_fixing$city)

#turn empty strings "" into NA using dplyr na_if
listings_fixing$city <-na_if(listings_fixing$city, "")

#see which rows in city are NA
which(is.na(listings_fixing$city))
#[1] 4446 4447 4506 4507 4508 4511 4512 4556 6841 7398

#if I have zipcode data for these observations, I may be able to determine the city from the zip

summary(listings_fixing$zipcode)
#From the summary I can see there are 245 "" emplty values in zipcode

#turn zipcode factor variable into character so I can look for empty strings
listings_fixing$zipcode <- as.character(listings_fixing$zipcode)

#turn empty strings "" into NA using dplyr na_if
listings_fixing$zipcode <-na_if(listings_fixing$zipcode, "")

#see which rows in city are NA
which(is.na(listings_fixing$zipcode))

slice(listings_fixing, 4446, 4447, 4506, 4507, 4508, 4511, 4512, 4556, 6841, 7398) #when I slice to see the rows where city is NA, zipcode is also NA for 
#these observations. Therefore, I will get rid of these 10 rows altogether.

# host_is_superho… host_verificati… neighbourhood_c… city  zipcode latitude longitude property_type room_type accommodates bathrooms
# <fct>            <fct>            <fct>            <chr> <chr>      <dbl>     <dbl> <fct>         <fct>            <int>     <dbl>
#  1 t                ['email', 'phon… Castro/Upper Ma… NA    NA          37.8     -122. Apartment     Entire h…            2         1
#  2 t                ['email', 'phon… Castro/Upper Ma… NA    NA          37.8     -122. Apartment     Entire h…            6         2
#                       3 t                ['email', 'phon… South of Market  NA    NA          37.8     -122. Apartment     Entire h…            2         1
#  4 t                ['email', 'phon… South of Market  NA    NA          37.8     -122. Apartment     Entire h…            4         2
#                                           5 t                ['email', 'phon… South of Market  NA    NA          37.8     -122. Apartment     Entire h…            4         2
#  6 t                ['email', 'phon… Western Addition NA    NA          37.8     -122. Apartment     Entire h…            2         1
#                                                               7 t                ['email', 'phon… Western Addition NA    NA          37.8     -122. Apartment     Entire h…            2         1
#  8 t                ['email', 'phon… South of Market  NA    NA          37.8     -122. Condominium   Entire h…            2         1
#                                                                                   9 t                ['email', 'phon… Nob Hill         NA    NA          37.8     -122. Condominium   Entire h…            4         1
# 10 f                ['email', 'phon… Bayview          NA    NA          37.7     -122. House         Private …            3         1

#remove the NA city observations
listings_fixing <-  listings_fixing[!is.na(listings_fixing$city), ]


#finally I will move to zipcode. with the subtraction of the 10 NA city observations, I now have 235 NA zipcode values.
sum(is.na(listings_fixing$zipcode))
#[1] 235

#The best way to populate thses NA Zipcodes is to group the data by "neighborhood_cleansed" and use the known zipcodes to populate
#the unknown ones, since we can assume zipcodes will be the same within neighborhoods.

#Are there any NAs in "neighborhood_cleansed" ?
sum(is.na(listings_fixing$neighbourhood_cleansed)) 
#[1] 0    #no NAs in this variable

summary(listings_fixing$neighbourhood_cleansed)
# Bayview        Bernal Heights   Castro/Upper Market             Chinatown        Crocker Amazon 
# 204                   390                   431                   119                    50 
# Diamond Heights Downtown/Civic Center     Excelsior    Financial District             Glen Park 
# 17                   686                   179                   183                    65 
# Golden Gate Park  Haight Ashbury        Inner Richmond          Inner Sunset             Lakeshore 
# 4                   398                   213                   171                    66 
# Marina               Mission              Nob Hill            Noe Valley           North Beach 
# 198                   756                   314                   333                   173 
# Ocean View         Outer Mission        Outer Richmond          Outer Sunset       Pacific Heights 
# 135                   181                   184                   297                   157 
# Parkside          Potrero Hill              Presidio      Presidio Heights          Russian Hill 
# 130                   248                     1                    21                   177 
# Seacliff       South of Market   Treasure Island/YBI            Twin Peaks     Visitacion Valley 
# 22                   675                     1                    68                    79 


listings_fixing$zipcode <- as.numeric(listings_fixing$zipcode)

#use Base R's ave() to group by neighborhood_cleansed and replace NA's in zipcode with the group's median zipcode
listings_fixing$zipcode <- ave(listings_fixing$zipcode, listings_fixing$neighbourhood_cleansed, FUN=function(x) 
  ifelse(is.na(x), median(x,na.rm=TRUE), x))

unique(listings_fixing$zipcode) #now there are no more NAs in Zipcode, they were coerced to the median zip for their neighborhood group
# [1] 94117 94131 94110 94107 94109 94102 94114 94105 94133 94115 94121 94118 94127 94104 94122 94123 94112 94108 94111 94103
# [21] 94124 94113 94116 94129 94132 94134 94158 94014 94015 94130

#.................................................................................................................................

str(listings_fixing)
#Looking again at the structure, we have cleansed host_is_superhost, neighborhood_cleansed, city, zipcode, secutiy_deposit, and cleaning_fee.
#we will keep latitude and longitude for the time being for a potential geographic heat map data visualization

#though, host_is_superhost should be changed to TRUE/FALE logical
listings_fixing$host_is_superhost <- toupper(listings_fixing$host_is_superhost) #change to upper case
listings_fixing$host_is_superhost <- as.logical(listings_fixing$host_is_superhost) #coerce to logical

#also, zipcode should be a factor variable:
listings_fixing$zipcode <- as.factor(listings_fixing$zipcode)

#property_type looks properly cleaned:
summary(listings_fixing$property_type)
# Aparthotel  Apartment  Bed and breakfast     Boutique hotel           Bungalow              Cabin 
# 41               3234                 43                267                 17                  3 
# Camper/RV      Castle        Condominium            Cottage         Dome house        Earth house 
# 1                  4                889                 12                  1                  2 
# Guest suite Guesthouse             Hostel              Hotel              House                Hut 
# 577                 41                 92                157               2307                  1 
# In-law           Loft              Other             Resort Serviced apartment         Tiny house 
# 1                 88                 24                 14                121                  3 
# Townhouse        Villa 
# 142                 10 

#room type looks properly cleansed:
summary(listings_fixing$room_type)
# Entire home/apt   Hotel room    Private room     Shared room 
# 4761             207            2883             241 

#accommodates is integer, bathrooms is numerical, bedrooms and beds are integer: all are acceptable for analysis

#bed type is properly cleansed:
summary(listings_fixing$bed_type)
# Airbed         Couch         Futon Pull-out Sofa      Real Bed 
# 11             6            33            19          8023 

#price (which is our predicted variable) is a factor object, we need to chage this to numeric and remove the "$"

listings_fixing$price <- gsub(',','',listings_fixing$price) #remove thousand market ',' first
listings_fixing$price <- gsub('[$]','', listings_fixing$price) #them remove dollar sign ($)
listings_fixing$price <- as.numeric(listings_fixing$price) #change to numeric

#must repeat this process with security_deposit, cleaning_fee, and extra_people
#secutiry_deposit:
listings_fixing$security_deposit <- gsub(',','',listings_fixing$security_deposit) #remove thousand market ',' first
listings_fixing$security_deposit <- gsub('[$]','', listings_fixing$security_deposit) #them remove dollar sign ($)
listings_fixing$security_deposit <- as.numeric(listings_fixing$security_deposit) #change to numeric

#cleaning_fee:
listings_fixing$cleaning_fee <- gsub(',','',listings_fixing$cleaning_fee) #remove thousand market ',' first
listings_fixing$cleaning_fee <- gsub('[$]','', listings_fixing$cleaning_fee) #them remove dollar sign ($)
listings_fixing$cleaning_fee <- as.numeric(listings_fixing$cleaning_fee) #change to numeric

#extra_people is stored as a factor, must change to character first:
listings_fixing$extra_people <- as.character(listings_fixing$extra_people)
listings_fixing$extra_people <- gsub(',','',listings_fixing$extra_people) #remove thousand market ',' first
listings_fixing$extra_people <- gsub('[$]','', listings_fixing$extra_people) #them remove dollar sign ($)
listings_fixing$extra_people <- as.numeric(listings_fixing$extra_people) #change to numeric

#guests_included is properly cleansed:
summary(listings_fixing$guests_included)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.00    1.00    1.00    1.72    2.00   16.00 

#minimum and maximum nights are properly cleansed:
summary(listings_fixing$minimum_nights)
# Min.1st Qu.    Median      Mean   3rd Qu.      Max. 
# 1         2         4     12374        30 100000000 

summary(listings_fixing$maximum_nights)
# Min.1st Qu.    Median      Mean   3rd Qu.      Max. 
# 1        29       180     12874      1125 100000000 

#number_of_reviews are in acceptable  integer format.

#the resulting 7 categories of reviews have a lot of missing data; about 1,652 out of 8,092. This could either mean that there 
#are no reviews for those 1,652 observations, or they were left out during the data collection process. We do not want to delete these
#observations because there are too many. And there is no way to impute review data for this many observations. So, we will have to remove the 
# 7 review catgeories.

listings_fixing <- listings_fixing[,-c(23:29)]

#instant_bookable should be changed to logic TRUE/FALSE:

listings_fixing$instant_bookable <- toupper(listings_fixing$instant_bookable) #change to upper case
listings_fixing$instant_bookable <- as.logical(listings_fixing$instant_bookable) #coerce to logical

#cancellation_policy looks properly cleansed:
summary(listings_fixing$cancellation_policy)
# flexible                    moderate                    strict            strict_14_with_grace_period 
# 1732                        2592                         105                        3599 
# super_strict_30             super_strict_60 
# 45                          19

#Done cleaning up the data frame for now. Make a copy of the newly cleaned data, remove the final 2 unnecessary variables "amenities"and "city"
#that does not add to our analysis

final_listings <- listings_fixing[,-c(3,14)]

#.................................................................................................................................
# Exploratory data analysis
#.................................................................................................................................

#Here it would be helpful to explore the data variable by variable.

#.................................................................................................................................
#starting with Price, which is what we will be trying to predict
summary(final_listings$price) 
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.0   100.0   150.0   225.6   240.0 10000.0 

#from here we can see we may have some outliers; some prices are 0 while some are 10,000. Take a closer look with a plot:
plot(final_listings$price,
     main = "Price Per Night, in USD",
     xlab = "Observation",
     ylab = "Price"
     ) 
#with this plot, we are able to see that there are what look to be outliers at the top, there are only
#relatively small number of observations where price > 1,500


#Look at price specified by room_type
plot(final_listings$price,
     main = "Price (by Room Type) Per Night, in USD",
     xlab = "Observation",
     ylab = "Price",
     col = final_listings$room_type)

legend(4000,10000,
       legend= levels(final_listings$room_type), 
       pch = 16,
       col= unique(final_listings$room_type), 
       )
#the mass of green at the bottom indicates that perhaps "Hotel Rooms" are generally the least expensive option. 

#histogram of price to see breakdown.
hist(final_listings$price,
     main = "Price Per Night, in USD",
     xlab = "Observation",
     ylab = "Price",
     freq=TRUE, 
     breaks = 100)

#Too small to see, lets look at just proce values ,2000
hist(final_listings$price[final_listings$price<2000], #The majority of the prices are within the 0-500 price range
     main = "Price (< $2,000) Per Night, in USD",
     xlab = "Observation",
     ylab = "Price",
     freq=TRUE, 
     breaks = 100)
#Price is very drastically skewed to the right, we'll keep this in mind for the future.

quantile(final_listings$price, probs = c(0.25, 0.75))
# 25% 75% 
# 100 240
#25% of the prices are $100/night or below and 75% of prices are $240/night and below

#.................................................................................................................................
#Next, a look at Neighborhood

library(ggplot2)


g <- ggplot(final_listings, aes(neighbourhood_cleansed))

ggplot(final_listings) + geom_bar(aes(y = neighbourhood_cleansed)) + 
  labs( x= "Number of Listings",
          y= "Neighbourhood",
          title = "Listings by Neighbourhood")
#most listings are in the neighbirhoods of Western Adittion, South of Marketi, Mission, and Downtown
#There are very few listings in Presidio, Tresure Island, and Golden Gate Park

#Check the averages of price for each neighborhood
neighborhood_price_means <- aggregate(x = final_listings$price, 
                                      by = list(final_listings$neighbourhood_cleansed),
                                      FUN = mean)
#Presidio Heights is the most expensive, while Treasure Island is the least expensive neighborhood to stay

#                 Group.1        x
# 29      Presidio Heights 447.9048
# 18              Nob Hill 367.4363
# 11      Golden Gate Park 348.5000
# 30          Russian Hill 337.4294
# 16                Marina 312.7525
# 25       Pacific Heights 310.9745
# 14          Inner Sunset 302.1345
# 20           North Beach 251.7399
# 31              Seacliff 249.0455
# 34            Twin Peaks 247.2353
# 32       South of Market 246.3333
# 3    Castro/Upper Market 245.2645
# 27          Potrero Hill 240.6411
# 37      Western Addition 239.2254
# 19            Noe Valley 234.1231
# 10             Glen Park 233.5231
# 9     Financial District 230.3224
# 17               Mission 220.3466
# 13        Inner Richmond 217.3380
# 26              Parkside 217.1615
# 12        Haight Ashbury 215.8668
# 6        Diamond Heights 207.4118
# 21            Ocean View 196.9111
# 2         Bernal Heights 193.5564
# 7  Downtown/Civic Center 192.5000
# 36    West of Twin Peaks 189.2721
# 4              Chinatown 188.3025
# 23        Outer Richmond 184.4402
# 15             Lakeshore 168.3182
# 22         Outer Mission 154.3757
# 35     Visitacion Valley 152.6582
# 24          Outer Sunset 141.4411
# 8              Excelsior 128.6648
# 5         Crocker Amazon 128.3200
# 1                Bayview 117.1471
# 28              Presidio 105.0000
# 33   Treasure Island/YBI  95.0000


#.................................................................................................................................
#And a look at zipcode

str(final_listings$zipcode)
# 94014 94015 94102 94103 94104 94105 94107 94108 94109 94110 94111 94112 94113 94114 94115 94116 
# 31     2   519   581    11   120   363   292   630   996    51   405     1   649   361   198 
# 94117 94118 94121 94122 94123 94124 94127 94129 94130 94131 94132 94133 94134 94158 
# 682   220   224   355   222   197   139     1     1   279    96   252   151    63
#a factor variable with 30 levels (zip codes)

ggplot(final_listings) + geom_bar(aes(y = zipcode)) + 
  labs( x= "Number of Listings",
        y= "Zip Code",
        title = "Listings by Zip Code")

#nearly 1,000 listings are in the 94410 zip. Other honorable mentions are 94117, 94114, and 94109

#.................................................................................................................................
#And a look at property type & room type

ggplot(final_listings) + geom_bar(aes(y = property_type)) + 
  labs( x= "Number of Listings",
        y= "Type",
        title = "Property Type")
#an overwhelming number of listings are Houses and Apartments

ggplot(final_listings, aes(y = property_type)) +
  geom_bar(aes(fill = room_type), position = position_stack(reverse = TRUE)) +
  labs(x= "Number of Listings",
       y= "Property Type",
       title = "Property & Room Type") +
  theme(legend.position = "top")

#Of apartments, the majority of listings give the Entire apartment for the rental. Unlis House type
#properties where the majority of listings are private rooms

#This brings up the question, what is the distribution of room types?
ggplot(final_listings) + geom_bar(aes(y = room_type)) + 
  labs( x= "Number of Listings",
        y= "Type",
        title = "Room Type")
#Most listings are the entire home/apartment while still a good proportion of them are private rooms.

#.................................................................................................................................
#Next, check #of beds and #of baths

#install.packages("gridExtra")
library(gridExtra)

summary(final_listings$bedrooms) #we may have an outlier here with the listings of 14 bedrooms
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 0.000   1.000   1.000   1.346   2.000  14.000       4 

which(final_listings$bedrooms == 14)
#Row 2386

summary(final_listings$bathrooms) #another possible outlier, 14 bathrooms
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 0.000   1.000   1.000   1.396   1.500  14.000      12 
which(final_listings$bathrooms == 14)
#Also row 2386; we'll have to keep that in mind. We may have to remove that observtion eventually

final_listings[2386,] #show the entire row, the listing is a BOUTIQUE HOTEL which explains why there are 14 bedrooms and bathrooms.
# host_is_superho… neighbourhood_c… zipcode latitude longitude property_type room_type accommodates bathrooms bedrooms  beds bed_type price
# <lgl>            <fct>            <fct>      <dbl>     <dbl> <fct>         <fct>            <int>     <dbl>    <int> <int> <fct>    <dbl>
#1 FALSE            Downtown/Civic … 94109       37.8     -122. Boutique hot… Private …           14        14       14    14 Real Bed    69
# # … with 9 more variables: security_deposit <dbl>, cleaning_fee <dbl>, guests_included <int>, extra_people <dbl>, minimum_nights <int>,
# #   maximum_nights <int>, number_of_reviews <int>, instant_bookable <lgl>, cancellation_policy <fct>


#want to see both plots side by side using gridExtra package grid.arrange()
grid.arrange((ggplot(final_listings) + geom_bar(aes(x = bedrooms)) +
               labs( x= "Number of Bedrooms",
                     y= "Listings",
                     title = "Bedrooms (Increments of 1)")), 
             (ggplot(final_listings) + geom_bar(aes(x = bathrooms)) +
                                              labs( x= "Number of Bathrooms",
                                                    y= "Listings",
                                                    title = "Bathrooms (Increments of 0.5)")), 
             ncol = 2)
#For Bedrooms: majority of listings have 1, then 2. Almost 1000 of them have 0
#For bathrooms, majority have 1 followed by 2. A small number of listings have 0

#.................................................................................................................................
#Next, a look at bed type

ggplot(final_listings) + geom_bar(aes(y = bed_type)) + 
  labs( x= "Number of Listings",
        y= "Type",
        title = "Bed Type")

#almost ALL listings have a real bed

#.................................................................................................................................
#A look at number of guests included

table(final_listings$guests_included)
#    1    2    3    4    5    6    7    8    9   10   12   16 
# 5221 1708  209  575   98  203   18   44    6    6    3    1 

#A majority of listings include 1-2 people.
which(final_listings$guests_included == 16)
final_listings[2386,13] #The 16 person  listing is once again a BOUTIQUE HOTEL
# host_is_superho… neighbourhood_c… zipcode latitude longitude property_type room_type accommodates bathrooms bedrooms
# <lgl>            <fct>            <fct>      <dbl>     <dbl> <fct>         <fct>            <int>     <dbl>    <int>
#   1 FALSE            Downtown/Civic … 94109       37.8     -122. Boutique hot… Private …           14        14       14
# # … with 12 more variables: beds <int>, bed_type <fct>, price <dbl>, security_deposit <dbl>, cleaning_fee <dbl>,
# #   guests_included <int>, extra_people <dbl>, minimum_nights <int>, maximum_nights <int>, number_of_reviews <int>,
# #   instant_bookable <lgl>, cancellation_policy <fct>

#visually
ggplot(final_listings) + geom_bar(aes(x = guests_included)) + 
  labs( x= "Number of Guests",
        y= "Listings",
        title = "Guests Included in Price")

#.................................................................................................................................
#Cancellation Policy

ggplot(final_listings) + geom_bar(aes(y = cancellation_policy)) + 
  labs( x= "Listings",
        y= "Strictness of Policy",
        title = "Cancellation Policies")

ggplot(final_listings, aes(y = cancellation_policy)) +
  geom_bar(aes(fill = property_type), position = position_stack(reverse = TRUE)) +
  labs(x= "Number of Listings",
       y= "Cancellation Strictness",
       title = "Cancellation Policy by Property Type") +
  theme(legend.position = "top")    

#Most listings have a 14 day cancellation policy. There is no one property type that has
#a dominant cancellation policy, it's spread across "moderate" "flexible" and "14 day" pretty evenly


#.................................................................................................................................
#Multiple Regression Supervised Machine Learning
#.................................................................................................................................

#remove any final NA's
final_listings <- na.omit(final_listings)

#We will first run the algorithm with all observations, even though we found some outliers during the
#EDA process with prices of 0 and up to 10000. We will see if these have an impacting effect on the model
#with the resulting diagnostic plots.

# Split data set into training  and test set
n <- nrow(final_listings)  # Number of observations = 8068
ntrain <- round(n*0.7)    # 70% for training set
set.seed(415)             # Set seed for reproducible results
tindex <- sample(n, ntrain) # Create an index

train_listings <- final_listings[tindex,]  # Create training set; 5,648 observations
test_listings <- final_listings[-tindex,]  # Create test set; 2,420

#Multiple Regression #1 .........................
#create a multiple regression with all predictors first
lm1 <-  lm(price ~., data = train_listings)
summary(lm1)

# Call:
#   lm(formula = price ~ ., data = train_listings)
# 
# Residuals:
#   Min     1Q Median     3Q    Max 
# -661.9  -88.3  -20.3   39.1 9110.4 
# 
# Coefficients: (1 not defined because of singularities)
# Estimate Std. Error t value Pr(>|t|)    
# (Intercept)                                    -1.593e+04  1.292e+05  -0.123  0.90185    
# host_is_superhostTRUE                           3.871e-01  1.135e+01   0.034  0.97280    
# neighbourhood_cleansedBernal Heights            3.073e+01  1.886e+02   0.163  0.87056    
# neighbourhood_cleansedCastro/Upper Market       7.214e+01  1.979e+02   0.365  0.71546    
# neighbourhood_cleansedChinatown                 2.717e+02  2.144e+02   1.267  0.20524    
# neighbourhood_cleansedCrocker Amazon           -2.090e+01  1.905e+02  -0.110  0.91264    
# neighbourhood_cleansedDiamond Heights          -1.385e+01  2.325e+02  -0.060  0.95250    
# neighbourhood_cleansedDowntown/Civic Center     9.525e+01  2.074e+02   0.459  0.64609    
# neighbourhood_cleansedExcelsior                -4.381e+00  1.779e+02  -0.025  0.98035    
# neighbourhood_cleansedFinancial District        1.603e+02  2.090e+02   0.767  0.44302    
# neighbourhood_cleansedGlen Park                 4.738e+01  1.951e+02   0.243  0.80812    
# neighbourhood_cleansedGolden Gate Park          1.848e+02  3.024e+02   0.611  0.54117    
# neighbourhood_cleansedHaight Ashbury            1.545e+02  2.045e+02   0.755  0.45004    
# neighbourhood_cleansedInner Richmond            1.283e+02  2.409e+02   0.532  0.59448    
# neighbourhood_cleansedInner Sunset              1.691e+02  2.051e+02   0.824  0.40969    
# neighbourhood_cleansedLakeshore                 7.148e+00  2.136e+02   0.033  0.97330    
# neighbourhood_cleansedMarina                    9.460e+01  2.324e+02   0.407  0.68402    
# neighbourhood_cleansedMission                   7.993e+01  1.935e+02   0.413  0.67960    
# neighbourhood_cleansedNob Hill                  3.378e+02  2.112e+02   1.599  0.10991    
# neighbourhood_cleansedNoe Valley                5.678e+01  1.927e+02   0.295  0.76829    
# neighbourhood_cleansedNorth Beach               2.135e+02  2.199e+02   0.971  0.33173    
# neighbourhood_cleansedOcean View                2.399e+01  1.894e+02   0.127  0.89917    
# neighbourhood_cleansedOuter Mission             4.532e+01  1.849e+02   0.245  0.80637    
# neighbourhood_cleansedOuter Richmond            1.003e+02  2.640e+02   0.380  0.70400    
# neighbourhood_cleansedOuter Sunset              8.413e+01  2.142e+02   0.393  0.69452    
# neighbourhood_cleansedPacific Heights           1.406e+02  2.131e+02   0.660  0.50953    
# neighbourhood_cleansedParkside                  1.523e+02  2.136e+02   0.713  0.47571    
# neighbourhood_cleansedPotrero Hill              1.058e+02  1.990e+02   0.532  0.59509    
# neighbourhood_cleansedPresidio Heights          2.202e+02  2.590e+02   0.850  0.39534    
# neighbourhood_cleansedRussian Hill              1.793e+02  2.179e+02   0.823  0.41057    
# neighbourhood_cleansedSeacliff                  6.983e+01  2.848e+02   0.245  0.80628    
# neighbourhood_cleansedSouth of Market           1.149e+02  1.999e+02   0.575  0.56534    
# neighbourhood_cleansedTreasure Island/YBI       1.447e+02  4.575e+02   0.316  0.75175    
# neighbourhood_cleansedTwin Peaks                5.764e+01  2.012e+02   0.287  0.77448    
# neighbourhood_cleansedVisitacion Valley         2.123e+01  1.772e+02   0.120  0.90464    
# neighbourhood_cleansedWest of Twin Peaks        6.369e+01  1.952e+02   0.326  0.74417    
# neighbourhood_cleansedWestern Addition          1.226e+02  2.040e+02   0.601  0.54791    
# zipcode94015                                   -4.524e+01  2.903e+02  -0.156  0.87618    
# zipcode94102                                   -8.485e+01  1.282e+02  -0.662  0.50792    
# zipcode94103                                    5.807e+01  1.200e+02   0.484  0.62847    
# zipcode94104                                    2.189e+02  1.995e+02   1.097  0.27261    
# zipcode94105                                    1.867e+01  1.331e+02   0.140  0.88846    
# zipcode94107                                   -2.340e+00  1.300e+02  -0.018  0.98564    
# zipcode94108                                   -2.505e+02  1.348e+02  -1.858  0.06322 .  
# zipcode94109                                    3.835e+01  1.312e+02   0.292  0.77004    
# zipcode94110                                    2.972e+01  1.123e+02   0.265  0.79126    
# zipcode94111                                   -8.013e+01  1.504e+02  -0.533  0.59406    
# zipcode94112                                    1.865e+01  9.008e+01   0.207  0.83599    
# zipcode94114                                    4.670e+01  1.138e+02   0.410  0.68161    
# zipcode94115                                    1.022e+01  1.305e+02   0.078  0.93760    
# zipcode94116                                   -5.218e+01  1.281e+02  -0.407  0.68366    
# zipcode94117                                   -5.191e+01  1.235e+02  -0.420  0.67423    
# zipcode94118                                   -7.098e+01  1.741e+02  -0.408  0.68350    
# zipcode94121                                   -6.297e+01  2.003e+02  -0.314  0.75320    
# zipcode94122                                   -4.743e+01  1.286e+02  -0.369  0.71230    
# zipcode94123                                    4.380e+01  1.580e+02   0.277  0.78167    
# zipcode94124                                    2.468e+01  2.052e+02   0.120  0.90427    
# zipcode94127                                    6.536e+00  1.095e+02   0.060  0.95239    
# zipcode94130                                           NA         NA      NA       NA    
# zipcode94131                                    3.606e+01  1.069e+02   0.337  0.73586    
# zipcode94132                                    5.888e+01  1.196e+02   0.492  0.62264    
# zipcode94133                                   -8.762e+01  1.388e+02  -0.631  0.52795    
# zipcode94134                                    2.251e+00  1.132e+02   0.020  0.98414    
# zipcode94158                                    6.264e+01  1.330e+02   0.471  0.63773    
# latitude                                        2.801e+02  1.395e+03   0.201  0.84086    
# longitude                                      -4.270e+01  9.014e+02  -0.047  0.96222    
# property_typeApartment                          8.028e+00  7.015e+01   0.114  0.90889    
# property_typeBed and breakfast                  1.260e+02  9.820e+01   1.283  0.19948    
# property_typeBoutique hotel                     4.525e+02  7.533e+01   6.006 2.02e-09 ***
#   property_typeBungalow                          -1.214e+01  1.325e+02  -0.092  0.92697    
# property_typeCabin                             -1.579e+02  2.258e+02  -0.699  0.48434    
# property_typeCastle                             9.362e+01  2.279e+02   0.411  0.68126    
# property_typeCondominium                        4.328e+01  7.131e+01   0.607  0.54389    
# property_typeCottage                            6.179e+01  1.496e+02   0.413  0.67963    
# property_typeDome house                        -1.839e+02  3.800e+02  -0.484  0.62837    
# property_typeEarth house                        1.955e+02  2.733e+02   0.716  0.47432    
# property_typeGuest suite                        3.580e+01  7.365e+01   0.486  0.62692    
# property_typeGuesthouse                         2.268e+01  9.977e+01   0.227  0.82019    
# property_typeHostel                             9.323e+01  8.756e+01   1.065  0.28702    
# property_typeHotel                              2.143e+02  8.023e+01   2.672  0.00757 ** 
#   property_typeHouse                              3.013e+01  7.057e+01   0.427  0.66936    
# property_typeIn-law                             7.392e+01  3.802e+02   0.194  0.84585    
# property_typeLoft                               7.025e+01  8.492e+01   0.827  0.40814    
# property_typeOther                              8.590e+01  1.162e+02   0.739  0.45970    
# property_typeResort                             2.437e+02  1.563e+02   1.559  0.11905    
# property_typeServiced apartment                 1.657e+02  8.320e+01   1.992  0.04647 *  
#   property_typeTiny house                         3.763e+01  2.271e+02   0.166  0.86839    
# property_typeTownhouse                          3.191e+01  7.891e+01   0.404  0.68598    
# property_typeVilla                              2.179e+02  1.509e+02   1.444  0.14888    
# room_typeHotel room                            -1.937e+02  4.079e+01  -4.748 2.10e-06 ***
#   room_typePrivate room                          -3.744e+01  1.443e+01  -2.595  0.00948 ** 
#   room_typeShared room                           -9.745e+01  3.451e+01  -2.824  0.00477 ** 
#   accommodates                                    3.473e+01  5.797e+00   5.991 2.22e-09 ***
#   bathrooms                                      -8.916e+00  6.786e+00  -1.314  0.18893    
# bedrooms                                        7.957e+01  1.023e+01   7.777 8.79e-15 ***
#   beds                                           -1.563e+01  8.576e+00  -1.823  0.06837 .  
# bed_typeCouch                                   1.296e+02  2.564e+02   0.505  0.61342    
# bed_typeFuton                                   1.944e+01  1.563e+02   0.124  0.90099    
# bed_typePull-out Sofa                           6.848e+01  1.776e+02   0.386  0.69975    
# bed_typeReal Bed                                3.386e+01  1.321e+02   0.256  0.79777    
# security_deposit                                8.513e-03  8.398e-03   1.014  0.31080    
# cleaning_fee                                   -2.146e-01  7.967e-02  -2.694  0.00708 ** 
#   guests_included                                 1.254e+01  5.092e+00   2.463  0.01382 *  
#   extra_people                                    5.437e-01  1.780e-01   3.054  0.00227 ** 
#   minimum_nights                                  2.247e-03  3.502e-03   0.642  0.52111    
# maximum_nights                                 -2.248e-03  3.502e-03  -0.642  0.52096    
# number_of_reviews                              -2.108e-01  7.221e-02  -2.919  0.00353 ** 
#   instant_bookableTRUE                            1.480e+01  1.088e+01   1.360  0.17385    
# cancellation_policymoderate                     1.049e+01  1.511e+01   0.694  0.48753    
# cancellation_policystrict                      -1.355e+01  4.762e+01  -0.285  0.77600    
# cancellation_policystrict_14_with_grace_period  1.700e+01  1.389e+01   1.224  0.22102    
# cancellation_policysuper_strict_30             -1.262e+01  7.277e+01  -0.173  0.86237    
# cancellation_policysuper_strict_60              2.002e+02  1.162e+02   1.723  0.08500 .  
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 370.9 on 5536 degrees of freedom
# Multiple R-squared:  0.1564,	Adjusted R-squared:  0.1395 
# F-statistic: 9.248 on 111 and 5536 DF,  p-value: < 2.2e-16

#There are significant p-values in zipcode, property_type, room_type, accommodates, bedrooms, beds,
#cleaning_fee, guests_included, extra_people, and number of reviews: Rerun the regression with these predictors



#create a multiple regression leaving out neighborhood_cleansed, longitude, latitude, minimum & maximum nights
lm1B <-  lm(price ~  zipcode + property_type + room_type + accommodates +
           bedrooms + beds + cleaning_fee + extra_people + number_of_reviews, data = train_listings)
summary(lm1B)

# Call:
#   lm(formula = price ~ zipcode + property_type + room_type + accommodates + 
#        bedrooms + beds + cleaning_fee + extra_people + number_of_reviews, 
#      data = train_listings)
# 
# Residuals:
#   Min     1Q Median     3Q    Max 
# -586.0  -92.7  -22.8   37.7 9287.4 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)                     -110.91922  108.45417  -1.023 0.306480    
# zipcode94015                      34.34184  275.28806   0.125 0.900727    
# zipcode94102                      30.63010   85.24582   0.359 0.719373    
# zipcode94103                     166.95675   84.11866   1.985 0.047218 *  
#   zipcode94104                     462.77991  156.07243   2.965 0.003038 ** 
#   zipcode94105                     165.51849   92.14704   1.796 0.072510 .  
# zipcode94107                     105.20620   85.25743   1.234 0.217261    
# zipcode94108                     -11.82493   87.83533  -0.135 0.892912    
# zipcode94109                     248.76239   83.84600   2.967 0.003021 ** 
#   zipcode94110                      91.36456   82.93634   1.102 0.270673    
# zipcode94111                     125.23909  104.96695   1.193 0.232870    
# zipcode94112                      37.01614   84.17178   0.440 0.660121    
# zipcode94114                     120.32336   83.59403   1.439 0.150100    
# zipcode94115                     147.46770   85.04074   1.734 0.082959 .  
# zipcode94116                      84.32210   86.83281   0.971 0.331548    
# zipcode94117                      99.29597   83.75561   1.186 0.235853    
# zipcode94118                      78.73255   86.98635   0.905 0.365444    
# zipcode94121                      52.25387   86.78551   0.602 0.547130    
# zipcode94122                      76.25244   84.95764   0.898 0.369472    
# zipcode94123                     161.28785   87.04774   1.853 0.063954 .  
# zipcode94124                      21.87984   87.39149   0.250 0.802314    
# zipcode94127                      66.49265   89.98905   0.739 0.460000    
# zipcode94130                     177.86678  382.28674   0.465 0.641756    
# zipcode94131                      95.15544   85.92676   1.107 0.268168    
# zipcode94132                      73.26539   92.47954   0.792 0.428258    
# zipcode94133                     150.04629   86.97855   1.725 0.084566 .  
# zipcode94134                      12.42397   89.12603   0.139 0.889141    
# zipcode94158                     183.41120   98.38402   1.864 0.062341 .  
# property_typeApartment            36.38489   68.97735   0.527 0.597874    
# property_typeBed and breakfast   109.43926   96.42026   1.135 0.256414    
# property_typeBoutique hotel      467.30539   74.12281   6.304 3.11e-10 ***
#   property_typeBungalow             34.03516  131.76886   0.258 0.796189    
# property_typeCabin              -107.51015  225.44288  -0.477 0.633463    
# property_typeCastle              110.20577  227.71964   0.484 0.628438    
# property_typeCondominium          63.61865   70.13237   0.907 0.364381    
# property_typeCottage              72.99687  148.81934   0.491 0.623795    
# property_typeDome house         -132.78106  379.56854  -0.350 0.726486    
# property_typeEarth house         209.27491  272.78274   0.767 0.443004    
# property_typeGuest suite          58.40111   72.30415   0.808 0.419289    
# property_typeGuesthouse           45.27322   98.98421   0.457 0.647417    
# property_typeHostel               98.81520   87.08383   1.135 0.256544    
# property_typeHotel               237.92362   78.95939   3.013 0.002596 ** 
#   property_typeHouse                55.00706   69.47121   0.792 0.428513    
# property_typeIn-law              122.82680  379.52024   0.324 0.746225    
# property_typeLoft                111.95489   83.66941   1.338 0.180931    
# property_typeOther               113.28677  115.82276   0.978 0.328065    
# property_typeResort              236.64836  156.08976   1.516 0.129550    
# property_typeServiced apartment  180.36266   81.73255   2.207 0.027373 *  
#   property_typeTiny house           48.52704  226.25394   0.214 0.830180    
# property_typeTownhouse            56.38752   77.85277   0.724 0.468922    
# property_typeVilla               242.91216  149.93444   1.620 0.105262    
# room_typeHotel room             -192.56281   39.95936  -4.819 1.48e-06 ***
#   room_typePrivate room            -40.87711   14.11685  -2.896 0.003799 ** 
#   room_typeShared room            -112.54286   33.01560  -3.409 0.000657 ***
#   accommodates                      37.13267    5.54545   6.696 2.35e-11 ***
#   bedrooms                          83.27297    9.95179   8.368  < 2e-16 ***
#   beds                             -16.19523    8.46949  -1.912 0.055904 .  
# cleaning_fee                      -0.19357    0.07346  -2.635 0.008431 ** 
#   extra_people                       0.70146    0.16579   4.231 2.36e-05 ***
#   number_of_reviews                 -0.20389    0.06908  -2.951 0.003177 ** 
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 371.9 on 5588 degrees of freedom
# Multiple R-squared:  0.1442,	Adjusted R-squared:  0.1351 
# F-statistic: 15.95 on 59 and 5588 DF,  p-value: < 2.2e-16

plot(lm1B)
#The residuals vs fitted plot is clustered around the linear red line, however there seem to be more points aboce the
#line, and more spread above the line as well
#The normal Q-Q plot is not very good, the points deviate drastically from the normal line after theoretical quantile 2
#The Scale Locations plot is also not great. The residual plots are not randomly spread around the line, the residuals spread
#wider away from each other as the fitted values increase, causing a slight increase in the line
#In the residuals vs. leverage plot, there are no concerning cases outside of cooks distance

#This model is no good; R^2 is 0.1442  meaning only 14.4% of the output is explainable by the predictors.
#The residual standard error is also very high; 371.9

#Multiple Regression #2 .........................
#As we saw with our EDA, there were several observations that had outlying prices: some with 0 and some that were
#listed for more than $1500 per night. What happens if we remove those observations before training our alogorithm?

final_listings_no_ouliers <- final_listings[(final_listings$price>0 & final_listings$price < 1500),]
#now, the dataaset has 8010 observations instead of 8010


n <- nrow(final_listings_no_ouliers)  # Number of observations = 8010
ntrain <- round(n*0.7)    # 70% for training set
set.seed(415)             # Set seed for reproducible results
tindex <- sample(n, ntrain) # Create an index

train_listings_no_outliers <- final_listings_no_ouliers[tindex,]  # Create training set; 5,607 observations

test_listings_no_outliers <- final_listings_no_ouliers[-tindex,]  # Create test set; 2,410

#Multiple regression with all the predictors
lm2 <-  lm(price ~ ., data = train_listings_no_outliers)
summary(lm2)

# Call:
#   lm(formula = price ~ ., data = train_listings_no_outliers)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -1099.30   -58.48   -13.89    32.44  1229.31 
# 
# Coefficients: (1 not defined because of singularities)
# Estimate Std. Error t value Pr(>|t|)    
# (Intercept)                                    -1.179e+05  4.523e+04  -2.606 0.009196 ** 
#   host_is_superhostTRUE                           1.096e+01  3.904e+00   2.807 0.005016 ** 
#   neighbourhood_cleansedBernal Heights            5.274e+01  5.808e+01   0.908 0.363903    
# neighbourhood_cleansedCastro/Upper Market       5.485e+01  6.174e+01   0.888 0.374396    
# neighbourhood_cleansedChinatown                 8.032e+01  6.712e+01   1.197 0.231449    
# neighbourhood_cleansedCrocker Amazon            3.306e+01  6.046e+01   0.547 0.584574    
# neighbourhood_cleansedDiamond Heights           3.987e+01  6.824e+01   0.584 0.559097    
# neighbourhood_cleansedDowntown/Civic Center     1.064e+02  6.477e+01   1.643 0.100450    
# neighbourhood_cleansedExcelsior                 2.469e+01  5.564e+01   0.444 0.657284    
# neighbourhood_cleansedFinancial District        7.734e+01  6.507e+01   1.189 0.234636    
# neighbourhood_cleansedGlen Park                 5.588e+01  6.129e+01   0.912 0.361943    
# neighbourhood_cleansedGolden Gate Park          1.478e+02  9.341e+01   1.582 0.113682    
# neighbourhood_cleansedHaight Ashbury            9.808e+01  6.399e+01   1.533 0.125394    
# neighbourhood_cleansedInner Richmond            8.672e+01  7.852e+01   1.104 0.269469    
# neighbourhood_cleansedInner Sunset              7.012e+01  6.477e+01   1.083 0.278986    
# neighbourhood_cleansedLakeshore                 5.974e+01  6.773e+01   0.882 0.377833    
# neighbourhood_cleansedMarina                    6.135e+01  7.501e+01   0.818 0.413450    
# neighbourhood_cleansedMission                   4.786e+01  5.975e+01   0.801 0.423137    
# neighbourhood_cleansedNob Hill                  7.498e+01  6.611e+01   1.134 0.256727    
# neighbourhood_cleansedNoe Valley                6.366e+01  5.992e+01   1.062 0.288164    
# neighbourhood_cleansedNorth Beach               9.066e+01  6.932e+01   1.308 0.190961    
# neighbourhood_cleansedOcean View                5.331e+01  5.927e+01   0.899 0.368455    
# neighbourhood_cleansedOuter Mission             5.433e+01  5.778e+01   0.940 0.347188    
# neighbourhood_cleansedOuter Richmond            4.388e+01  8.505e+01   0.516 0.605915    
# neighbourhood_cleansedOuter Sunset              4.564e+01  6.816e+01   0.670 0.503170    
# neighbourhood_cleansedPacific Heights           1.406e+02  6.673e+01   2.107 0.035136 *  
#   neighbourhood_cleansedParkside                  5.011e+01  6.830e+01   0.734 0.463207    
# neighbourhood_cleansedPotrero Hill              8.371e+01  6.189e+01   1.353 0.176204    
# neighbourhood_cleansedPresidio                  8.481e-01  1.536e+02   0.006 0.995595    
# neighbourhood_cleansedPresidio Heights          1.849e+02  8.417e+01   2.197 0.028090 *  
#   neighbourhood_cleansedRussian Hill              1.020e+02  6.855e+01   1.487 0.136942    
# neighbourhood_cleansedSeacliff                  7.510e+01  9.130e+01   0.823 0.410767    
# neighbourhood_cleansedSouth of Market           5.937e+01  6.214e+01   0.955 0.339393    
# neighbourhood_cleansedTreasure Island/YBI       2.541e+01  1.547e+02   0.164 0.869512    
# neighbourhood_cleansedTwin Peaks                4.518e+01  6.323e+01   0.714 0.474989    
# neighbourhood_cleansedVisitacion Valley         4.935e+01  5.641e+01   0.875 0.381637    
# neighbourhood_cleansedWest of Twin Peaks        4.244e+01  6.151e+01   0.690 0.490195    
# neighbourhood_cleansedWestern Addition          1.006e+02  6.360e+01   1.581 0.113920    
# zipcode94015                                   -4.966e+01  9.940e+01  -0.500 0.617418    
# zipcode94102                                   -1.221e+02  4.268e+01  -2.860 0.004251 ** 
#   zipcode94103                                   -5.687e+00  4.014e+01  -0.142 0.887331    
# zipcode94104                                    1.582e+02  6.333e+01   2.498 0.012522 *  
#   zipcode94105                                   -2.960e+01  4.464e+01  -0.663 0.507272    
# zipcode94107                                   -2.318e+01  4.352e+01  -0.533 0.594248    
# zipcode94108                                   -6.249e+01  4.478e+01  -1.396 0.162906    
# zipcode94109                                   -8.608e+01  4.384e+01  -1.963 0.049653 *  
#   zipcode94110                                   -2.008e+00  3.739e+01  -0.054 0.957179    
# zipcode94111                                   -6.469e+01  5.056e+01  -1.279 0.200835    
# zipcode94112                                    1.074e+01  2.960e+01   0.363 0.716772    
# zipcode94114                                    1.237e+00  3.767e+01   0.033 0.973798    
# zipcode94115                                   -9.030e+01  4.380e+01  -2.062 0.039284 *  
#   zipcode94116                                   -4.477e+01  4.332e+01  -1.033 0.301464    
# zipcode94117                                   -7.290e+01  4.105e+01  -1.776 0.075832 .  
# zipcode94118                                   -1.051e+02  5.980e+01  -1.758 0.078852 .  
# zipcode94121                                   -1.007e+02  6.660e+01  -1.512 0.130501    
# zipcode94122                                   -7.492e+01  4.318e+01  -1.735 0.082758 .  
# zipcode94123                                   -5.417e+01  5.467e+01  -0.991 0.321867    
# zipcode94124                                    4.665e+01  6.496e+01   0.718 0.472733    
# zipcode94127                                   -1.628e+01  3.600e+01  -0.452 0.651084    
# zipcode94129                                   -1.292e+02  1.356e+02  -0.953 0.340735    
# zipcode94130                                           NA         NA      NA       NA    
# zipcode94131                                    2.241e+00  3.515e+01   0.064 0.949157    
# zipcode94132                                    9.492e+00  3.786e+01   0.251 0.802024    
# zipcode94133                                   -7.540e+01  4.671e+01  -1.614 0.106585    
# zipcode94134                                    8.145e+00  3.792e+01   0.215 0.829911    
# zipcode94158                                    2.739e+01  4.523e+01   0.606 0.544844    
# latitude                                        1.992e+03  4.839e+02   4.116 3.91e-05 ***
#   longitude                                      -3.487e+02  3.135e+02  -1.112 0.266153    
# property_typeApartment                         -3.897e+01  2.349e+01  -1.659 0.097216 .  
# property_typeBed and breakfast                 -3.240e+01  3.360e+01  -0.964 0.334841    
# property_typeBoutique hotel                     4.806e+01  2.536e+01   1.895 0.058149 .  
# property_typeBungalow                          -3.049e+01  5.121e+01  -0.595 0.551585    
# property_typeCabin                             -1.569e+02  1.304e+02  -1.204 0.228806    
# property_typeCamper/RV                         -8.631e+01  1.309e+02  -0.659 0.509611    
# property_typeCastle                             2.268e+01  9.398e+01   0.241 0.809300    
# property_typeCondominium                        4.689e-01  2.392e+01   0.020 0.984361    
# property_typeCottage                            2.487e+01  4.895e+01   0.508 0.611436    
# property_typeDome house                        -1.438e+02  1.307e+02  -1.100 0.271488    
# property_typeEarth house                        9.944e+01  9.387e+01   1.059 0.289468    
# property_typeGuest suite                       -2.107e+01  2.471e+01  -0.853 0.393784    
# property_typeGuesthouse                        -6.963e+00  3.416e+01  -0.204 0.838491    
# property_typeHostel                            -3.371e+01  2.896e+01  -1.164 0.244540    
# property_typeHotel                              1.072e+02  2.673e+01   4.012 6.10e-05 ***
#   property_typeHouse                             -6.781e+00  2.366e+01  -0.287 0.774470    
# property_typeHut                                9.852e+00  1.303e+02   0.076 0.939734    
# property_typeIn-law                             5.712e+00  1.307e+02   0.044 0.965139    
# property_typeLoft                               4.118e+01  2.895e+01   1.423 0.154857    
# property_typeOther                              2.278e+01  4.054e+01   0.562 0.574248    
# property_typeResort                             3.076e+02  4.646e+01   6.621 3.90e-11 ***
#   property_typeServiced apartment                 6.828e+00  2.755e+01   0.248 0.804288    
# property_typeTiny house                        -1.303e+01  7.793e+01  -0.167 0.867173    
# property_typeTownhouse                          8.120e-01  2.656e+01   0.031 0.975616    
# property_typeVilla                             -1.003e+00  5.475e+01  -0.018 0.985382    
# room_typeHotel room                            -7.596e+01  1.373e+01  -5.534 3.28e-08 ***
#   room_typePrivate room                          -5.034e+01  5.018e+00 -10.031  < 2e-16 ***
#   room_typeShared room                           -1.264e+02  1.212e+01 -10.434  < 2e-16 ***
#   accommodates                                    2.755e+01  1.970e+00  13.985  < 2e-16 ***
#   bathrooms                                       4.274e+00  2.377e+00   1.798 0.072196 .  
# bedrooms                                        4.792e+01  3.478e+00  13.777  < 2e-16 ***
#   beds                                           -7.944e+00  2.997e+00  -2.651 0.008049 ** 
#   bed_typeCouch                                   9.968e+01  7.404e+01   1.346 0.178274    
# bed_typeFuton                                  -4.139e+00  5.253e+01  -0.079 0.937210    
# bed_typePull-out Sofa                           6.437e+00  5.797e+01   0.111 0.911596    
# bed_typeReal Bed                                7.889e-01  4.561e+01   0.017 0.986202    
# security_deposit                                4.885e-03  2.811e-03   1.738 0.082292 .  
# cleaning_fee                                   -1.572e-02  2.772e-02  -0.567 0.570603    
# guests_included                                 7.964e+00  1.746e+00   4.561 5.19e-06 ***
#   extra_people                                    3.662e-01  6.329e-02   5.786 7.62e-09 ***
#   minimum_nights                                  2.540e-03  1.200e-03   2.117 0.034340 *  
#   maximum_nights                                 -2.540e-03  1.200e-03  -2.117 0.034298 *  
#   number_of_reviews                              -1.426e-01  2.535e-02  -5.627 1.93e-08 ***
#   instant_bookableTRUE                           -6.512e+00  3.763e+00  -1.730 0.083605 .  
# cancellation_policymoderate                     4.878e+00  5.273e+00   0.925 0.354901    
# cancellation_policystrict                      -5.810e+01  1.671e+01  -3.478 0.000509 ***
#   cancellation_policystrict_14_with_grace_period -5.012e+00  4.833e+00  -1.037 0.299762    
# cancellation_policysuper_strict_30             -2.881e+01  2.437e+01  -1.182 0.237107    
# cancellation_policysuper_strict_60              1.637e+02  3.990e+01   4.103 4.13e-05 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 127.6 on 5491 degrees of freedom
# Multiple R-squared:  0.468,	Adjusted R-squared:  0.4569 
# F-statistic: 42.01 on 115 and 5491 DF,  p-value: < 2.2e-16

#Here we see that the R^2 has increased to 0.468 by removing the outliers, and residual standard error has dropped to 127.6
#Significant predictors at the 0.05 level are all but longitude, bathrooms, bed_type, cleaning fee, and instant bookable

#Re-train the algorithm without these predictors to see if that has an impact

lm2B <-  lm(price ~ host_is_superhost + zipcode + latitude + property_type + room_type + bedrooms + beds + 
              guests_included + extra_people + minimum_nights + maximum_nights + number_of_reviews + cancellation_policy,
            data = train_listings_no_outliers)
summary(lm2B)
#Residual Standard Error increased to 130.2 and multiple r^2 decreased to 0.4418

#Let's take a look at the diagnostic plots
plot(lm2B)

#Residual vs. Fitted diagnostic plot doesn't show a large visible nonlinear pattern, but the spread of the residuals
#is more abive the line than below; the data is not equally spread.
#Normal Q-Q plot still shows vast deviance from the line beyonf the 2nd theoretical quantile
#Scale location does not have a linear line: resicuals are not spread equally
#In the Residuals vs. Leverage plot there are 2 concerning observations, #1901 and #571


#Multiple Regression #3 .........................
#THinking back to the EDA< we saw that the price output was highly skewed to the the right
#Let's try using a logarothmic transformation on the "price" output

lm3 <-  lm(log(price) ~., data = train_listings_no_outliers)
summary(lm3)

# Call:
#   lm(formula = log(price) ~ ., data = train_listings_no_outliers)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -3.9329 -0.2764 -0.0216  0.2375  2.7612 
# 
# Coefficients: (1 not defined because of singularities)
# Estimate Std. Error t value Pr(>|t|)    
# (Intercept)                                    -3.873e+02  1.513e+02  -2.560 0.010479 *  
#   host_is_superhostTRUE                           6.543e-02  1.305e-02   5.013 5.54e-07 ***
#   neighbourhood_cleansedBernal Heights            3.549e-01  1.942e-01   1.827 0.067686 .  
# neighbourhood_cleansedCastro/Upper Market       3.730e-01  2.065e-01   1.807 0.070854 .  
# neighbourhood_cleansedChinatown                 3.182e-01  2.244e-01   1.418 0.156277    
# neighbourhood_cleansedCrocker Amazon            1.904e-01  2.022e-01   0.942 0.346314    
# neighbourhood_cleansedDiamond Heights           3.537e-01  2.282e-01   1.550 0.121185    
# neighbourhood_cleansedDowntown/Civic Center     3.843e-01  2.166e-01   1.774 0.076061 .  
# neighbourhood_cleansedExcelsior                 8.776e-02  1.860e-01   0.472 0.637161    
# neighbourhood_cleansedFinancial District        4.011e-01  2.176e-01   1.844 0.065291 .  
# neighbourhood_cleansedGlen Park                 3.011e-01  2.049e-01   1.469 0.141775    
# neighbourhood_cleansedGolden Gate Park          5.204e-01  3.123e-01   1.666 0.095754 .  
# neighbourhood_cleansedHaight Ashbury            4.516e-01  2.140e-01   2.110 0.034873 *  
#   neighbourhood_cleansedInner Richmond            4.654e-01  2.626e-01   1.773 0.076355 .  
# neighbourhood_cleansedInner Sunset              3.305e-01  2.166e-01   1.526 0.127075    
# neighbourhood_cleansedLakeshore                 4.138e-01  2.265e-01   1.827 0.067733 .  
# neighbourhood_cleansedMarina                    3.497e-01  2.508e-01   1.394 0.163294    
# neighbourhood_cleansedMission                   3.290e-01  1.998e-01   1.647 0.099657 .  
# neighbourhood_cleansedNob Hill                  3.506e-01  2.211e-01   1.586 0.112775    
# neighbourhood_cleansedNoe Valley                3.985e-01  2.004e-01   1.989 0.046774 *  
#   neighbourhood_cleansedNorth Beach               3.982e-01  2.318e-01   1.718 0.085862 .  
# neighbourhood_cleansedOcean View                2.508e-01  1.982e-01   1.265 0.205825    
# neighbourhood_cleansedOuter Mission             2.934e-01  1.932e-01   1.518 0.129010    
# neighbourhood_cleansedOuter Richmond            3.303e-01  2.844e-01   1.161 0.245519    
# neighbourhood_cleansedOuter Sunset              1.871e-01  2.279e-01   0.821 0.411786    
# neighbourhood_cleansedPacific Heights           5.696e-01  2.231e-01   2.553 0.010720 *  
#   neighbourhood_cleansedParkside                  2.181e-01  2.284e-01   0.955 0.339761    
# neighbourhood_cleansedPotrero Hill              4.505e-01  2.069e-01   2.177 0.029530 *  
#   neighbourhood_cleansedPresidio                  1.347e-01  5.136e-01   0.262 0.793192    
# neighbourhood_cleansedPresidio Heights          7.866e-01  2.815e-01   2.795 0.005213 ** 
#   neighbourhood_cleansedRussian Hill              4.274e-01  2.292e-01   1.865 0.062281 .  
# neighbourhood_cleansedSeacliff                  3.443e-01  3.053e-01   1.128 0.259402    
# neighbourhood_cleansedSouth of Market           4.341e-01  2.078e-01   2.089 0.036750 *  
#   neighbourhood_cleansedTreasure Island/YBI       8.321e-01  5.171e-01   1.609 0.107659    
# neighbourhood_cleansedTwin Peaks                3.396e-01  2.114e-01   1.606 0.108300    
# neighbourhood_cleansedVisitacion Valley         1.865e-01  1.886e-01   0.989 0.322827    
# neighbourhood_cleansedWest of Twin Peaks        2.856e-01  2.057e-01   1.389 0.164971    
# neighbourhood_cleansedWestern Addition          4.829e-01  2.127e-01   2.271 0.023212 *  
#   zipcode94015                                    5.257e-03  3.324e-01   0.016 0.987381    
# zipcode94102                                   -3.187e-01  1.427e-01  -2.233 0.025566 *  
#   zipcode94103                                   -7.501e-03  1.342e-01  -0.056 0.955435    
# zipcode94104                                    1.558e-01  2.118e-01   0.736 0.461917    
# zipcode94105                                    7.100e-02  1.493e-01   0.476 0.634356    
# zipcode94107                                    9.168e-03  1.455e-01   0.063 0.949765    
# zipcode94108                                   -1.192e-01  1.497e-01  -0.796 0.426098    
# zipcode94109                                   -1.675e-01  1.466e-01  -1.142 0.253341    
# zipcode94110                                    3.636e-02  1.250e-01   0.291 0.771209    
# zipcode94111                                   -6.057e-03  1.691e-01  -0.036 0.971424    
# zipcode94112                                    2.079e-02  9.897e-02   0.210 0.833580    
# zipcode94114                                    4.491e-02  1.259e-01   0.357 0.721425    
# zipcode94115                                   -2.308e-01  1.465e-01  -1.576 0.115066    
# zipcode94116                                   -9.221e-02  1.449e-01  -0.637 0.524450    
# zipcode94117                                   -1.779e-01  1.373e-01  -1.296 0.195021    
# zipcode94118                                   -3.332e-01  2.000e-01  -1.666 0.095755 .  
# zipcode94121                                   -3.713e-01  2.227e-01  -1.667 0.095523 .  
# zipcode94122                                   -1.594e-01  1.444e-01  -1.104 0.269669    
# zipcode94123                                   -1.132e-01  1.828e-01  -0.619 0.535913    
# zipcode94124                                    2.252e-01  2.172e-01   1.037 0.299916    
# zipcode94127                                   -6.605e-02  1.204e-01  -0.549 0.583210    
# zipcode94129                                   -1.911e-01  4.534e-01  -0.421 0.673474    
# zipcode94130                                           NA         NA      NA       NA    
# zipcode94131                                    4.196e-02  1.175e-01   0.357 0.721106    
# zipcode94132                                   -8.767e-03  1.266e-01  -0.069 0.944792    
# zipcode94133                                   -1.100e-01  1.562e-01  -0.704 0.481346    
# zipcode94134                                    1.208e-01  1.268e-01   0.953 0.340600    
# zipcode94158                                    1.443e-01  1.513e-01   0.954 0.340262    
# latitude                                        6.294e+00  1.618e+00   3.890 0.000102 ***
#   longitude                                      -1.258e+00  1.048e+00  -1.200 0.230083    
# property_typeApartment                         -2.749e-01  7.856e-02  -3.499 0.000471 ***
#   property_typeBed and breakfast                 -3.133e-01  1.123e-01  -2.788 0.005315 ** 
#   property_typeBoutique hotel                     3.076e-01  8.481e-02   3.627 0.000290 ***
#   property_typeBungalow                          -3.273e-01  1.712e-01  -1.911 0.056047 .  
# property_typeCabin                             -5.870e-01  4.360e-01  -1.346 0.178213    
# property_typeCamper/RV                         -2.047e+00  4.376e-01  -4.676 2.99e-06 ***
#   property_typeCastle                             9.768e-02  3.143e-01   0.311 0.755946    
# property_typeCondominium                       -1.051e-01  7.998e-02  -1.315 0.188710    
# property_typeCottage                            1.981e-02  1.637e-01   0.121 0.903657    
# property_typeDome house                        -6.710e-01  4.372e-01  -1.535 0.124889    
# property_typeEarth house                        8.503e-02  3.139e-01   0.271 0.786466    
# property_typeGuest suite                       -2.377e-01  8.262e-02  -2.877 0.004032 ** 
#   property_typeGuesthouse                        -1.902e-01  1.142e-01  -1.665 0.096013 .  
# property_typeHostel                            -3.927e-01  9.684e-02  -4.055 5.09e-05 ***
#   property_typeHotel                              4.062e-01  8.937e-02   4.545 5.61e-06 ***
#   property_typeHouse                             -1.930e-01  7.913e-02  -2.439 0.014768 *  
#   property_typeHut                               -1.981e-01  4.357e-01  -0.455 0.649353    
# property_typeIn-law                            -9.765e-02  4.370e-01  -0.223 0.823189    
# property_typeLoft                               4.172e-04  9.679e-02   0.004 0.996561    
# property_typeOther                              9.700e-02  1.355e-01   0.716 0.474270    
# property_typeResort                             1.060e+00  1.554e-01   6.825 9.76e-12 ***
#   property_typeServiced apartment                -1.216e-01  9.213e-02  -1.320 0.186896    
# property_typeTiny house                        -1.192e-01  2.606e-01  -0.457 0.647352    
# property_typeTownhouse                         -1.830e-01  8.883e-02  -2.060 0.039454 *  
#   property_typeVilla                             -5.440e-02  1.831e-01  -0.297 0.766373    
# room_typeHotel room                            -5.600e-01  4.590e-02 -12.201  < 2e-16 ***
#   room_typePrivate room                          -3.742e-01  1.678e-02 -22.302  < 2e-16 ***
#   room_typeShared room                           -1.154e+00  4.052e-02 -28.468  < 2e-16 ***
#   accommodates                                    1.148e-01  6.587e-03  17.425  < 2e-16 ***
#   bathrooms                                      -2.959e-02  7.948e-03  -3.723 0.000198 ***
#   bedrooms                                        1.817e-01  1.163e-02  15.624  < 2e-16 ***
#   beds                                           -4.146e-02  1.002e-02  -4.138 3.56e-05 ***
#   bed_typeCouch                                   3.094e-01  2.476e-01   1.250 0.211424    
# bed_typeFuton                                   8.069e-02  1.757e-01   0.459 0.646022    
# bed_typePull-out Sofa                           1.199e-01  1.939e-01   0.619 0.536146    
# bed_typeReal Bed                                1.155e-01  1.525e-01   0.757 0.449066    
# security_deposit                                2.618e-06  9.400e-06   0.278 0.780653    
# cleaning_fee                                    2.041e-05  9.270e-05   0.220 0.825755    
# guests_included                                 2.561e-02  5.839e-03   4.387 1.17e-05 ***
#   extra_people                                    1.178e-03  2.116e-04   5.564 2.76e-08 ***
#   minimum_nights                                  1.139e-05  4.012e-06   2.839 0.004544 ** 
#   maximum_nights                                 -1.140e-05  4.012e-06  -2.840 0.004527 ** 
#   number_of_reviews                              -3.630e-04  8.476e-05  -4.283 1.87e-05 ***
#   instant_bookableTRUE                           -2.590e-02  1.258e-02  -2.058 0.039641 *  
#   cancellation_policymoderate                     2.932e-02  1.763e-02   1.663 0.096355 .  
# cancellation_policystrict                      -1.759e-01  5.586e-02  -3.149 0.001649 ** 
#   cancellation_policystrict_14_with_grace_period -3.513e-02  1.616e-02  -2.173 0.029787 *  
#   cancellation_policysuper_strict_30             -4.661e-02  8.149e-02  -0.572 0.567335    
# cancellation_policysuper_strict_60              3.912e-01  1.334e-01   2.932 0.003379 ** 
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.4268 on 5491 degrees of freedom
# Multiple R-squared:  0.6179,	Adjusted R-squared:  0.6099 
# F-statistic: 77.21 on 115 and 5491 DF,  p-value: < 2.2e-16

#using the log() function to normally distribute the price data, we see signifcance in superhost, neighborhood_cleansed, latitude, property type,
#room type, accommodates, bathrooms, bedrooms, beds, guests included, extra people, max and min nights, reviews, instant_bookable, and cancellation policy

#standard error is 0.4275 and R^2 increases to 0.6118

#re-train with only the significant predictors
lm3A <- lm(log(price) ~ host_is_superhost + neighbourhood_cleansed + latitude + property_type + room_type + accommodates + bathrooms + bedrooms + beds +
             guests_included + extra_people + minimum_nights + maximum_nights + number_of_reviews + instant_bookable + cancellation_policy, 
           data = train_listings_no_outliers)
summary(lm3A)

# Call:
#   lm(formula = log(price) ~ host_is_superhost + neighbourhood_cleansed + 
#        latitude + property_type + room_type + accommodates + bathrooms + 
#        bedrooms + beds + guests_included + extra_people + minimum_nights + 
#        maximum_nights + number_of_reviews + instant_bookable + cancellation_policy, 
#      data = train_listings_no_outliers)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -3.8872 -0.2786 -0.0219  0.2360  2.7690 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)                                    -2.071e+02  4.823e+01  -4.294 1.79e-05 ***
# host_is_superhostTRUE                           6.047e-02  1.297e-02   4.661 3.23e-06 ***
# neighbourhood_cleansedBernal Heights            2.122e-01  4.705e-02   4.510 6.63e-06 ***
# neighbourhood_cleansedCastro/Upper Market       2.683e-01  6.105e-02   4.395 1.13e-05 ***
# neighbourhood_cleansedChinatown                 5.585e-02  1.004e-01   0.556 0.578001    
# neighbourhood_cleansedCrocker Amazon            4.203e-02  8.622e-02   0.487 0.625952    
# neighbourhood_cleansedDiamond Heights           2.516e-01  1.176e-01   2.140 0.032427 *  
# neighbourhood_cleansedDowntown/Civic Center    -3.022e-03  8.428e-02  -0.036 0.971397    
# neighbourhood_cleansedExcelsior                -3.528e-02  5.278e-02  -0.668 0.503887    
# neighbourhood_cleansedFinancial District        2.185e-01  9.490e-02   2.302 0.021374 *  
# neighbourhood_cleansedGlen Park                 1.784e-01  7.537e-02   2.367 0.017986 *  
# neighbourhood_cleansedGolden Gate Park          1.789e-01  2.230e-01   0.802 0.422415    
# neighbourhood_cleansedHaight Ashbury            1.624e-01  6.829e-02   2.377 0.017469 *  
# neighbourhood_cleansedInner Richmond            4.235e-02  8.097e-02   0.523 0.601029    
# neighbourhood_cleansedInner Sunset              8.460e-02  6.513e-02   1.299 0.193985    
# neighbourhood_cleansedLakeshore                 2.994e-01  7.432e-02   4.029 5.67e-05 ***
# neighbourhood_cleansedMarina                    1.316e-01  1.048e-01   1.255 0.209412    
# neighbourhood_cleansedMission                   1.937e-01  5.504e-02   3.520 0.000435 ***
# neighbourhood_cleansedNob Hill                  5.902e-02  9.298e-02   0.635 0.525610    
# neighbourhood_cleansedNoe Valley                2.903e-01  5.340e-02   5.437 5.65e-08 ***
# neighbourhood_cleansedNorth Beach               1.579e-01  1.076e-01   1.467 0.142469    
# neighbourhood_cleansedOcean View                1.166e-01  5.742e-02   2.031 0.042341 *  
# neighbourhood_cleansedOuter Mission             1.543e-01  5.184e-02   2.977 0.002925 ** 
# neighbourhood_cleansedOuter Richmond           -9.500e-02  8.081e-02  -1.176 0.239802    
# neighbourhood_cleansedOuter Sunset             -2.767e-02  5.888e-02  -0.470 0.638438    
# neighbourhood_cleansedPacific Heights           2.564e-01  9.708e-02   2.641 0.008284 ** 
# neighbourhood_cleansedParkside                  4.072e-02  6.158e-02   0.661 0.508447    
# neighbourhood_cleansedPotrero Hill              2.735e-01  6.154e-02   4.444 9.00e-06 ***
# neighbourhood_cleansedPresidio                 -2.551e-01  4.423e-01  -0.577 0.564068    
# neighbourhood_cleansedPresidio Heights          3.634e-01  1.409e-01   2.580 0.009919 ** 
# neighbourhood_cleansedRussian Hill              1.444e-01  1.058e-01   1.364 0.172508    
# neighbourhood_cleansedSeacliff                 -6.655e-02  1.306e-01  -0.510 0.610266    
# neighbourhood_cleansedSouth of Market           2.874e-01  7.486e-02   3.839 0.000125 ***
# neighbourhood_cleansedTreasure Island/YBI       6.726e-01  4.493e-01   1.497 0.134473    
# neighbourhood_cleansedTwin Peaks                2.493e-01  7.611e-02   3.276 0.001059 ** 
# neighbourhood_cleansedVisitacion Valley         9.913e-02  6.908e-02   1.435 0.151333    
# neighbourhood_cleansedWest of Twin Peaks        1.108e-01  5.779e-02   1.917 0.055247 .  
# neighbourhood_cleansedWestern Addition          1.380e-01  7.486e-02   1.844 0.065256 .  
# latitude                                        5.609e+00  1.278e+00   4.388 1.17e-05 ***
# property_typeApartment                         -2.844e-01  7.809e-02  -3.642 0.000273 ***
# property_typeBed and breakfast                 -3.282e-01  1.119e-01  -2.934 0.003359 ** 
# property_typeBoutique hotel                     2.764e-01  8.276e-02   3.340 0.000844 ***
# property_typeBungalow                          -3.370e-01  1.712e-01  -1.968 0.049089 *  
# property_typeCabin                             -6.169e-01  4.365e-01  -1.413 0.157607    
# property_typeCamper/RV                         -2.072e+00  4.355e-01  -4.759 2.00e-06 ***
# property_typeCastle                             1.086e-01  3.144e-01   0.345 0.729898    
# property_typeCondominium                       -1.079e-01  7.948e-02  -1.357 0.174720    
# property_typeCottage                            1.253e-02  1.632e-01   0.077 0.938789    
# property_typeDome house                        -6.677e-01  4.377e-01  -1.525 0.127262    
# property_typeEarth house                        1.099e-01  3.129e-01   0.351 0.725348    
# property_typeGuest suite                       -2.427e-01  8.220e-02  -2.952 0.003166 ** 
# property_typeGuesthouse                        -1.911e-01  1.140e-01  -1.676 0.093756 .  
# property_typeHostel                            -4.144e-01  9.569e-02  -4.331 1.51e-05 ***
# property_typeHotel                              3.460e-01  8.724e-02   3.966 7.40e-05 ***
# property_typeHouse                             -2.003e-01  7.862e-02  -2.547 0.010878 *  
# property_typeHut                               -1.930e-01  4.364e-01  -0.442 0.658258    
# property_typeIn-law                            -1.014e-01  4.362e-01  -0.233 0.816111    
# property_typeLoft                              -4.929e-03  9.598e-02  -0.051 0.959043    
# property_typeOther                              1.010e-01  1.350e-01   0.748 0.454683    
# property_typeResort                             1.081e+00  1.555e-01   6.954 3.96e-12 ***
# property_typeServiced apartment                -1.187e-01  9.072e-02  -1.308 0.190951    
# property_typeTiny house                        -1.159e-01  2.604e-01  -0.445 0.656296    
# property_typeTownhouse                         -1.936e-01  8.839e-02  -2.190 0.028576 *  
# property_typeVilla                             -4.590e-02  1.823e-01  -0.252 0.801273    
# room_typeHotel room                            -5.659e-01  4.556e-02 -12.421  < 2e-16 ***
# room_typePrivate room                          -3.733e-01  1.617e-02 -23.091  < 2e-16 ***
# room_typeShared room                           -1.155e+00  3.963e-02 -29.154  < 2e-16 ***
# accommodates                                    1.145e-01  6.540e-03  17.509  < 2e-16 ***
# bathrooms                                      -3.003e-02  7.835e-03  -3.833 0.000128 ***
# bedrooms                                        1.862e-01  1.132e-02  16.451  < 2e-16 ***
# beds                                           -4.135e-02  9.971e-03  -4.147 3.41e-05 ***
# guests_included                                 2.567e-02  5.824e-03   4.407 1.07e-05 ***
# extra_people                                    1.183e-03  2.107e-04   5.616 2.05e-08 ***
# minimum_nights                                  1.063e-05  4.012e-06   2.649 0.008102 ** 
# maximum_nights                                 -1.063e-05  4.012e-06  -2.650 0.008071 ** 
# number_of_reviews                              -3.361e-04  8.310e-05  -4.045 5.31e-05 ***
# instant_bookableTRUE                           -2.604e-02  1.245e-02  -2.091 0.036543 *  
# cancellation_policymoderate                     3.393e-02  1.754e-02   1.934 0.053162 .  
# cancellation_policystrict                      -1.885e-01  5.376e-02  -3.506 0.000459 ***
# cancellation_policystrict_14_with_grace_period -2.834e-02  1.589e-02  -1.783 0.074685 .  
# cancellation_policysuper_strict_30             -6.110e-02  8.071e-02  -0.757 0.449057    
# cancellation_policysuper_strict_60              4.237e-01  1.261e-01   3.361 0.000782 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.4276 on 5525 degrees of freedom
# Multiple R-squared:  0.6141,	Adjusted R-squared:  0.6084 
# F-statistic: 108.5 on 81 and 5525 DF,  p-value: < 2.2e-16

#Standard error is 0.4276 and R^2 is 0.614, p-value of the f statistic is < 2.2e-16 which is highly significant


#Lets plot diagnostics
plot(lm3A)
#Residuals vs. Fitted plots shows a linear relationship with a linear red line, and residuals plotted fairly equally along the line
#except for a few more spread points toward the top left
#Normal Q-Q looks much better than previous diagnostics, though there is still some  deviance from the line a the lower left and upper right
#Scale location plot looks good, save for a few outliers 571 and 5169 Other than those observations, the residuals seem
#to be equally distributed aling the visibly linear line.
#The residuals vs leverage plot shows 2 influential outlier cases out of Cooks distance, 571 (which was also 
#an outlier in the scale location plot) and 1901 

#.................................................................................................................................
# Determine model accuracy (Train set)
#.................................................................................................................................

summary(lm3A)
# Residual standard error: 0.4276 on 5525 degrees of freedom (the average difference between the observed outcome values and the predicted values by the model)
# Multiple R-squared:  0.6141,	Adjusted R-squared:  0.6084 (correlation coefficient between the observed outcome values and the predicted values)
# F-statistic: 108.5 on 81 and 5525 DF,  p-value: < 2.2e-16 ( overall significance of the mode)

#RSE is low which is good, Multiple R^2 is 0.61 which is good but not great (higher would be more predictive), and F-statistic
#is very low (below 0.05 threshold) which is good


#.................................................................................................................................
# Use the trained model to predict the output of test set
#.................................................................................................................................

#we want to make sure we are using the test set length 2403 that has the outliers removed and includes observations where 
#price >0 and price <1500
predict_test <- predict(lm3A, newdata=test_listings_no_outliers) 

#plot the actual vs. predicted price for the test set
plot(test_listings_no_outliers$price, exp(predict_test))

cor(predict_test, test_listings_no_outliers$price)
#[1] 0.6170431

#.................................................................................................................................
# Determine model performace (Test set)
#.................................................................................................................................

# Compute the prediction error, RMSE

RMSE = function(m, o){
  sqrt(mean((m - o)^2))
}
#m is for model (fitted) values, o is for observed (true) values.

# Compute the prediction error, RMSE
RMSE(predict_test, test_listings_no_outliers$price)
#[1] 263.5824

# Compute R-square

y_hat <- exp(predict_test) # y-hat
y <- test_listings_no_outliers$price  # y
rsquared(y_hat, y)  
#[1] 0.4041976

#R2 closer to 1 is better,  0.4042 is realtively low. Predicted outcome prices are not highly correlated for the test set

#graphically:

par(mfrow=c(1,2))

plot(exp(lm3A$fitted.values), train_listings_no_outliers$price,
     main= "Train Data, (Fitted vs. Actual)",
     xlab = "Fitted Price Values",
     ylab = "Actual Price Values")
abline(0,1, col= 2)


plot(exp(predict_test), test_listings_no_outliers$price,
     main= "Test Data, (Fitted vs. Actual)",
     xlab = "Fitted Price Values",
     ylab = "Actual Price Values")
abline(0,1, col= 2)


