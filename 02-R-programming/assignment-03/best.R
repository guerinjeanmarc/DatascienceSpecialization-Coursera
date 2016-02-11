best <- function(state, outcome) {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", 
                            colClasses = "character")
        
        ## Check that state is valid
        states <- unique(data[,7])
        if (!(state %in% states)) stop("invalid state")
        
        ## Assign column to outcome
        if (outcome == "heart attack") col <- 11
        else if (outcome == "pneumonia") col <- 23
        else if (outcome == "heart failure") col <- 17
        else stop("invalid outcome")
        
        ##Return hospital name in that state with lowest 30-day death rate
        state_bool <- data[,7]==state
        outcome_num <- as.numeric(data[,col])
        min_value <- min(outcome_num[state_bool], na.rm = TRUE)
        hosp_name_NA <- data[,2][state_bool & as.numeric(data[,col])==min_value]
        hosp_name <- hosp_name_NA[!is.na(hosp_name_NA)]
        hosp_name
}