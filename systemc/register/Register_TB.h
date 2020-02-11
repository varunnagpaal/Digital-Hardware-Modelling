#ifndef REGISTER_TB_H
#define REGISTER_TB_H

#include "systemc.h"

// Testbench module
template<int W=32>
class testbench: public sc_module
{
private:

public:

	// Time parameters
	double		 _clkPeriod;
	sc_time_unit _timeUnit;

	// Clock
	sc_clock clock;

	// Ports for Stimulus process
	sc_out<sc_logic> reset;		// Active-low synchronous reset
	sc_out<sc_logic> clear;		// Active-high asynchronous clear
	sc_out<sc_logic> preset;	// Active-high asynchronous preset
	sc_out<sc_logic> load;		// Active-high asynchronous load
	sc_out<sc_logic> enable;	// Active-high synchronous enable
	sc_out<sc_lv<W>> out_data;	// Stimulus data
	sc_out<sc_lv<W>> out_load_data;	// Loadable data

	// Ports for Monitor process
	sc_in<sc_lv<W> > in_data;

	// Allows constructor to have additional arguments
	// and to be defined in cpp file
	SC_HAS_PROCESS( testbench );
	testbench( sc_module_name name, double clkPeriod, sc_time_unit timeUnit );

	// Module simulation processes
	void thread_stimulus( void );
	void thread_monitor( void );
};

// Note: to compile this project, make sure the below cpp file is excluded from project
// otherwise error C2995:function template has already been defined
#include "Register_TB.cpp"
#endif // REGISTER_TB_H
