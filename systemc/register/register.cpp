#include "Register.h"

template<int W>
Register<W>::Register( sc_module_name name ): sc_module(name)	
{
	SC_METHOD( process );
	dont_initialize();	// Tells simulator kernel not to call this simulation process at simultation time 0
	sensitive << clear;	// highest priority
	sensitive << preset;
	sensitive << load;
	sensitive << clock.pos();	// least priority
}

template<int W>
void Register<W>::process( void )
{
	// Asynchronous signals first(in decreading priority order)
	if( clear.read() == SC_LOGIC_1 )
	{
		// async clear
		out_q.write( static_cast<sc_lv<W>>(0) );
	}
	else if( preset.read() == SC_LOGIC_1 )
	{
		// async preset
		out_q.write( 1 );
	}
	else if( load.read() == SC_LOGIC_1 )
	{
		// async data load
		out_q.write( in_load_d.read() );
	}
	else if( clock.posedge() )
	{
		// Synchronous reset
		if( reset.read() == SC_LOGIC_0 )
		{
			out_q.write( static_cast<sc_lv<W>>(0) );
		}
		else if ( enable.read() == SC_LOGIC_1 )	// Synchronous Enable
		{
			out_q.write( in_d.read() );
		}
	}
}