#include <iostream>
#include "Register.h"
#include "Register_TB.h"

int sc_main( int sc_argc, char * sc_argv[] )
{
	// Simulation parameters
	double clkPeriod = 5;
	sc_time_unit timeUnit = SC_NS;

	// DUT Parameters
	const int WIDTH = 32;

	// Control Signals
	sc_clock              sig_clock;
	sc_signal<sc_logic>   sig_reset;
	sc_signal<sc_logic>   sig_clear;
	sc_signal<sc_logic>   sig_preset;
	sc_signal<sc_logic>   sig_enable;
	sc_signal<sc_logic>   sig_load;

	// Data Signals
	sc_signal<sc_lv<WIDTH> > sig_d;
	sc_signal<sc_lv<WIDTH> > sig_load_d;
	sc_signal<sc_lv<WIDTH> > sig_q;

	// Logging
	sc_trace_file* trace_file = NULL;
	trace_file = sc_create_vcd_trace_file("tracefile");

	// Initialize Testbench: Stimulus generator and Monitor
	sc_module_name tbName( "TESTBENCH" );	
	testbench<WIDTH> TB( tbName, clkPeriod, timeUnit );
	
	// Initilaize DUT/DUV
	sc_module_name dutName( "DUT" );
	Register<WIDTH> DUT( dutName );

	// Connect DUT/DUV to Testbench
	TB.reset( sig_reset );
	TB.clear( sig_clear );
	TB.preset( sig_preset );
	TB.enable( sig_enable );
	TB.load( sig_load );

	TB.out_data( sig_d );
	TB.out_load_data( sig_load_d );
	TB.in_data( sig_q );

	DUT.in_d( sig_d );
	DUT.out_q( sig_q );
	MON.in_data( sig_q );

	// Set Simulation time resolution
	sc_set_time_resolution( 1, SC_NS );

	// Start simulation for given time or forever
	sc_time simTime( 100, SC_NS );
	sc_start( simTime );

	// Clean-up
	sc_close_vcd_trace_file( trace_file );

	return 0;
}