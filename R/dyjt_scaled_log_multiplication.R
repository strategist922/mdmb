
dyjt_scaled_log_multiplication <- function( dy , yt , use_log )
{
	if (use_log){
		dy <- dy + log(yt)
	} else {
		dy <- dy * yt		
	}
	dy[ is.na(dy) ] <- 0	
	return(dy)
}
	