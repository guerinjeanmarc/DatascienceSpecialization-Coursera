rankhospital <- function(state, outcome, num) {
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = 
                                 "character")[,c(2,7,11,17,23)]
        
        ## Check that state and outcome are valid
        if (!(state %in% unique(data[,2]))) stop("invalid state")
        
        if (outcome == "heart attack") col <- 3
        else if (outcome == "pneumonia") col <- 5
        else if (outcome == "heart failure") col <- 4
        else stop("invalid outcome")
            
        
        ## Return hospital name in that state with the given rank 
        ## 30-day death rate
        
        ## Remove data not from state
        data <- data[data[,2] == state,]
        
        ## Remove data from other outcome
        data <- data[,c(1,col)]
        data[,2]<- suppressWarnings(as.numeric(data[,2]))
        names(data) <- c("Name", "Deaths")
        
        ## Remove rows with NA
        data <- data[!is.na(data[,2]),]
        
        if (class(num)=="numeric" && num > nrow(data)) {return(NA)}
        if (num =="best") num <-1
        if (num == "worst") {num <- nrow(data)}
        
        ## order
        data <- data[order(data[,2], data[,1]),]
        result<- data[num,1]
        result
        
}