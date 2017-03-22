library('venneuler')

varpartplot <- function(mod){
  Xs <- varpartprep(mod, 10)
 
  MyVenn <- venneuler(c(A=Xs[1],B=Xs[2],C=Xs[3],
                       # D = Xs[8], #residual
                        "A&B"=Xs[4], "A&C"=Xs[5],"B&C"=Xs[6],   
                        #"A&D"= 0,"B&D"=0,"C&D"= 0,
                        "A&B&C"=Xs[7])
                       #  "A&B&C&D"= 0)
  )
  ##
  
  
  MyVenn$labels <- c("Plant","Month","Latitude")
  #  plot(MyVenn)
  
  return(MyVenn)
}

varpartprep <- function(mod, digit = 3){
  a <-  mod$part$indfract$Adj.R.square
  
  #  showvarparts(3)
  
  X1 <- a[1] + a[4] + a[6] + a[7] # a + d + f + g
  X2 <- a[2] + a[4] + a[5] + a[7] # b + d + e + g
  X3 <- a[3] + a[5] + a[6] + a[7] # c + e + f + g
  X1X2 <- a[4] + a[7] # d + g
  X1X3 <- a[6] + a[7] # f + g
  X2X3 <- a[5] + a[7] # e + g
  X1X2X3 <- a[7]
  resX <- a[8]
  
  Xs <- c(X1, X2, X3, X1X2 , X2X3, X1X3, X1X2X3, resX)
  ###
  # Xs <- sapply(Xs, round, digit)
  Xs[Xs < 0] <- 0 # negative value not shown; it's possible
  
  return(Xs)
}