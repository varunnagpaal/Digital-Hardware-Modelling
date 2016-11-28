#include "Register_TB.h"
#include <iostream>

// Stimulus Generator Implementation
template<int W>
testbench<W>::testbench( sc_module_name name, 
						 double clkPeriod,
						 sc_time_unit timeUnit ): sc_module( name ),
												  _clkPeriod( clkPeriod ),
												  _timeUnit( timeUnit ),
												  clock( "CLOCK", clkPeriod, timeUnit, 0.5, 0.0, timeUnit, false )
												 
{
	SC_THREAD( thread_stimulus );
	dont_initialize();	// Tells simulator kernel not to call this simulation process at simultation time 0
	sensitive << clock.posedge_event();
	
	SC_THREAD( thread_monitor );
	dont_initialize();	// Tells simulator kernel not to call this simulation process at simultation time 0
	sensitive << clock.posedge_event();
}

template<int W>
void testbench<W>::thread_stimulus( void )
{
	clear.write( SC_LOGIC_Z );	// Tri-stated
	reset.write( SC_LOGIC_Z );	// Tri-stated
	preset.write( SC_LOGIC_Z );	// Tri-stated
	load.write( SC_LOGIC_Z );	// Tri-stated
	enable.write( SC_LOGIC_Z );	// Tri-stated
	wait( _clkPeriod, _timeUnit );

	// Assert async clear
	clear.write( SC_LOGIC_1 );
	wait( 0.5*_clkPeriod, _timeUnit );	
	clear.write( SC_LOGIC_0 );	// De-assert

	// Assert synch reset
	reset.write( SC_LOGIC_0 );
	wait( 1.5*_clkPeriod, _timeUnit );
	reset.write( SC_LOGIC_1 );	// De-assert

	// Assert async preset
	preset.write( SC_LOGIC_1 );
	wait();	// wait for clk positive edge
	preset.write( SC_LOGIC_0 );	// De-assert

	// Assert async load
	out_load_data.write( static_cast<sc_lv<W>>( 4 ) );
	load.write( SC_LOGIC_1 );
	wait( _clkPeriod, _timeUnit );
	load.write( SC_LOGIC_0 );	// De-assert

	// Enable
	enable.write( SC_LOGIC_1 );
	for( unsigned i=0; i<10; ++i)
	{
		out_data.write( static_cast<sc_lv<W>>( 1<<(i+3) ) );	// shift 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096
		wait( _clkPeriod, _timeUnit );
	}
	wait( _clkPeriod, _timeUnit );
}

template<int W>
void testbench<W>::thread_monitor( void )
{
}