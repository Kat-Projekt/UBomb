# The UBombaMaradona Projekt

Let's leave Carlo's birthday with all the fingers attacked

## common.h

The common.h contains the implmentation for the timing function and the state stucture. Also every variable that neads to be modified ( use #define )

## master.c

This is the file run in the main board ( the one with the clock ) it is resoponsible for:

- Checking for the initial board state and sending it to the other modules
- Checking for winning or loosing conditions 

## slave.h

This file contains the setup information for every slave node and also the functions to call when an event appens like solving or making an error

## module_test.h

This file is the template for making the modules.
If a module is solved incorrectly it cannot be solved again.
 