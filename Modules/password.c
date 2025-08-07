#include "../common.h"

Solution_Led Solved ( 12 );

Button Up [4];
Button Down [4];
Button Conferm ( 8 );
Display Numb ( 10,11 );

char comb [4] = "\1\0\2\3";
char lett [4] = "1234";
char tryC [4] = "\0\0\0\0";

void setup ( )
{
	Conferm.Start ( );
	for ( int i = 0; i < 4; i ++ )
	{
		Up [i] = Button ( i );
		Up [i].Start ( );

		Down [i] = Button ( 4+i );
		Down [i].Start ( );
	}

	Display.Start ( );
	Display.Display ( tryC );
}

void loop ( )
{
	if ( ! Solved.not ( ) )
	{
		return;
	}

	bool Equal = true;
	char disp_try [4];

	// check button for input
	for ( int i = 0; i < 4; i ++ )
	{
		int diff = 0;

		diff += Up[i].Check ( );
		diff += Down[i].Check ( );

		tryC [i] += diff;
		tryC [i] %= 4;

		if ( tryC[i] != comb[i] )
		{
			Equal = false;
		}

		disp_try[i] = lett [ tryC[i] ];
	}

	Display.Display ( disp_try ); // check for change internaly

	if ( Conferm.Check ( ) ) {
		if ( Equal )
		{
			Solved.Failed ( );
		}
		else
		{
			Solved.Solved ( );
		}
	}
}