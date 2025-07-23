#include "../common.h"
#define led_sol_1 ;//12 pin digitali
#define led_sol_2 ;//12 pin digitali
#define led_sol_3 ;//12 pin digitali
#define led_sol_4 ;//12 pin digitali
#define led_sol_5 ;//12 pin digitali
#define led_sol_6 ;//12 pin digitali
#define led_sol_7 ;//12 pin digitali
#define led_sol_8 ;//12 pin digitali
#define led_sol_9 ;//12 pin digitali
#define led_sol_10 ;//12 pin digitali
#define led_sol_11 ;//12 pin digitali
#define led_sol_12 ;//12 pin digitali
#define led_time_1 ;//3 pin anal
#define led_time_2 ;//3 pin anal
#define led_time_3 ;//3 pin anal
#define potentiometer ;//potenziometro
#define led_solved ; //led out
#define randomness_pin ; // a disconnected analog pin;

bool is_up (){

}

bool is_right (){
	
}

bool is_down (){
	
}

bool is_left (){
	
}

void set_solution(int num){
	switch (num) {
		case 0:
			digitalwrite(led_sol_1, LOW);
			digitalwrite(led_sol_2, LOW);
			digitalwrite(led_sol_3, HIGH);
			digitalwrite(led_sol_4, LOW);
			digitalwrite(led_sol_5, HIGH);
			digitalwrite(led_sol_6, HIGH);
			digitalwrite(led_sol_7, HIGH);
			digitalwrite(led_sol_8, HIGH);
			digitalwrite(led_sol_9, HIGH);
			digitalwrite(led_sol_10, HIGH);
			digitalwrite(led_sol_11, LOW);
			digitalwrite(led_sol_12, HIGH);
			break;
		case 1:
			digitalwrite(led_sol_1, HIGH);
			digitalwrite(led_sol_2, LOW);
			digitalwrite(led_sol_3, HIGH);
			digitalwrite(led_sol_4, LOW);
			digitalwrite(led_sol_5, HIGH);
			digitalwrite(led_sol_6, LOW);
			digitalwrite(led_sol_7, LOW);
			digitalwrite(led_sol_8, HIGH);
			digitalwrite(led_sol_9, HIGH);
			digitalwrite(led_sol_10, LOW);
			digitalwrite(led_sol_11, HIGH);
			digitalwrite(led_sol_12, HIGH);
			break;
		case 2:
			digitalwrite(led_sol_1, LOW);
			digitalwrite(led_sol_2, HIGH);
			digitalwrite(led_sol_3, HIGH);
			digitalwrite(led_sol_4, LOW);
			digitalwrite(led_sol_5, LOW);
			digitalwrite(led_sol_6, HIGH);
			digitalwrite(led_sol_7, HIGH);
			digitalwrite(led_sol_8, HIGH);
			digitalwrite(led_sol_9, HIGH);
			digitalwrite(led_sol_10, HIGH);
			digitalwrite(led_sol_11, LOW);
			digitalwrite(led_sol_12, HIGH);
			break;
		case 3:
			digitalwrite(led_sol_1, HIGH);
			digitalwrite(led_sol_2, LOW);
			digitalwrite(led_sol_3, HIGH);
			digitalwrite(led_sol_4, LOW);
			digitalwrite(led_sol_5, HIGH);
			digitalwrite(led_sol_6, LOW);
			digitalwrite(led_sol_7, LOW);
			digitalwrite(led_sol_8, HIGH);
			digitalwrite(led_sol_9, LOW);
			digitalwrite(led_sol_10, LOW);
			digitalwrite(led_sol_11, LOW);
			digitalwrite(led_sol_12, HIGH);
			break;
		case 4:
			digitalwrite(led_sol_1, LOW);
			digitalwrite(led_sol_2, LOW);
			digitalwrite(led_sol_3, LOW);
			digitalwrite(led_sol_4, LOW);
			digitalwrite(led_sol_5, HIGH);
			digitalwrite(led_sol_6, LOW);
			digitalwrite(led_sol_7, HIGH);
			digitalwrite(led_sol_8, LOW);
			digitalwrite(led_sol_9, LOW);
			digitalwrite(led_sol_10, HIGH);
			digitalwrite(led_sol_11, HIGH);
			digitalwrite(led_sol_12, HIGH);
			break;
		case 5:
			digitalwrite(led_sol_1, LOW);
			digitalwrite(led_sol_2, LOW);
			digitalwrite(led_sol_3, LOW);
			digitalwrite(led_sol_4, LOW);
			digitalwrite(led_sol_5, HIGH);
			digitalwrite(led_sol_6, LOW);
			digitalwrite(led_sol_7, LOW);
			digitalwrite(led_sol_8, LOW);
			digitalwrite(led_sol_9, LOW);
			digitalwrite(led_sol_10, HIGH);
			digitalwrite(led_sol_11, HIGH);
			digitalwrite(led_sol_12, LOW);
			break;
		case 6:
			digitalwrite(led_sol_1, HIGH);
			digitalwrite(led_sol_2, LOW);
			digitalwrite(led_sol_3, HIGH);
			digitalwrite(led_sol_4, HIGH);
			digitalwrite(led_sol_5, HIGH);
			digitalwrite(led_sol_6, HIGH);
			digitalwrite(led_sol_7, HIGH);
			digitalwrite(led_sol_8, HIGH);
			digitalwrite(led_sol_9, HIGH);
			digitalwrite(led_sol_10, LOW);
			digitalwrite(led_sol_11, HIGH);
			digitalwrite(led_sol_12, LOW);
			break;
		case 7:
			digitalwrite(led_sol_1, HIGH);
			digitalwrite(led_sol_2, LOW);
			digitalwrite(led_sol_3, HIGH);
			digitalwrite(led_sol_4, HIGH);
			digitalwrite(led_sol_5, LOW);
			digitalwrite(led_sol_6, LOW);
			digitalwrite(led_sol_7, HIGH);
			digitalwrite(led_sol_8, HIGH);
			digitalwrite(led_sol_9, HIGH);
			digitalwrite(led_sol_10, LOW);
			digitalwrite(led_sol_11, HIGH);
			digitalwrite(led_sol_12, LOW);	
			break;
		default:
			// statements
			break;
    }
}

void setup ( )
{
	auto State = get ( );

	pinmode(led_sol_1, OUTPUT);
	pinmode(led_sol_2, OUTPUT);
	pinmode(led_sol_3, OUTPUT);
	pinmode(led_sol_4, OUTPUT);
	pinmode(led_sol_5, OUTPUT);
	pinmode(led_sol_6, OUTPUT);
	pinmode(led_sol_7, OUTPUT);
	pinmode(led_sol_8, OUTPUT);
	pinmode(led_sol_9, OUTPUT);
	pinmode(led_sol_10, OUTPUT);
	pinmode(led_sol_11, OUTPUT);
	pinmode(led_sol_12, OUTPUT);
	pinmode(led_time_1, OUTPUT);
	pinmode(led_time_2, OUTPUT);
	pinmode(led_time_3, OUTPUT);
	pinmode(led_solved, OUTPUT);
	pinmode(potentiometer, INPUT);
	pinmode(randomness_pin, INPUT);
	// set up local variables that use the State

	//initialize random number gen;
	randomSeed(analogRead(randomness_pin));

	timeleft ( ); // inizialize timer for the modues that use it

	int solution = random(8);

	set_solution(solution);

}

void loop ( )
{
	// do the module things
	if(){
		solution = random(8);
		set_solution(soluion);
	}
	
	
	// check fo 1 1
	if ( is_end ( ) )
	{
		// do something?
	}
}