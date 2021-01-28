#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

get_corners <- function(N_corners){
    #divide a unit circle into N_corners points
    inner_angle <- 2*pi/N_corners
    theta <- seq(from = 0, to = 2*pi, by = inner_angle)
    theta <- head(theta,-1) #drop the overlapping 0
    #rotate theta by half an angle
    if (N_corners%%2 > 0){   #odd 
        theta <- theta + pi/2#0.75*inner_angle
    }else{
        theta <- theta + pi/N_corners
    }
    corners <- matrix(0,length(theta),2)
    x_corner <- cos(theta)
    y_corner <- sin(theta)
    corners[,1] <- x_corner
    corners[,2] <- y_corner
    return(corners)
}


gasket_xy_pts <- function(corners,N_points, step_factor){
    #generate the gasket x y coordinates
    x_corner <- corners[,1]
    y_corner <- corners[,2]
    N_corners <- length(x_corner)
    rolls <- sample(1:N_corners,N_points, replace = TRUE)  #generate the rolls in one call
    xy_pts <- matrix(0,N_points+1,2) #initiate array
    cnt <- 1
    xy_pts[cnt,1] <- runif(1,-1,1)#pick a random starting point 
    xy_pts[cnt,2] <- runif(1,-1,1)
    for (r in rolls){
        cnt <- cnt + 1
        xy_pts[cnt,1] <-  xy_pts[cnt-1,1] + step_factor*(x_corner[r] - xy_pts[cnt-1,1])
        xy_pts[cnt,2] <-  xy_pts[cnt-1,2] + step_factor*(y_corner[r] - xy_pts[cnt-1,2])
    }
    return(xy_pts)
}


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$gasketPlot <- renderPlot({
        
        corners <- get_corners(as.numeric(input$n_corners))
        step_size <- as.numeric(input$step_adjust)
        n_points <- as.numeric(input$number_of_points)
        xy_pts <- gasket_xy_pts(corners,n_points,step_size)
        
        par(pty="s",mar = c(2,2,2,2))
        plot(xy_pts[,1],xy_pts[,2],pch = '.')
        points(corners,pch = 'o',col = 'blue') 
        points(xy_pts[1,1],xy_pts[1,2],pch = 'x',col = 'red') 
        
    })

})
