# Patitioning of variation

rm(list = ls()) # clean work space
                # use ``Ctrl + L` to clean console 

##
Xs_PL <-read.table("Rdata/Xs_PL.csv", sep = ",")
Xs_ST <-read.table("Rdata/Xs_ST.csv", sep = ",")
Xe_PL <-read.table("Rdata/Xe_PL.csv", sep = ",")
Xe_ST <-read.table("Rdata/Xe_ST.csv", sep = ",")

Yt_PL <-read.table("Rdata/Yt_PL.csv", sep = ",")
Yt_ST <-read.table("Rdata/Yt_ST.csv", sep = ",")
Yg_PL <-read.table("Rdata/Yg_PL.csv", sep = ",")
Yg_ST <-read.table("Rdata/Yg_ST.csv", sep = ",")



# "burlywood"

# Three explaining matrices

mod_tPL <- varpart(Yt_PL, ~ ., Xs_PL[,1], Xs_PL[,2] , data=Xe_PL, transfo="log")
    dev.copy(png,'plot_parvar1.png')
    plot(mod_tPL, bg = c("hotpink","skyblue", "burlywood"),Xnames=c('S', 'T','E'))
    title(main= 'Taxon-based, plant scale' ,sub = 'Partitioning of Variation')
    dev.off() 
  #  rda.result <- rda(decostand(Yt_PL, "log"), Xs_PL[,1], Xs_PL[,2] , data=Xe_PL)
  #  anova(rda.result, step=200, perm.max=200)

mod_gPL <- varpart(Yg_PL, ~ ., Xs_PL[,1], Xs_PL[,2] , data=Xe_PL, transfo="log")
    dev.copy(png,'plot_parvar2.png')
    plot(mod_gPL, bg = c("hotpink","skyblue", "burlywood"),Xnames=c('S', 'T','E'))
    title(main= 'Guild-based, plant scale' ,sub = 'Partitioning of Variation')
    dev.off() 
    
mod_tST <- varpart(Yt_ST, ~ ., Xs_ST[,1], Xs_ST[,2] , data=Xe_ST, transfo="log")
    dev.copy(png,'plot_parvar3.png')
    plot(mod_tST, bg = c("hotpink","skyblue", "burlywood"), Xnames=c('S', 'T','E'))
    title(main= 'Taxon-based, site scale' ,sub = 'Partitioning of Variation')
    dev.off() 
    
mod_gST <- varpart(Yg_ST, ~ ., Xs_ST[,1], Xs_ST[,2] , data=Xe_ST, transfo="log")
    dev.copy(png,'plot_parvar4.png')
    plot(mod_gST, bg = c("hotpink","skyblue", "burlywood"), Xnames=c('S', 'T','E'))
    title(main= 'Guild-based, site scale' ,sub = 'Partitioning of Variation')
    dev.off() 
    
# auto correlation: it doesn't work this way
    mod_gPL <- varpart(Yg_PL, ~ ., Xs_PL , data=Xe_PL,decostand(Yg_PL, "log"), transfo="log")
    plot(mod_gPL, bg = c("hotpink", "burlywood", "azure3"),Xnames=c('ST','E', 'A'))
    
  
    
    
    