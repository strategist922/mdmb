
bc_trafo <- function( y , lambda )
{
	eps <- 1E-3
	# lambda <- yj_adjust_lambda( lambda = lambda , lambda0 = 0 , eps = eps )
	if ( abs(lambda) > eps ){
		yt <- ( y^lambda - 1 ) / lambda
	} else {
		yt <- log(y)
	}
	return(yt)
}
