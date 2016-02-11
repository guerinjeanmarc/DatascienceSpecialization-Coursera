rankall <- function(outcome, num = "best"){
        ## Read outcome data
        data <- read.csv("outcome-of-care-measures.csv", colClasses = 
                                 "character")[,c(2,7,11,17,23)]
        
        ## Check that state and outcome are valid
        if (!(state %in% unique(data[,2]))) stop("invalid state")
        
        if (outcome == "heart attack") col <- 3
        else if (outcome == "pneumonia") col <- 5
        else if (outcome == "heart failure") col <- 4
        else stop("invalid outcome")
        
        ## Remove data from other outcome
        data <- data[,c(1,2,col)]
        data[,3]<- suppressWarnings(as.numeric(data[,3]))
        names(data) <- c("hospital", "state", "deaths")
        
        ## For each state, find the hospital of the given rank
        data_ordered <- data[order(data$state, data$death, data$hospital),]
        answer <- data.frame()
        splitted<-split(data_ordered,data_ordered$state)
        answer <- lapply(splitted, function(x, num) {
                if (num == "worst") num <-nrow(x)
                else if (num == "best") num <- 1
                x <- x$hospital[num]
        }, num)
        
        
        ## Return a data frame with the hospital names and the state name
        answer <- data.frame(hospital=unlist(answer), state=names(answer))
        
}