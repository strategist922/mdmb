

mdmb_regression_ic <- function( N, beta, deviance, type, index_beta, index_sigma,
	index_lambda )
{			
	ic <- list( n = N , deviance = deviance )
	#-- estimated parameters	
	ic$np.beta <- length(index_beta)
	ic$np.sigma <- length(index_sigma)
	ic$np.lambda <- length(index_lambda)	
	ic$np <- np <- ic$np.beta + ic$np.sigma + ic$np.lambda		
	#--- information criteria
	ic$AIC <- ic$deviance + 2 * np	
	ic$AICc <- ic$deviance + 2 * np	+ 2*np*(np+1)/(N-np-1)
	ic$BIC <- ic$deviance + log(N) * np	
	ic$CAIC <- ic$deviance + ( log(N) + 1 ) * np	
	#--- output
	return(ic)
}
	
