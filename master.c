#include "common.h"

int Modules_Solved = 0;
int Strikes = 0;
int EoG = 0;

long StartTime = 0;
long PenaltyTime = 0;

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
 //activate bomb
 //close
}

void solved ( )
{
 //do something with the timer
 //close
}

void correct ( )
{
	Modules_Solved ++;
}

void error ( )
{
	Strikes ++;
	PenaltyTime += PENALTY_TIME;
	
}

void end_of_game ( )
{
	if(EoG == 1){
		solved();
	}else if(EoG == -1){
		detonate();
	}else{
		//fuck
	}

}

void check_wires ( )
{
	if(ClockPin == HIGH && DataPin == LOW){
		error();
	}

	if(ClockPin == LOW && DataPin == HIGH){
		correct();
	}

	if(ClockPin == HIGH && DataPin == HIGH){

		end_of_game();
	}
}

void setup ( )
{
	auto State = get ( );
	// trasmit over the ClockPin e DataPin following I2C standard
	// the Board State
	
	// set up for the timing function and display
	display_time ( MAX_TIME ); 

	//wait for signal to start
	StartTime = mill();
}

void loop ( ) 
{
	
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


	check_wires();

	if ( timeleft() == 0 || Strikes >= MAX_STRIKES )
	{
		// send the End the Game state
		EoG = -1;
		ClockPin = HIGH;
		DataPin = HIGH;
		// exit the program 
	}

	if ( Modules_Solved >= TOTAL_MODULES )
	{
		// send the End the Game state
		EoG = 1;
		ClockPin = HIGH;
		DataPin = HIGH;
		// exit the program
	}

	// displays time left
	display_time ( timeleft (StartTime, PenaltyTime) ); 
}