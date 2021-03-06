#Completely copied from https://github.com/chappers/CS7641-Machine-Learning/blob/master/Unsupervised%20Learning/R/random_projection_gauss.R

johnson_loindenstrauss_min_dim <- function(n_samples, eps=0.1) {
    
    denominator = (eps ** 2 / 2) - (eps ** 3 / 3)
    
    # the min function is required in this case, due to the theorem 
    
    # which says that we require k0 to be less than k. 
    
    return (min(floor(4 * log(n_samples) / denominator),n_samples))
    
}



gaussian_random_proj <- function(row, col) {
    
    mat <- rnorm(row*col, 0, 1/(row**0.5))
    
    dim(mat) <- c(row, col)
    
    return(mat)
    
}



gaussian_random_projection <- function(A, n_features=NULL, eps=0.1) {
    
    # convert to matrix if the format is a dataframe.
    
    if (is.data.frame(A)) {
        
        #check_numeric types
        
        if (sum(sapply(A, is.numeric)) != length(names(A))){
            
            warning("Not all columns are numeric. Non-numeric columns will be ignored.")
            
        }
        
        A <- as.matrix(A[, sapply(A, is.numeric)])        
        
    }
    
    
    
    get_dim <- dim(A)
    
    if (is.null(n_features)){
        
        n_features = johnson_loindenstrauss_min_dim(get_dim[2]) # we want to reduce the number of features!
        
    }
    
    R = gaussian_random_proj(get_dim[2], n_features)
    
    
    
    return(list(A=A, R=R, RP=A %*% as.matrix(R)))
    
}



rowA <- 4

colA <- 4

A <- rnorm(rowA*colA)

dim(A) <- c(rowA, colA)



E <- gaussian_random_projection(A, n_features=2)