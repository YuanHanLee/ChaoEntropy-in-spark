require(shiny)
require(ChaoEntropyOnline)

data(Ant)
data(Spider)
data(Birds)
data(Seedlings)

source("sub.R")

shinyServer(function(input, output) {
  tempRD2 <- paste(tempfile(), ".RData", sep="")
  
  loadPaste <- reactive({
    if (input$datatype == "abu") {
      text <- input$copyAndPaste_abu
    } else {
      text <- input$copyAndPaste_inc
    }
    
    ##  把文字檔轉成數個vector而成的list
    Fun <- function(e){
      temp <- lapply(readLines(textConnection(text)), function(x) scan(text = x, what='char'))
      out <- list()
      out.name <- 0
      for(i in seq_along(temp)){
        out.name[i] <- temp[[i]][1]
        out[[i]] <- as.numeric(temp[[i]][-1])
      }
      names(out) <- t(data.frame(out.name))
      out
    }
    tryCatch(Fun(e), error=function(e){return()})
  })
  
  #Get Input data name list
  getDataName <- reactive({
    Fun <- function(e){
      out <- loadPaste()
      out.name <- names(out)
      if(is.na(names(out)[1]) == TRUE) {
        dat <- paste("No data")
        dat
      } else {
        dat <- out
        ##  把list裡面的vector取出來!
        for(i in seq_along(out)){
          dat[[i]] <- out.name[i]
        }
        dat        
      }    
    }
    tryCatch(Fun(e), error=function(e){return()})
  })
  
  selectedData <- reactive({
    out <- loadPaste()
    selected <- 1
    dataset <- list()
    for(i in seq_along(input$dataset)){
      selected[i] <- which(names(out)==input$dataset[i])
    }
    for(i in seq_along(selected)){
      k <- selected[i]
      dataset[[i]] <- out[[k]]
    }
    names(dataset) <- input$dataset
    return(dataset)    
  })
  
  
  #Select data
  output$choose_dataset <- renderUI({
    dat <- getDataName()
    selectInput("dataset", "Select dataset:", choices = dat, selected = dat[1], multiple = TRUE)
    
  })
    
  mymethod <- reactive({
    if (input$datatype == "abu")
      out <- input$method1
    if (input$datatype == "inc")
      out <- input$method2
    return(out)
  })
  
  output$data_summary <- renderPrint({
    dataset <-   selectedData()
    if (input$datatype == "abu")
      summ <- lapply(dataset, function(x) BasicInfoFun_Ind(x, input$nboot))
    if (input$datatype == "inc")
      summ <- lapply(dataset, function(x) BasicInfoFun_Sam(x, input$nboot))
    
    return(summ)
  })
  
  
  output$est <- renderPrint({
    dataset <-   selectedData()
    out <- lapply(dataset, function(x) {
      ChaoEntropyOnline(data=x, datatype=input$datatype, method=mymethod(),
                        nboot=input$nboot, conf=input$conf)
    })
    saveRDS(out, tempRD2) 
    return(out)
  })
  
  #Download ChaoEntropy output 
  output$dlest <- downloadHandler(
    filename = function() { paste('output_', Sys.Date(), '_[ChaoEntropy].csv', sep='') },
    content = function(file) { 
      out <- readRDS(tempRD2)
      saveList2csv(out, file)
#       write.csv(out, file)
    }
  )
})



