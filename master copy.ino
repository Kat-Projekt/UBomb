#include "common.h"
#include <TM1637.h> //https://youtu.be/6W7tycX-F1o
#define CLK 2
#define DIO 4
#define BRHT 2 //value 0-7 brightness timer
TM1637 tm(CLK,DIO);

int Modules_Solved = 0;
int Strikes = 0;

class B { };

BoardState get ( )
{
	// check the pins for the diffent states and set them
	// for lit generet a casual one from the appendix A and display it
}

void display_time ( long time )
{
	long sec = time / 1000;
	long min = sec / 60;
	sec %= 60;

	tm.display(0,min/10); 
	tm.display(1,min%10);
	tm.point(1); //activate : in the clock
	delay (100);
	tm.display(2,sec/10);
	tm.display(3,sec%10);
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
}


void check_wires ( )
{
	if(ClockPin == HIGH && DataPin == LOW){
		error();
	}

	if(ClockPin == LOW && DataPin == HIGH){
		correct();
	}
}

void setup ( )
{
	pinMode(CLK, OUTPUT);
	pinMode(DIO, OUTPUT);
	
	auto State = get ( );
	// trasmit over the ClockPin e DataPin following I2C standard

	// the Board State
	
	// set up for the timing function and display
	display_time ( MAX_TIME ); 

	//timer module setup
	tm.init();
	tm.set(BRHT);

	//wait for signal to start
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

	if ( timeleft ( ) == 0 || Strikes >= MAX_STRIKES )
	{
		// send the End the Game state
		detonate();
		// exit the program 
	}

	if ( Modules_Solved >= TOTAL_MODULES )
	{
		// send the End the Game state
		solved();
		// exit the program
	}

	// displays time left
	display_time ( timeleft ( ) ); 
}