
mdmb_regression_extract_parameters <- function( mod , parnames , type , 
	is_lambda_fixed , lambda_fixed)
{			
	beta <- mod$par
	if ( ( type %in% c("yjt","bct") ) & ( is_lambda_fixed ) ){
		beta <- c( beta , lambda_fixed )
	}	
	names(beta) <- parnames
	return(beta)
}	
