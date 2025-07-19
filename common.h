#define ClockPin -1
#define DataPin -1
#define MAX_TIME 300000 // 5 minuti
#define TOTAL_TRIES 2
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

unsigned int timeleft ( ) // the number is clamped to [0,maxtime) if 0 it is over
{

	long TimePassed = mills();
	long TimeLeft = MAX_TIME - TimePassed;
	if(TimeLeft > 0){
		return TimeLeft;
	}else{
		return 0;
	}
}

