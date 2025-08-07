#include "common.h"
#include "components.h"

#define Sel1 4
#define Sel2 6

Button Con ( 2 );
Led Solved ( 4 );
Led Codes  ( 12 );
Display Mz ( 7,8 );

#define LineD 1000
#define DotD 200
#define SmalPause 100
#define Pause 2000

char frequency_table [16][10] = {
	"shell\t3505",
	"halls\t3515",
	"slick\t3522",
	"trick\t3532",
	"boxes\t3535",
	"leaks\t3542",
	"strobe3545",
	"bistro3552",
	"flick\t3555",
	"bombs\t3565",
	"break\t3572",
	"brick\t3575",
	"steak\t3582",
	"sting\t3592",
	"vector3595",
	"beats\t3600",
};

char morse_code [26][4] = {
	".-\0\0",
	"-...",
	"-.-.",
	"-..\0",
	".\0\0\0",
	"..-.",
	"--.\0",
	"....",
	"..\0\0",
	".---",
	"-.-\0",
	".-..",
	"--\0\0",
	"-.\0\0",
	"---\0",
	".--.",
	"--.-",
	".-.\0",
	"...\0",
	"-\0\0\0",
	"..-\0",
	"...-",
	".--\0",
	"-..-",
	"-.--",
	"--.."
};

int solu = 0;
int choose = 0;

void setup ( )
{
	Con.Start ( );
	Solved.Start ( );
	Codes.Start ( );
	Mz.Start ( );
	Selector::Start ( Sel1,Sel2 );

	digitalWrite ( 5, LOW );

	// serial connection for debugging
	Serial.begin ( 9600 );

	randomSeed(analogRead(0));
	solu = random (0,15);
}

void loop ( )
{
	static int current_index = -1;
	current_index ++;
	char current_letter = frequency_table [ solu ] [ current_index ];
	
	if ( current_letter == '\0' || current_index == 6 )
	{
		current_index = 0;
		return;
	} 
	else 
	{
		current_index ++;
	}
	
	for ( int i = 0; i < 4; i++ )
	{
		char to_print = morse_code [ current_letter - 'a' ] [i];
		if ( to_print == '\0' )
		{ break; }
		
		Codes.Togle ( );
		
		delay ( to_print == '-' ? LineD : DotD );

		Codes.Togle ( );

		delay ( SmalPause );

		// print letter
		// the current letter
	}

	delay ( Pause );

	choose = ( ( choose + Selector::Check ( ) ) % 26 );

	Serial.write ( choose );
}