#include "../common.h"

Solution_Led Solved ( 12 );
Display Freq ( 9,10 );
Led Blink ( 7 );
Button Conferm ( 5 );
Potentiometer Pot ( 2,3 );

char Frequenze [16][10] = {
	'acvbv\t3500',
	...
}

int Combinazione = 0;

void setup ( )
{
	Solved.Start ( );
	Freq.Start ( );
	Blink.Start ( );
	Conferm.Start ( );
	Pot.Start ( );
}

void loop ( )
{
	if ( ! Solved.not ( ) )
	{
		return;
	}
	
	
}