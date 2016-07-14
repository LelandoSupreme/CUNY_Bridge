#1.  Write a loop that calculates 12-factorial
x <- 1
for (i in 1:10)
{
  x = x * i
}
print(x)

#2.  Show how to create a numeric vector that contains the
#    sequence from 20 to 50 by 5
nvect <- seq(20, 50, 5)

#3.  Show how to take a trio of input numbers and implement
#    the quadratic equation.
solve.quadratic.formula <- function(a, b, c)
{
  x <- c(NA, NA) #Creating placeholder for vector elements
  x[1] <- ((-1 * b) + (b^2 - 4 * a * c)^0.5) / (2 * a)
  x[2] <- ((-1 * b) - (b^2 - 4 * a * c)^0.5) / (2 * a)
  y <- mean(is.nan(x))
  if (y == 1)
  {
    print("No Solution")
  } else 
    {
      print(x)
    }
}