##################################
# Created by EPI-interactive
# 30 Apr 2019
# https://www.epi-interactive.com
##################################

library(shiny)
library(DT)
library(dplyr)

shinyApp(
  ui = fluidPage(
    div(
      dataTableOutput("tableUI")
    )
  ),
  
  server = function(input, output, session) {
    output$tableUI = renderDataTable({
      dat <- iris %>% mutate(More = paste0('<span><a href="javascript:void(0)" onmousedown="',
                                          'Shiny.onInputChange(\'DTClick\',[', 1:n(), ',Math.random()]);',
                                          'event.preventDefault(); event.stopPropagation(); return false;"><font color="grey">&#9679;&#9679;&#9679;</font></a></span>'))
      
      datatable(dat,
                escape = FALSE)
    })
    
    output$modalContent <- renderDataTable({
      dat <- iris[as.numeric(input$DTClick[1]),]
      datatable(dat,
                rownames = FALSE,
                options = list("lengthChange" = FALSE,
                               "searching" = FALSE,
                               "paging" = FALSE,
                               "info" = FALSE,
                               "ordering" = FALSE))
    })
      
    observeEvent(input$DTClick, {
      showModal(modalDialog(
        title = paste0("You just clicked row ", as.numeric(input$DTClick[1])),
        dataTableOutput("modalContent"),
        size = "l",
        easyClose = TRUE,
        footer = NULL
      ))
    })
  }
)
