#  the explainatary variables
Xs_PL <-read.table("Rdata/Xs_PL.csv", sep = ",") # site and time, plant scale
Xs_ST <-read.table("Rdata/Xs_ST.csv", sep = ",") # site and time, 
Xe_PL <-read.table("Rdata/Xe_PL.csv", sep = ",") # environmental variables, plant scale
Xe_ST <-read.table("Rdata/Xe_ST.csv", sep = ",") # (mean) environmental variables, at site scale
# the response variables
Yt_PL <-read.table("Rdata/Yt_PL.csv", sep = ",") # taxon composition, plant scale
Yt_ST <-read.table("Rdata/Yt_ST.csv", sep = ",") #                  , site scale
Yg_PL <-read.table("Rdata/Yg_PL.csv", sep = ",") # guild 
Yg_ST <-read.table("Rdata/Yg_ST.csv", sep = ",")

## write column names
colnames(Xs_PL) <- c( "Latitude", "Month")
colnames(Xs_ST) <- c( "Latitude", "Month")