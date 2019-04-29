library(shiny)
library(DT)
library(dplyr)
library(shinyBS)


shinyApp(
  ui = fluidPage(
    div(
      uiOutput("modalDTDialog"),
      DT::dataTableOutput("tableUI"))),
  
  
  server = function(input, output, session) {
    dat <- iris
    dat <- dat %>% mutate(GID = 1:nrow(dat))
    
    dat <- dat %>% mutate(More = paste0('<span style="float:right;"><a href="javascript:void(0)" onmousedown="',
                                               'Shiny.onInputChange(\'DTClick\',[', GID, ',Math.random()]);',
                                               ' event.preventDefault(); event.stopPropagation(); return false;"><font color="grey">&#9679;&#9679;&#9679;&nbsp;&nbsp;</font></a></span>'))
    
    output$modalDTDialog <- renderUI({
      bsModal("DTDialog", "Test Title", "", size="small",
              div(HTML(paste0("You just click row ", as.numeric(input$DTClick[1]))),
                  uiOutput("modalContent")))
    })
    
    output$tableUI = DT::renderDataTable(
      datatable(dat,
                escape = FALSE)
    )
    
    output$modalContent <- renderUI({
      div("Just a test")
    })
      
    observeEvent(input$DTClick, {
      showModal(modalDialog(
        title = "Somewhat important message",
        div(HTML(paste0("You just click row ", as.numeric(input$DTClick[1]))),
            uiOutput("modalContent")),
        easyClose = TRUE,
        footer = NULL
      ))
    })
  }
)