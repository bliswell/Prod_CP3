SG2

========================================================
author: Brian Liswell
date: January 28 2021
autosize: true
This app will make a plot of Sierpinski fractals using the "rolling dice" technique.  The user selects the number of corners (3 to n), the number of dice rolls.

To learn more about Sierpinski figures, see [Wikipedia](https://en.wikipedia.org/wiki/Sierpi%C5%84ski_triangle).
For an example on how to generate them with a dice see [this Medium article](https://medium.com/however-mathematics/the-geometric-chaos-sierpinski-triangle-12b308d732fb)


Controls:
========================================================
autosize: true

- Set the number of corners (3 is most common)
- Chose the step size each point to the next
    - Choose greather than 0.5 for squares
    - Choosing greather than 1 creates crazy patterns
    
- Choose the number of points, bearing in mind rendering time

Establish the Corners
========================================================


```r
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
```

Make Steps
========================================================


```r
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
```

Here it is
========================================================



```
Error in parse(text = x, srcfile = src) : <text>:3:73: unexpected ','
2:   selectInput("n_corners", label = "Number of cornerss:",
3:               choices = c(seq(from = 3, to = 10, by = 1)), selected = 3),
                                                                           ^
```
