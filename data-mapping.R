test_data <- read.csv('data/test_data.csv')
test_data

powell_data <- read.csv('data/Powell Monographs Weeding 2022.csv')
powell_data


powell_data_mapped <- data.frame(test_data) # create a copy
powell_data_mapped[,] <- 0 # 0-out everything
powell_data_mapped <- powell_data_mapped[1:nrow(powell_data),] # cut it to match the length of the powell data


powell_data_mapped$oclc_num <- as.numeric(powell_data$OCLC.Control.Number..035a.)

powell_data_mapped$title <- powell_data$Title

powell_data_mapped$author <- powell_data$Author


# we need to clean this up to only have the date and not the time
powell_data_mapped$last_checkin <- format(as.Date(powell_data$Last.Loan.Date), "%Y-%m-%d")

powell_data_mapped$checkout_total <- powell_data$Num.of.Loans..In.House...Not.In.House.


powell_data_mapped$call_num_prefix <- gsub("[^[:alpha:]].*", "", powell_data$Permanent.Call.Number) # extract all the letters before the first digit
powell_data_mapped$lc_class <- as.character(substr(powell_data_mapped$call_num_prefix, 1, 1))

powell_data_mapped$country <- powell_data$Place.of.Publication...Country

powell_data_mapped$language_code <-  powell_data$Language.Code


# we need to clean this up by extracting the first set of yearsx
powell_data_mapped$pub_date <- as.integer(sub("[^0-9]*([0-9]+).*", "\\1", powell_data$Publication.Date)) 

powell_data_mapped

write.csv(powell_data_mapped, file = "data/powell-data.csv", row.names = FALSE)
