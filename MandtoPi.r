MAXPASSES<-8

# /*
# For those hard core experimenters who want to try multi-week runs, I've
# made  counter  into  a long double instead of a mere long.  This will allow
# maximum  counts of somewhere around 16 billion billion instead of only four
# billion.   (Half  of  you  will probably complain that a long double can go
# much  higher  than  that  -  but  it  can't if you still want to be able to
# accurately  add  one  to  it).   However, after that many iterations, it is
# unlikely  that  enough  accuracy  will  be left to continue giving you more
# digits of PI.  That's chaos for you.
#             */


#   int main(int argc, char *argv[])
# {
#   register long double	zr, zi, cr, ci;
#   register long double	rsquared, isquared;
#   register long double	counter;
#   long double starti;
#   register short	abortcounter;
#   short	pass;
#   unsigned short	breakable;

print("MandToPi: Copyright ? 1993 Cygnus Software.")
print("Calculating PI based on escape times from the `neck' at (-0.75, 0.0) of")
print("the Mandelbrot set.")
print("Type Ctrl-C to stop.")
# /* The initial value for starti and the amount to reduce it by are quite */
# /* arbitrary.  You could just as easily start at 0.683 and multiply by */
# /* 0.5 each time instead.  PI is unavoidable. */

#for (starti = 1.0, pass = 0;  pass < MAXPASSES && (breakable || pass < 5);  starti *= 0.1, pass++){

#This method does not take advantage of R's understanding of complex numbers
starti <- 10
for (pass in 1:MAXPASSES)
{
  print(paste('Pass',pass))
  zr <-  0.0
  zi <-  0.0
  cr <- -0.75
  ci <-  starti
  rsquared <- zr^2
  isquared <- zr^2
  
  #/* The guts of the program - standard Mandelbrot iteration formula. */
  #    for (counter = 0; rsquared + isquared <= 4.0; counter++)
  counter = 0
  while (rsquared + isquared <=4.0)
  {
    zi <- zr * zi * 2
    zi <- zi + ci
    
    zr <- rsquared - isquared;
    zr <- zr +  cr
    
    rsquared <- zr^2
    isquared <-  zi^2
    counter = counter + 1
  }
  starti<-starti*0.1
}

print(sprintf("E is %f, num iterations is %f, PI is ~%f", starti, counter, 10* starti * counter))

#This method does take advantage of R's understanding of complex numbers
starti <- 10
for (pass in 1:MAXPASSES)
{
  print(paste('Pass',pass))
  z <-  complex(real=0.0,imaginary = 0.0)
  c <- complex(real = -0.75,imaginary = starti)

  #/* The guts of the program - standard Mandelbrot iteration formula. */
  #    for (counter = 0; rsquared + isquared <= 4.0; counter++)
  counter = 0
  while (Re(z) + Im(z) <=4.0)
  {
    z <- z^2+c
    counter = counter + 1
  }
  starti<-starti*0.1
}  

# /* To make the results look pretty, be sure to put .N, where is N is MAXPASSES or # # greater after each percent sign in the following printf control string.  Otherwise # you may get misaligned printouts or, worse, missing digits. */

print(sprintf("E is %f, num iterations is %f, PI is ~%f", starti, counter, 10* starti * counter))

print("Done")
