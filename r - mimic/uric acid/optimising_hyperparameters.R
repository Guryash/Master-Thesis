#optimising hyperparameters, alpha, timescale, variance
calcSigma <- function(X1,X2,l) {
  Sigma <- matrix(rep(0, length(X1)*length(X2)), nrow=length(X1))
  for (i in 1:nrow(Sigma)) {
    for (j in 1:ncol(Sigma)) {
      Sigma[i,j] <- exp(-0.5*(abs(X1[i]-X2[j])/l)^2)
    }
  }
  return(Sigma)
}

#1. optimising for a sequence with calSigma function
exampledata <- subset(exampleAddColumn, exampleAddColumn$SUBJECT_ID==23024)
uric123 <- data.matrix(exampledata$VALUENUM)
dim(uric123)
timeframedata <- exampledata$TIMEFRAME
hyper <- seq(-1000,-100,0,0.01)
func <- -1
rows <- nrow(uric123)
term <- ((rows/2)*log(2*pi))
for(val in hyper)
{
  co <- calcSigma(timeframedata,timeframedata,val)
  if(is.nan(log(det(co))))
  {
    cat("nan")
  }
  else if (log(det(co)) == -Inf)
  {
    cat("inf")
  }
  else
  {
    newfunc <- -0.5*t(uric123)%*%co%*%uric123 - 0.5*(log(det(co))) - term
    if(newfunc > func)
    {
      func <- newfunc
      newval <- val
    }
  }
}

#results: no optimization, newfunc is less than -1 for values between -1000 to 1000

#2. optimising for a sequence with just changing timescale and alpha value
exampledata <- subset(exampleAddColumn, exampleAddColumn$SUBJECT_ID==23024)
uric123 <- data.matrix(exampledata$VALUENUM)
timeframedata <- exampledata$TIMEFRAME
hypertimescale <- seq(-50,50,0.01)
hyperalpha <- seq(0.01,50,0.01)
#func <- -1
rows <- nrow(uric123)
for(val in hypertimescale)
{
  for(val2 in hyperalpha)
  {
    co <- covarianceFunction(timeframedata,timeframedata,0.3,val,val2)
    if(is.nan(log(det(co))))
    {
      next
    }
    else if (log(det(co)) == -Inf)
    {
      next
    }
    else
    {
      newfunc <- -0.5*t(uric123)%*%co%*%uric123 - 0.5*(log(det(co))) - term
      if(newfunc > func)
      {
        func <- newfunc
        newtimescale <- val
        newalpha <- val2
      }
    }
  }
}

#results: alpha = 24, timescale = -40.96

hypervariance <- seq(-50,50,0.01)
for(val in hypervariance)
{
  co <- covarianceFunction(timeframedata,timeframedata,val)
  if(is.nan(log(det(co))))
  {
    cat("nan")
  }
  else if (log(det(co)) == -Inf)
  {
    cat("inf")
  }
  else
  {
    newfunc <- -0.5*t(uric123)%*%co%*%uric123 - 0.5*(log(det(co))) - term
    if(newfunc > func)
    {
      func <- newfunc
      newvariance <- val
    }
  }
}

#results: variance = -49.97 #not usable .. 

#3. optimising for a sequence
exampledata <- subset(exampleAddColumn, exampleAddColumn$SUBJECT_ID==23024)
uric123 <- data.matrix(exampledata$VALUENUM)
timeframedata <- exampledata$TIMEFRAME
hypertimescale <- seq(0.01,100,0.01)
hyperalpha <- seq(0.01,25,0.01)
hypervariance <- seq(0.01,25,0.01)
func <- -1
rows <- nrow(uric123)
term <- ((rows/2)*log(2*pi))
for(val in hypertimescale)
{
    for(val3 in hypervariance)
    {
      co <- covarianceFunction(timeframedata,timeframedata,0.01,88.61,88.61)
      if(is.nan(log(det(co))))
      {
        next
      }
      else if (log(det(co)) == -Inf)
      {
        next
      }
      else
      {
        newfunc <- -0.5*t(uric123)%*%co%*%uric123 - 0.5*(log(det(co))) - term
        if(newfunc > func)
        {
          func <- newfunc
          newtimescale <- val
          newalpha <- val
          newvariance <- val3
        }
      }
    }
}

#4. optimising for the whole dataset -- taking too much time..
uricvalue123 <- data.matrix(exampleAddColumn$VALUENUM[1])
timeframedata <- exampleAddColumn$TIMEFRAME[1] 
hyperalpha <- seq(0.01,10,0.0001)
hypertimescale <- seq(-3,3,0.0001)
hypervariance <- seq(-3,3,0.0001)
func <- -1
rows <- nrow(uricvalue123)
term <- ((rows/2)*log(2*pi))
for(val in hyperalpha)
{
  alpha <- 0.01 #val
  for(val1 in hypervariance)
  {
    variance <- 0.0001#val1
    for(val2 in hypertimescale)
    {
      timescale <- -3#val2
      co <- covarianceFunction(timeframedata,timeframedata,variance,timescale,alpha)
      if(is.nan(log(det(co))))
      {
        break
      }
      else if (log(det(co)) == -Inf)
      {
        break
      }
      else
      {
        newfunc <- -0.5*t(uricvalue123)%*%co%*%uricvalue123 - 0.5*(log(det(co))) - term
        if(newfunc > func)
        {
          func <- newfunc
          newalpha <- alpha
          newtimescale <- timescale
          newvariance <- variance
        }
      }
    }
  }
}
