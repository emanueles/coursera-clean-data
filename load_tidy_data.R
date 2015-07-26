# Loads the tidy dataset output by run_analysis.R as recommended in the very 
# helpful thread by David Hood
# https://class.coursera.org/getdata-030/forum/thread?thread_id=37
#
# It assumes that tidyData.txt is in the current directory.

tidyDataName <- "tidyData.txt"
data <- read.table(tidyDataName, header = TRUE, quote="")
View(data)