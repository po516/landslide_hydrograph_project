# landslide_hydrograph_project
Code and videos to share from my 3rd year independent progect

Gifs show the model run for each of the three open boundary condition types

buffer1 shows the model result for the Buffer zone method, with the discharge lasting 15 seconds of model time
gmany2 shows the Variable spacing method, with discharge for 10 seconds of model time
gone2.1 shows the Single ghost particle method, with discharge for 10 seconds of model time


Both codes are currently set up to run an animation that plots as the code runs. This also shows you the model time as the animation goes along.

base2 can be used to model the variable spacing and single ghost particle methods
Change input method: line 62
Change discharge time: line 9
Change model run time: line 47

base3 can be used to run the model with the buffer zone input method
Change discharge time: line 7
Change model run time: line 48
