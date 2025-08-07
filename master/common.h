#define ClockPin -1
#define DataPin -1
#define MAX_TIME 300000 // 5 minuti in ms
#define MAX_STRIKES 3
#define TOTAL_MODULES 9

struct BoardState
{
	char serial [6]; // the serial is alway 6 caracters
	unsigned char batteries; // number it is always les than 255
	char lit [3]; // the lit code always 3 letters
	char ports; // use every bit for a single port there are 6 ports
		// ports will be used with a mask like ( ports & 0x01 )
		// for the DVI-D port as per manual is number 1 so first bit
};

long timeLeft ( ) // the number is clamped to [0,maxtime) if 0 it is over
{
	// check if time > end_time
	static long end_time = millis ( ) + MAX_TIME; // use the one for arudino
	auto this_time = end_time - millis ( );
	return ( this_time <= 0 ? 0 : this_time );
}