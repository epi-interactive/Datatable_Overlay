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
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
    ),
    fluidRow(class="header-row",
      h1("Datatable overlay"),
      tags$img(src="images/Epi_Logo.png", width= "200px", height = "30px")
    ),
    div(class="main",
      dataTableOutput("tableUI")
    )
  ),
  
  server = function(input, output, session) {
    names(iris) <- c("Speal length", "Sepal width", "Petal length", "Petal width", "Species")
    output$tableUI = renderDataTable({
      dat <- iris %>% mutate(More = paste0('<span><a href="javascript:void(0)" onmousedown="',
                                          'Shiny.onInputChange(\'DTClick\',[', 1:n(), ',Math.random()]);',
                                          'event.preventDefault(); event.stopPropagation(); return false;"><font color="grey"><b>...</b></font></a></span>'))
      
      datatable(dat,
                rownames = FALSE,
                selection ="none",
                escape = FALSE)
    })
    
    output$modalContent <- renderDataTable({
      dat <- iris[as.numeric(input$DTClick[1]),]
      datatable(dat,
                rownames = FALSE,
                selection ="none",
                options = list("lengthChange" = FALSE,
                               "searching" = FALSE,
                               "paging" = FALSE,
                               "info" = FALSE,
                               "ordering" = FALSE))
    })
      
    observeEvent(input$DTClick, {
      showModal(modalDialog(
        title = paste0("Row ", as.numeric(input$DTClick[1])),
        dataTableOutput("modalContent"),
        size = "l",
        easyClose = TRUE,
        footer = NULL
      ))
    })
  }
)
