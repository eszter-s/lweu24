cleaning_2024 <- function(ds) {
  
  ###### Correcting for unauthorised routing #######
  
  #Non-workers answering employment questions via back button
  
  routing.list <- c("D752",	"D773", "D709", "D708", "D710", "D742", "D711", "D772", 
                    "D716", "D704", "D739", "D746" )
  
  for(var in routing.list){
  for(i in nrow(ds)){
  if(ds[i,"D701"]!=1 & ds[i,"D701"]!=2 & ds[i,"D701"]!=3 | is.na(ds[i,"D701"])){
    ds[i, var] <- NA
  }else{ds[i,var] <- ds[i, var]}
  }
  }
    
  ######## Dropouts ###########
  
  ##Rule: Valid interview if the respondent did not drop out before page 54 - household questions
  
  ds_clean <- ds[!(ds$LASTPAGE<54),]

  ######## Item nonresponse #######
  
  #Rule: Valid interview if there are less than 50% item nonresponse for core questions
  # Demographics (B, F, H section), paradata, routed questions (most of D section) are excluded
  # Training questions excluded
  # Sensitive questions (income, disability, healthcare, G section) excluded
  # A core question was selected for each page
  
  itemlist <- c("C701_01", "C703_01", "C704_01", "C738_01", "C706_01", "C712_01",
                "C707_03", "C719", "C709_01", "C729_01", "E707_01",
                "E729", "E708", "E707")
  
  ds_clean$item_na_count <- apply(is.na(ds_clean[colnames(ds_clean) %in% itemlist]), 1, sum)
  #ds_clean$long <- NA
  ds_clean$items <- length(itemlist)
  ds_clean$perc_na <- ds_clean$item_na_count / ds_clean$items
  ds_clean <- ds_clean[ds_clean$perc_na<0.5,]
  
  
  ##Time spent
  
  #Rule: if spent less than 6 minutes, interview is excluded
  
  ds_clean <- ds_clean[!(ds_clean$TIME_SUM<360),]
  
  ## Age
  
  #Rule: over 98 is excluded (99 is a common value)
  
  ds_clean <- ds_clean[!(ds_clean$B703_01>98),]
  
  #email duplicates - CURRENTLY THIS SECTION IS SWITCHED OFF
  
  #email_d <- duplicated(ds_clean["SERIAL"])
  #email_none <- is.na(ds_clean$SERIAL)
  
  #ds_clean$email_d <- (email_none=="FALSE"& email_d=="TRUE")
  
  #ds_clean$clean <- TRUE

return(ds_clean)



}



