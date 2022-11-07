SWMM5+

This repository is the Beta release of the public domain SWMM5+ source code.

Please see the SWMM5plus_Installation_Guide.pdf for important information on compiling.

Documentation of this Beta release is being developed. 

Documentation of the Alpha release (some of which is obsolete) can be found in Technical Report https://doi.org/10.18738/T8/WQZ5EX


Quickstart:

1.- Download cmake for your system

https://cmake.org/download/

or

$ sudo apt-get install cmake

2.- Clone this github repository

$ git clone https://github.com/cesardavilah/SWMM5plus.git

3.- To configure the project for building, create a folder called 'build', navigate into it and use the command

$ cmake ..

4.- Building the project, use:

$ make

5.- The resulting binary can be found inside the /bin directory at the root of the project
