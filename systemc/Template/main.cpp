#include "template_module.h"
#include "template_tb.h"

// Test bench which applies stimulus to a DUT/DUV and tracks its ouutput via a monitor
int sc_main(int sc_argc, char * sc_argv[])
{
	// Declare signals to connect DUT/DUV with Stimulus generator and Monitor
	sc_signal<sc_logic> sig_A;

	// Logging
	sc_trace_file* trace_file = NULL;
	trace_file = sc_create_vcd_trace_file( "tracefile" );
	if( !trace_file )
	{
		cout<<"Error tracing!"<<endl;
	}

	sc_trace( trace_file, sig_A, "A" );

	// Init Stimulus module
	stimulus STIM( "STIM" );
	STIM.out_A( sig_A );

	// Connect DUT to Stimulus Module
	template_module DUT( "DUT");
	DUT.A( sig_A );
	DUT.out_and( sig_and );

	// Connect DUT to Monitor module
	monitor MON("MON");
	MON.in_A( sig_A );

	// Set the simulator time resolution
	sc_set_time_resolution( 1, SC_NS );
	
	// Start the simulation for a given time
	sc_start( 100, SC_NS ); // or sc_start() for infinite simulation

	// Clean-up
	sc_close_vcd_trace_file( trace_file );
	
	return 0;
};
