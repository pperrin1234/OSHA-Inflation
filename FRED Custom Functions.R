###### Intro ###############################################

# This script is separate, for cleanliness's sake. Think of it as a custom
# library, useful across multiple projects.

# The functions vary in what they return. Some return an entire dataframe,
# while others return just a single column.

###### Strip Columns ###############################################

# Takes a FRED dataframe and removes its superfluous columns--namely the
# series ID, and realtime starts and ends

fred_strip <- function(series){
  
  result <- series %>%
    transmute(
      date,
      value
    )
  
  return(result)
  
}

###### Date To Year ###############################################

# Transforms date data to annual, taking the simple mean
date_to_year <- function(series){
  
  year <- format(as.Date(series$date,format = "%d/%m/%Y"),"%Y")
  
  result <- cbind(year,
                  values = series$value) %>%
    as_tibble() %>%
    group_by(year) %>%
    summarize(value = mean(as.numeric(values))) %>%#,
    #median = median(as.numeric(values))) # Implement later!
    ungroup() %>%
    mutate(date = as.Date(paste0(year,"-01","-01"))) # Listed as start-of-year for visual clarity (1947 lines up at 1947, for example)
  
  # Cleanup
  rm(year)
  
  return(result)
}

###### Take Derivative ###############################################

# This function takes the derivative of a given FRED series
take_derivative <- function(series,column){
  
  result <- series %>%
    mutate(rate = (column-lag(column))/lag(column))
  
  return(result$rate)
  
}

##### Rate to Indexed ###############################################

# Sometimes, FRED data is in rate-form (ex: 2% inflation in x year),
# rather than indexed (ex: 2006 is 100, while 2010 is 110, so prices inflated
# 10% in between the two periods).
# I want all my data to be in indexed form, so this function converts from
# rate to indexed.
# The output works by making the first period the indexed year, but this can easily
# be changed by dividing every year by the value of the new year you want.

rate_to_indexed <- function(series){
  # NOTE: make sure it's in decimal form, ex 2% = .02, not 2.0!

  indexed_value <- 1 # As though we're indexing to the first year in the data
  new_col <- c(indexed_value)
  
  for (j in 2:nrow(series)){ # Skip the first row!
    
    indexed_value <- indexed_value*(1+series[j,]$value)
    
    new_col <- append(new_col,indexed_value)
    
  }
  
  # Change to 100 unit base instead of 1, as is customary on FRED
  new_col <- new_col*100
  
  return(new_col)
  
}

###### Deflate ###############################################

# Deflates a given nominal yearly series, using a deflator
# Deflation works by taking the indexed year, and inferring future and past values based on the deflator

deflate <- function(series,deflator,indexed_year){
  
  deflation_value <- deflator %>%
    filter(date == indexed_year) %>%
    .$value
  
  result_deflator <- deflator %>%
    transmute(date,
              deflation_index = value/deflation_value)
  
  result <- left_join(series,
                      result_deflator,
                      by = "date") %>%
    mutate(real_value = value/deflation_index)
  
  return(result$real_value)
  
}

###### Inflate ###############################################

# This is the opposite of inflating, in which the nominal value of some
# past year is updated to the nominal value of some other year.
# Note that this function is kinda under-engineered!

inflate <- function(initial_value, initial_year, inflator){
  
  inflator_adjusted <- 
  
  result <- inflator*initial_value
  
  return(result)
  
}

###### Provide Series ID ###############################################

# Provide Series ID
# This is necessary for the dashboard to work, as it provides color based on this column.
# At the end of radical transformation, I must provide a new series ID

provide_series_id <- function(series,new_id){
  
  result <-
    series %>%
    mutate(series_id = as.character(new_id))
  
  return(result)
}

###### Check Yearly ###############################################

# Checks if a series is yearly, e.g. each row corresponds to a unique year.
# This is useful for automatically cleaning multiple series.

check_yearly <- function(series){
  
  count_years <- format(as.Date(series$date,format = "%d/%m/%Y"),"%Y") %>% unique
  
  flag_yearly <- nrow(series) == length(count_years) # True/False
  
  return(flag_yearly)
  
}

###### Check Derivative ###############################################

# Checks if a series is a derivative or not. This helps standardize a variety
# of series to be in the same format.

check_derivative <- function(series){
  # Technically, this is not a 100% robust function, but the odds of a given
  # time period having more than 100% inflation seems very unlikely.
  
  analysis <- series %>%
    mutate(above_100 = ifelse(value >= 100, TRUE, FALSE))
  
  num_true <- nrow(filter(analysis, above_100 == TRUE))
  
  flag_derivative <- num_true == 0
    
  return(flag_derivative)
  
}
