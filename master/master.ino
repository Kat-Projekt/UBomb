#include "common.h"
#include "components.h"

#define CLK 2
#define DIO 4

#define ERROR 10
#define SOLVE 9

#define BUTTON 9

Display Dis ( CLK, DIO );
Button Butt ( BUTTON );
Led Ledd ( 11 );

int Modules_Solved = 0;
int Strikes = 0;

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
	if ( digitalRead ( ERROR ) == HIGH )
	{
		error();
	}

	if ( digitalRead ( SOLVE ) == HIGH )
	{
		correct();
	}
}

void check_wincon ( )
{
	if ( timeLeft ( ) == 0 || Strikes >= MAX_STRIKES )
	{
		detonate();
	}

	if ( Modules_Solved >= TOTAL_MODULES )
	{
		solved();
	}
}

void setup ( )
{
	Dis.Start ( );
	Butt.Start ( );
	Ledd.Start ( );

	pinMode ( ERROR, INPUT );
	pinMode ( SOLVE, INPUT );

	Serial.begin(9600);
}

int c = 0;
void loop ( ) 
{
	check_wires ( );
	check_wincon ( );

	if ( Butt.Check ( ) )
	{
		Dis.Write_Time ( c++ * 1000 );
		Ledd.Togle ( );
	}
}