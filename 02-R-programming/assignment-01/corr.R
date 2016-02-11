corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
        files_list <- list.files(directory, full.names = TRUE)
        corr <- vector(mode = "numeric", length = 0)
        for (i in 1:length(files_list)) {
                dat <- read.csv(files_list[i])
                comp <- (complete.cases(dat[,"Date"], dat[,"sulfate"], 
                        dat[,"nitrate"], dat[,"ID"]))
                if (sum(comp) > threshold) {
                        corr <- c(corr, cor(dat[,"sulfate"][comp],
                                                  dat[, "nitrate"][comp]))
                } 
        }
        corr
}