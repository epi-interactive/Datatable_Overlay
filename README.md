# Datatable Overlay
Sometimes there are too many rows in a data table to display on one page and scrolling is not the most user-friendly way to solve this. This examples provides a way to layer information into a overlay which can be accessed by clicking a link in a data table. 

You can try out the app [here](https://rshiny2.epi-interactive.com/apps/datatable_overlay/)

![alt text](modal-thumbnail.PNG)

## How it works
Add an an extra column for the data in your table and attach a Shiny event listener to it to return its index

``` r
dat <- iris %>% mutate(More = paste0('<span><a href="javascript:void(0)" onmousedown="',
                                    'Shiny.onInputChange(\'DTClick\',[', 1:n(), ',Math.random()]);',
                                    'event.preventDefault(); event.stopPropagation(); return false;">
                                    <font color="grey">&#9679;&#9679;&#9679;</font>
                                    </a></span>')
                                    )
                      )

```

Listen for the click and show the overlay
``` r
observeEvent(input$DTClick, {
      showModal(modalDialog(
        title = paste0("You just clicked row ", as.numeric(input$DTClick[1])),
        dataTableOutput("modalContent"),
        size = "l",
        easyClose = TRUE,
        footer = NULL
      ))
    })
```




---

Code created by [Epi-interactive](https://www.epi-interactive.com) 

As always, our expert team is here to help if you want custom training, would like to take your dashboards to the next level or just need an urgent fix to keep things running. Just get in touch for a chat.

[https://www.epi-interactive.com/contact](https://www.epi-interactive.com/contact)
