  setwd("C:/Users/esa/OneDrive - Eurofound/LWEU survey/Round 7 2024/R scripts")
  
  library(dplyr)
  library(weights)
  library(questionr)
  library(tidyr)
  library(naniar)
  library(rlist)
  library(foreign)
  library(haven)
  library(labelled)
  
  
  
  # -------- Import file from API --------
  
  source("import_lweu_2024-05-12_22-03.R", local=TRUE)
  
  save (ds, file="data/ds_raw.Rda")
  

  # -------- Cleaning -------------------- 
  
  source("cleaning_2024.R", local=TRUE)
  
  ds_clean <- cleaning_2024(ds)
  
  save(ds_clean, file="data/ds_clean.Rda")
  
  # -------- Recoding  -------------------
  
  #call recoding script once ready
  
  
  # -------- Weighting ------------------
  
  
  #call weighting script once ready
  
  
  # -------- Labelling ------------------
  
  #call labelling script once ready
  
  
  #--------- Public ---------------
  
  #create and save public file (without panel info)
  #<3 <3
  
