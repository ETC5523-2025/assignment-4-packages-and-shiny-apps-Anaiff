#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(shinytheme)

# Define UI for application that draws a histogram
ui <- fluidPage(

    theme = shinytheme(cerulean),
    # Application title
    titlePanel("Fire Weather Index"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
      sidebarPanel(
        radioButtons("period", "Select one:",
                      choices = c("1 year", "5 years")
        )),

        # Show a plot of the generated distribution
        mainPanel(
          tabsetPanel( id = "tabs",
                       tabPanel("FWI",
                                plotlyOutput("PlotFWI"),
                                textOutput("year_FWI"),
                                textOutput("fwi"),
                                textOutput("text_fwi")
                                ),
                        tabPanel("MSR",
                                 plotlyOutput("PlotMSR"),
                                 textOutput("year_MSR"),
                                 textOutput("msr"),
                                 textOutput("text_msr")
                                 )
          )

        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$PlotFWI <- renderPlotly({
        # generate bins based on input$bins from ui.R
        data  <- ausbushfire::data
        if (input$period == "5 years") {
          data <- data %>%
            mutate(period = case_when(
              year >= 1978 & year <= 1982 ~ 1980,
              year >= 1983 & year <= 1987 ~ 1985,
              year >= 1988 & year <= 1992 ~ 1990,
              year >= 1993 & year <= 1997 ~ 1995,
              year >= 1998 & year <= 2002 ~ 2000,
              year >= 2003 & year <= 2007 ~ 2005,
              year >= 2008 & year <= 2012 ~ 2010,
              year >= 2013 & year <= 2017 ~ 2015,
              year >= 2018 & year <= 2019 ~ 2018,
            )) %>%
            group_by(period) %>%
            summarise(FWI = mean(FWI, na.rm = TRUE)) %>%
            rename(year = period)
        }

        p1 <- ggplot(data, aes(x = year, y = FWI))+
          geom_line(color = "skyblue")+
          scale_x_continuous(limits = c(1978, 2020)) +
          scale_y_continuous(limits = c(20, 55)) +
          theme_bw()
        ggplotly(p1)

    })

    output$PlotMSR <- renderPlotly({
      # generate bins based on input$bins from ui.R
      data  <- ausbushfire::data
      if (input$period == "5 years") {
        data <- data %>%
          mutate(period = case_when(
            year >= 1978 & year <= 1982 ~ 1980,
            year >= 1983 & year <= 1987 ~ 1985,
            year >= 1988 & year <= 1992 ~ 1990,
            year >= 1993 & year <= 1997 ~ 1995,
            year >= 1998 & year <= 2002 ~ 2000,
            year >= 2003 & year <= 2007 ~ 2005,
            year >= 2008 & year <= 2012 ~ 2010,
            year >= 2013 & year <= 2017 ~ 2015,
            year >= 2018 & year <= 2019 ~ 2018,
          )) %>%
          group_by(period) %>%
          summarise(MSR = mean(MSR, na.rm = TRUE)) %>%
          rename(year = period)
      }

      p2 <- ggplot(data, aes(x = year, y = MSR))+
        geom_line(color = "skyblue")+
        scale_x_continuous(limits = c(1978, 2020)) +
        scale_y_continuous(limits = c(0, 20)) +
        theme_bw()
      ggplotly(p2)

    })

    output$year_FWI <- renderText({
      "Year: the year of the value"
    })
    output$year_MSR <- renderText({
      "Year: the year of the value"
    })
    output$fwi <- renderText({
      "FWI: The seasonal maximum of the 7-day moving-average maximum Fire Weather Index"
    })
    output$msr <- renderText({
      "MSR: The maximum value of the monthly severity rating during the fire season"
    })
    output$text_fwi <- renderText(
      if (input$period == "1 year") {
        "Fire Weather Index in the figure shows strong fluctuations over time, but despite this variability, a clear long-term upward trend emerges, with a notable peak around 2020. "
      } else {
        "The 5-year average Fire Weather Index drops at first, and then slowly rises, and after 2010 increases sharply to the peak."
      }
      )
    output$text_msr <- renderText({
      "MSR exhibits a similar overall trend to FWI, indicating an increased fire danger. It is important to note that the trend is not statistically significant, which means the possibility of a decrease cannot be entirely ruled out."
    }
    )
}

# Run the application
shinyApp(ui = ui, server = server)
