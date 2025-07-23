#define ClockPin -1
#define DataPin -1
#define MAX_TIME 300000 // 5 minuti in ms
#define PENALTY_TIME 50000 //ms
#define MAX_STRIKES 3
#define TOTAL_MODULES 9
long StartTime long, PenaltyTime

struct BoardState
{
	char serial [6]; // the serial is alway 6 caracters
	unsigned char batteries; // number it is always les than 255
	char lit [3]; // the lit code always 3 letters
	char ports; // use every bit for a single port there are 6 ports
		// ports will be used with a mask like ( ports & 0x01 )
		// for the DVI-D port as per manual is number 1 so first bit
};

long timeleft (long StartTime, long PenaltyTime) // the number is clamped to [0,maxtime) if 0 it is over
{
	long TimePassed = mills() - StartTime + PenaltyTime;
	long TimeLeft = MAX_TIME - TimePassed;
	if(TimeLeft > 0){
		return TimeLeft;
	}else{
		return 0;
	}
}