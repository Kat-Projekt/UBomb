#include "../common.h"
Solution_Led Solved ( 12 );
Wire Wires [ 6 ];

#define first_wire 3
#define correct 3

void setup ( )
{
	auto State = get ( );
	for ( int i = 0; i < 6; i ++ )
	{
		Wires [i] = Wire ( first_wire+i );
		Wires [i].Start ( );
	}

	Solved.Start ( );
}

void loop ( )
{
	if ( ! Solved.not ( ) )
	{ 
		return;
	}

	for ( int i = 0; i < 6; i ++ )
	{
		if ( Wires [i].Check ( ) )
		{
			if ( i == correct )
			{
				Solved.Solved ( );
			}
			else
			{
				Solved.Failed ( );
			}
		}
	}
}