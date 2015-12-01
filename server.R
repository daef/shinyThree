library(shiny)

shinyServer(function(input, output, session) {
  files <- list.files("meshes")

  observe({
    file <- paste0("meshes/",files[input$n])
    len <- file.info(file)$size
    session$sendBinaryMessage("foo", readBin(file, what="raw", n=len))
  })
})

