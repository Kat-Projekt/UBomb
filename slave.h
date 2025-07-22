#include "common.h"

BoardState get ( )
{
	// recive over the ClockPin e DataPin following I2C standard
	// the Board State
}

void correct ( )
{
	bool done = false;
	
	while (!done){
		if(ClockPin == LOW && DataPin == LOW){
			pinMode(DataPin, OUTPUT);
			digitalWrite(DataPin, HIGH);
			delay(10);
			digitalWrite(DataPin, LOW);
			pinMode(DataPin, INPUT);
			done = true;
		}
	}
	// wait for the stream to be 0 0 then
	// send 0 1 to master
}

void error ( )
{
	bool done = false;
	
	while (!done){
		if(ClockPin == LOW && DataPin == LOW){
			pinMode(ClockPin, OUTPUT);
			digitalWrite(ClockPin, HIGH);
			delay(10);
			digitalWrite(ClockPin, LOW);
			pinMode(ClockPin, INPUT);
			done = true;
		}
	}
	// wait for the stream to be 0 0 then
	// send 1 0 to master
}

bool is_end ( )
{
	bool ans = false;
	if(ClockPin == HIGH && DataPin == HIGH){
		ans = true;
	}

	return ans;
	// checks for 1 1
}