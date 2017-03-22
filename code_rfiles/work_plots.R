

source("varpartplot.R")
## [ref.](https://andrewpwheeler.wordpress.com/2015/07/21/venn-diagrams-in-r-with-some-discussion/)
###
p_tST <- varpartplot(mod_tST)
p_gST <- varpartplot(mod_gST)
p_tPL <- varpartplot(mod_tPL)
p_gPL <- varpartplot(mod_gPL)

#par(mfrow = c(1, 2))
par(mar = c(1, 1, 1, 2) )
par(fig = c(0,0.5, 0.2, 0.9), new = T)
plot(p_tST)
  title(main= 'Taxon-based, site scale')
  a <- mod_tST$part$indfract$Adj.R.square
  text(p_tST$centers[1,1], p_tST$centers[1,2]+0.1, 
       paste(as.character(round(a[1]*100,2 )), '%'))
  text(p_tST$centers[2,1], p_tST$centers[2,2]- 0.1, 
       paste(as.character(round(a[2]*100,2 )), '%'))
  text(p_tST$centers[3,1], p_tST$centers[3,2]+ 0.1, 
       paste(as.character(round(a[3]*100,2 )), '%'))
par(fig = c(0.5, 1, 0.2, 0.9), new = T)
plot(p_gST)
  title(main= 'Guild-based, site scale')
  a <- mod_gST$part$indfract$Adj.R.square
  text(p_gST$centers[1,1], p_gST$centers[1,2]+0.1, 
       paste(as.character(round(a[1]*100,2 )), '%'))
  text(p_gST$centers[2,1], p_gST$centers[2,2]- 0.1, 
       paste(as.character(round(a[2]*100,2 )), '%'))
  text(p_gST$centers[3,1], p_gST$centers[3,2]+ 0.05, 
       paste(as.character(round(a[3]*100,2 )), '%'))
par(fig = c(0,0.5, 0.05, 0.2), new = T)
  res <- mod_tST$part$indfract$Adj.R.square[8]
  barplot(res, 
          main = paste('residual (',as.character(round(res*100,1)), '% )'),
          horiz=TRUE, xlim = c(0,1))
par(fig = c(0.5,1, 0.05, 0.2), new = T)
    res <- mod_gST$part$indfract$Adj.R.square[8]
  barplot(res, 
          main = paste('residual (',as.character(round(res*100,1)), '% )'),
          horiz=TRUE, xlim = c(0,1))
 #######
  
  par(mar = c(1, 1, 1, 2) )
par(mfrow = c(1, 2))
  par(fig = c(0.05,0.45, 0.25, 0.9), new = T)
plot(p_tPL)
  title(main= 'Taxon-based, plant scale')
  a <- mod_tPL$part$indfract$Adj.R.square
  text(p_tPL$centers[1,1], p_tPL$centers[1,2]+0.1, 
       paste(as.character(round(a[1]*100,2 )), '%'))
  text(p_tPL$centers[2,1], p_tPL$centers[2,2]- 0.1, 
       paste(as.character(round(a[2]*100,2 )), '%'))
  text(p_tPL$centers[3,1], p_tPL$centers[3,2]+ 0.1, 
       paste(as.character(round(a[3]*100,2 )), '%'))
par(fig = c(0.55, 0.95, 0.25, 0.9), new = T)
plot(p_gPL)
  title(main= 'Guild-based, plant scale')
  a <- mod_gPL$part$indfract$Adj.R.square
  text(p_gPL$centers[1,1], p_gPL$centers[1,2]+0.1, 
       paste(as.character(round(a[1]*100,2 )), '%'))
  text(p_gPL$centers[2,1], p_gPL$centers[2,2]- 0.1, 
       paste(as.character(round(a[2]*100,2 )), '%'))
  text(p_gPL$centers[3,1], p_gPL$centers[3,2]+ 0.1, 
       paste(as.character(round(a[3]*100,2 )), '%'))
par(fig = c(0,0.5, 0.05, 0.2), new = T)
  res <- mod_tPL$part$indfract$Adj.R.square[8]
  barplot(res, 
          main = paste('residual (',as.character(round(res*100,1)), '% )'),
          horiz=TRUE, xlim = c(0,1))
par(fig = c(0.5,1, 0.05, 0.2), new = T)
  res <- mod_gPL$part$indfract$Adj.R.square[8]
  barplot(res, 
          main = paste('residual (',as.character(round(res*100,1)), '% )'),
          horiz=TRUE, xlim = c(0,1))



  
  
  
A0 <- p_tST$centers[1,]
B0 <- p_tST$centers[4,]
angle0 <-atan2(A0[2],A0[1]) - atan2(B0[2],B0[1]) 

A <- p_gST$centers[1,]
B <- p_gST$centers[4,]
angle <-atan2(A[2],A[1]) - atan2(B[2],B[1]) - angle0

 M <- matrix( c(cos(angle), -sin(angle), sin(angle), cos(angle)), 2, 2 )
 p_gST$centers <- p_gST$centers %*% M
  plot(p_gST)
# theta <- acos( sum(a*b) / ( sqrt(sum(a * a)) * sqrt(sum(b * b)) ) )