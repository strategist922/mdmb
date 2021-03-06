
frm_fb_init_imputations <- function( Nimp , model_results, burnin ,
		iter , impute_vars , impute_vars_index, ind_miss, ind0, dv_vars,
 		variablesMatrix )
{
	Nimp <- min( iter - burnin , Nimp )	
	imp_save <- round( seq( burnin + 1 , iter , length= Nimp ) )
	NV <- length(impute_vars)
	#--- objects for imputed values
	values <- as.list( 1:NV )
	names(values) <- impute_vars
	mh_imputations_values <- values
	impute_vars_models <- values
	for (vv in 1:NV){
		# vv <- 1
		var_vv <- impute_vars[vv]		
		N_vv <- length(ind_miss[[ var_vv ]])
		#**** matrices for imputed values
		values[[var_vv]] <- matrix( NA, nrow=N_vv , ncol=Nimp )
		#*** informations for MH sampling
		M1 <- matrix( 0 , nrow=N_vv , ncol=3 )
		colnames(M1) <- c("accepted" , "iter" , "sd_proposal")
		M1 <- as.data.frame(M1)
		mm <- which( var_vv == dv_vars )
		model_mm <- ind0[[mm]]$model
		if ( model_mm %in% c("bctreg","yjtreg","linreg") ){
			parm <- ind0[[mm]]$coef
			np <- length(parm)
			if ( model_mm == "linreg" ){
				ind_sigma <- np + 1
				parm <- c( parm , ind0[[mm]]$sigma )
			}
			if ( model_mm %in% c("bctreg","yjtreg") ){
				ind_sigma <- np - 1
			}			
			ind0[[mm]]$sigma <- parm[ ind_sigma ]
		}
		M1$sd_proposal <- ind0[[mm]]$sigma
		mh_imputations_values[[ var_vv ]] <- M1
		#*** necessary models
		v1 <- names( variablesMatrix[ var_vv , ] == 1 )
		impute_vars_models[[ var_vv ]] <- sort( match( v1 , dv_vars ) )
	}
	iter_save_temp <- imp_save[1]
	saved_index <- 1	
	#--- output
	res <- list(Nimp=Nimp, imp_save = imp_save, impute_vars=impute_vars,
				impute_vars_index=impute_vars_index, NV = NV, ind_miss=ind_miss ,
				values = values , mh_imputations_values = mh_imputations_values,
				variablesMatrix=variablesMatrix, 
				iter_save_temp=iter_save_temp, saved_index = saved_index , 
				impute_vars_models=impute_vars_models
					)
	return(res)
}
