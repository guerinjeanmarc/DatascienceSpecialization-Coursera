## These functions cache the values of a matrix, compute its inverse using the
## solve() function and cache the values of the result. If the matrix needs
## to be inverted again, it retrieves the inverse from the cache.

## makeCacheMatrix creates a special "matrix" object that can cache its inverse

makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        setmx <- function(y) {
                x <<- y
                m <<- NULL
        }
        getmx <-function() x
        setinv <- function(solve) m <<- solve
        getinv <- function() m
        list(setmx = setmx, getmx = getmx, setinv = setinv, getinv = getinv)
}


## cacheSolve calculates the inverse of the special "matrix" created with
## makeCacheMatrix. If the inverse has already been calculated, it retrieves
## the inverse from the cache.

cacheSolve <- function(x, ...) {  ## Return a matrix that is the inverse of 'x'
        m <- x$getinv()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$getmx()
        m <- solve(data, ...)
        x$setinv(m)
        m
}
