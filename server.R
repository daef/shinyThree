library(shiny)

renderDummy <- function(expr, env=parent.frame(), quoted=FALSE) {
  func <- exprToFunction(expr, env, quoted)
  function() {
    func()
  }
}

shinyServer(function(input, output) {
  files <- list.files("meshes")

  data <- reactive({
    file <- paste0("meshes/",files[input$n])
    len <- file.info(file)$size
    base64enc::base64encode(readBin(file, what="raw", n=len));
  })

  output$mesh <- renderDummy({
    data()
  })
})

