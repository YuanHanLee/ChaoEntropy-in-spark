BasicInfoFun_Ind <- function(x, B) {
  n <- sum(x)
  f1 <- sum(x == 1)
  f2 <- sum(x == 2)
  D <- sum(x > 0)
  if (f2 > 0) {
    C <- 1 - f1 / n * ((n - 1) * f1 / ((n - 1) * f1 + 2 * f2))
  } else if (f2 == 0 & f1 != 0) {
    C <- 1 - f1 / n * ((n - 1) * (f1 - 1) / ((n - 1) * (f1 - 1) + 2))
  } else {
    C <- 1
  }
  i <- 1:n
  tmp1 <- sum(sapply(i, function(i) i * (i-1) * sum(x == i)))
  tmp2 <- sum(sapply(i, function(i) i * sum(x == i)))
  gamma <- max((D / C) * (tmp1 / (tmp2 * (tmp2 - 1))) - 1 , 0)
  CV <- sqrt(gamma)    #  Estimated CV
  out <- list(n=n, D=D, f1=f1, f2=f2, C=C, B=B, CV=CV)
  class(out) <- "BasicInfoFun_Ind"
  return(out)
}

print.BasicInfoFun_Ind <- function(x) {
  cat(" (Number of observed individuals)             n  = ", x$n, "\n")
  cat(" (Number of observed species)                 D  = ", x$D, "\n")
  cat(" (Number of singletons)                       f1 = ", x$f1, "\n")
  cat(" (Number of doubletons)                       f1 = ", x$f2, "\n")
  cat(" (Estimated sample coverage)                  C  = ", x$C, "\n")
  cat(" (Estimated CV)                               CV = ", x$CV, "\n")
  cat(" (Bootstrap replications for s.e. estimate)   B  = ", x$B, "\n")
}

BasicInfoFun_Sam <- function(x, B) {
  t <- x[1]
  y <- x[-1]
  D <- sum(y > 0)
  Q1 <- sum(y == 1)
  Q2 <- sum(y == 2)
  U <- sum(y)
  if (Q2 > 0) {
    C <- 1 - Q1 / U * ((t - 1) * Q1 / ((t - 1) * Q1 + 2 * Q2))
  } else if (Q2 == 0 & Q1 != 0) {
    C <- 1 - Q1 / U * ((t - 1) * (Q1 - 1) / ((t - 1) * (Q1 - 1) + 2))
  } else {
    C <- 1
  }
  out <- list(t=t, U=U, D=D, Q1=Q1, Q2=Q2, C=C, B=B)
  class(out) <- "BasicInfoFun_Sam"
  return(out)
}

print.BasicInfoFun_Sam <- function(x) {
  cat(" (Number of observed sampling units)          T  = ", x$t, "\n")
  cat(" (Number of observed species)                 D  = ", x$D, "\n")
  cat(" (Number of singletons)                       Q1 = ", x$Q1, "\n")
  cat(" (Number of doubletons)                       Q1 = ", x$Q2, "\n")
  cat(" (Estimated sample coverage)                  C  = ", x$C, "\n")
  cat(" (Bootstrap replications for s.e. estimate)   B  = ", x$B, "\n")
}

saveList2csv <- function(out, file) {
  for (i in seq_along(out)){
    write.table(names(out)[i], file=file, sep=",", dec=".", 
                quote=FALSE, col.names=FALSE, row.names=FALSE, append=TRUE)  #writes the name of the list elements
    write.table(out[[i]], file=file, sep=",", dec=".", quote=FALSE, 
                col.names=NA, row.names=TRUE, append=TRUE)  #writes the data.frames
  }
}
