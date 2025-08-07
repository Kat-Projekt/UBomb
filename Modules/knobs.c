#include "../common.h"
#define MaxTime 60 * 1000

char puzzleMask [8] [12] = {
	"ooxoxxxxxxox",
	"xoxoxooxxoxx",
	"oxxooxxxxxox",
	"xoxoxooxooox",
	"ooooxoxooxxx",
	"ooooxooooxxo",
	"xoxxxxxxxoxo",
	"xoxxooxxxoxo"
}

Potenziometer Pot ( A2 ); // analog 1
Led Solved ( 12 ); // for indicating correct positioning
Led Timer [3] = { Led(A3), Led(A4), Led(A5) };
Led Comb [12];

void tellTime ( )
{
	// 0-33 Led1
	// 34-66 Led2
	// 67-100 Led3
	float T = float ( millis ( ) % MaxTime ) / MaxTime;
	Timer [0].Dim (
		t > 0.33 ? 1 : t * 3 	
	);
	Timer [1].Dim (
		t < 0.33 ? 0 : 
		( t < 0.66 ? ( t - 0.33 ) * 3 : 1 )
	);
	Timer [2].Dim (
		t < 0.66 ? 0 : ( t - 0.66 ) * 3 	
	);
}

void setPuzzle ( int p )
{
	for ( int i = 0; i < 12; i++ )
	{
		if ( puzzleMask[p][i] == 'o' )
		{
			Comb[i].Dark ( );
		}
		else
		{
			Comb[i].Light ( );
		}
	}
}

void setup ( )
{
	for ( int i = 0; i < 12; i++ )
	{
		Comb[i] = Led ( i );
		Comb[i].Start ( );
	}
	for ( int i = 0; i < 3; i++ )
	{
		Timer[i].Start ( );
	}

	Solved.Start ( );
	Pot.Start ( );
}

void loop ( )
{
	if ( ) {
		solution = random(8);
		set_solution(soluion);
	}
	
	
	// check fo 1 1
	if ( is_end ( ) )
	{
		// do something?
	}
}