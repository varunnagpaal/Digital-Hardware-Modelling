#include <iostream>
#include "gate_module_tb.h"

using namespace std;

stimulus::stimulus( sc_module_name name ): sc_module( name )
{
	cout << "Init Stimulus Module: " << name << endl;
	SC_THREAD( process_stim );	// NOTE: This thread requires no sensitivity as it runs to completion
	
}

void stimulus::process_stim()
{
	// Write to output ports followed by waits
	out_A.write( SC_LOGIC_0 );
	out_B.write( SC_LOGIC_0 );

	wait( 5, SC_NS );

	out_A.write( SC_LOGIC_0 );
	out_B.write( SC_LOGIC_1 );

	wait( 5, SC_NS );

	sc_stop(); // Optional
}

monitor::monitor( sc_module_name name ): sc_module( name )
{
	cout << "Init Monitor Module: " << name << endl;
	cout << "Time\tA\tB..."<< endl;

	SC_METHOD( process_mon );	// Note this must be SC_METHOD and not SC_THREAD
	sensitive << {ALL INPUTS...};
}

void monitor::process_mon()
{
	cout << sc_time_stamp() << "\t"
		 << in_A  << "\t" << in_B << "\t" << endl;

}
