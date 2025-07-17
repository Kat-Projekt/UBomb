#include "common.h"

BoardState get ( )
{
	// check the pins for the diffent states and set them
	// for lit generet a casual one from the appendix A and display it
}

void display_time ( int time )
{
	// do the time display here
}

void detonate ( )
{

}

void solved ( )
{

}

void setup ( )
{
	auto State = get ( );
	// trasmit over the ClockPin e DataPin following I2C standard
	// the Board State
	
	// set up for the timing function and display
	display_time ( timeleft ( ) ); 
}

void loop ( ) 
{
	static int Tries = TOTAL_TRIES;
	static int Modules_Solved = TOTAL_MODULES - 1;
	// listen for:
	// ClockPin | DataPin | Outcome
	// ---------|---------|--------
	//     0    |    0    | Notting
	//     1    |    0    | Error
	//     0    |    1    | Correct
	//     1    |    1    | End the Game
	// the End the Game state is set by this process
	// update Tries accordingly
	// decrement Modules Solved accordingly
	
	if ( !timeleft ( ) || Tries <= 0 )
	{
		// send the End the Game state
		detonate ( );
		// exit the program 
	}

	if ( !Modules_Solved )
	{
		// send the End the Game state
		solved ( );
		// exit the program
	}

	// displays time left
	display_time ( timeleft ( ) ); 
}