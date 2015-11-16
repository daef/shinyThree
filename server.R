library(shiny)

renderDummy <- function(expr, env=parent.frame(), quoted=FALSE) {
  func <- exprToFunction(expr, env, quoted)
  function() {
    func()
  }
}

shinyServer(function(input, output, session) {
  files <- list.files("meshes")

  observe({
    file <- paste0("meshes/",files[input$n])
    len <- file.info(file)$size
    session$sendBinaryMessage(readBin(file, what="raw", n=len))
  })
})

