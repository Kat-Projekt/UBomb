#include <TM1637.h>
#define BRHT 2

class Display
{
private:
	int _CLK = 0;
	int _DIO = 0;
	TM1637 tm;
public:
	Display ( int CLK, int DIO ) : _CLK ( CLK ), _DIO ( DIO ), tm ( CLK, DIO ) { }
	void Start ( )
	{
		pinMode ( _CLK, OUTPUT );
		pinMode ( _DIO, OUTPUT );

		tm.init ( );
		tm.set ( BRHT );
	}

	void Write_Time ( long time ) 
	{
		long sec = time / 1000;
		long min = sec / 60;
		sec %= 60;

		tm.display(0,min/10); 
		tm.display(1,min%10);
		tm.point(1); //activate : in the clock
		delay (100);
		tm.display(2,sec/10);
		tm.display(3,sec%10);
	}

	void Write ( uint8_t data [4] )
	{
		tm.display ( data );
	}

	~Display ( ) { }
};

class Button
{
private:
	int _CLK = 0;
	bool pressed = false;
public:
	Button( int CLK ) : _CLK ( CLK ) { }
	void Start ( )
	{
		pinMode ( _CLK, INPUT );
	}
	bool Check ( ) {
		if ( pressed )
		{
			pressed = digitalRead ( _CLK ) == HIGH;
			return false;
		} else {
			pressed = digitalRead ( _CLK ) == HIGH;
			return pressed;
		}
	}
	~Button ( ) { }
};

class Led
{
private:
	int _PIN = 0;
	bool light = false;
public:
	Led ( int PIN ) : _PIN ( PIN ) { }
	void Start ( )
	{
		pinMode ( _PIN, INPUT );
		digitalWrite ( _PIN, LOW );
	}
	void Togle ( )
	{
		light = ! light;
		digitalWrite ( _PIN, light ? HIGH : LOW );
	}
	~Led() { }
};


int P1, P2;
int Count;
bool first_rot;
class Selector
{
private:
	
	static int IntCheck ( ) {
		if ( first_rot )
		{
			first_rot = false;
			if ( digitalRead ( P1 ) == HIGH ) {
				Count ++;
			} else { // the other is high, this function in songly calld by interupts
				Count --;
			}
		}
		else
		{
			first_rot = true;
		}

		Serial.write ( "interupt called: " );
		Serial.write ( Count );
		Serial.write ( "\n" );
	}
public:
	static void Start ( int _P1, int _P2 )
	{
		P1 = _P1;
		P2 = _P2;
		first_rot = false;
		Count = 0;
		pinMode ( P1, INPUT_PULLUP );
		pinMode ( P1, INPUT_PULLUP );

		attachInterrupt ( digitalPinToInterrupt ( P1 ), IntCheck, RISING  );
		attachInterrupt ( digitalPinToInterrupt ( P2 ), IntCheck, RISING  );
	}
	static int Check ( ) {
		int _c = Count;
		Count = 0;
		return _c;
	}
};

class Resistenza
{
private:
	/* data */
public:
	Resistenza(/* args */);
	~Resistenza();
};
