#include "../common.h"

// negative numbers are: same position as -a
char Stages[5][4] {
	{ 2, 2, 3, 4 },
	{ 3,-1, 1,-1 },
	{-2,-1, 3, 3 },
	{-1, 1,-2,-2 },
	{-1,-2,-4,-3 }
}

// stores the compination of the buttons to press
char Memory [5];

Solution_Led Solved ( 12 );
Button Numb[4];
Display Mem ( 9,10 );
Led Phase[5];

void setup ( )
{
	for ( int i = 0; i < 5; i++ )
	{
		Phase [i] = Led ( i );
		Phase [i].Start ( );
	}

	for ( int i = 0; i < 4; i++ )
	{
		Numb [i] = Button ( 5+i );
		Numb [i].Start ( );
	}

	// create the combination
	for ( int i = 0; i < 5; i++ )
	{
		Memory [i] = Stages [i] [random ( ) % 4];
		if ( Memory [i] < 0 ) {
			Memory [i] = Memory
			[ - Memory [i] - 1 ];
		}
		else
		{
			Memory [i] --;
		}
	}
}

void loop ( )
{
	static index = 0;

	if ( index > 5 )
	{
		return;
	}

	for ( int i = 0; i < 4; i++ )
	{
		if ( Numb[i].Check ( ) )
		{
			if ( i = Memory[index] )
			{
				index ++;
				break;
			}
			else
			{
				Solved.Failed ( );
				index = 0;
			}
		}
	}

	if ( index > 5 )
	{
		Solved.Solved ( );
	}
}