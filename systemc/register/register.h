#ifndef REGISTER_H
#define REGISTER_H

#include "systemc.h"

template<int W=32>
class Register: public sc_module
{
private:

public:
	// Port declarations
	sc_in<sc_logic>   clock;		// Active-high clock
	sc_in<sc_logic>   reset;		// Active-low synchronous reset
	sc_in<sc_logic>	  clear;		// Active-high asynchronous clear
	sc_in<sc_logic>   preset;		// Active-high asynchronous preset
	sc_in<sc_logic>   load;			// Active-high asynchronous load
	sc_in<sc_logic>   enable;		// Active-high synchronous enable
	sc_in<sc_lv<W> >  in_d;			// Data-input(multi-bit)
	sc_in<sc_lv<W> >  in_load_d;	// Loadable Data-input(multi-bit)
	sc_out<sc_lv<W> > out_q;		// Data-output(multi-bit)

	// Allows constrcutor to have additional arguments 
	// and to be defined in cpp file
	SC_HAS_PROCESS( Register );		
	Register( sc_module_name name );

	// Simulation process
	void process( void );
};

// Note: to compile this project, make sure the below cpp file is excluded from project
// otherwise error C2995:function template has already been defined
#include "Register.cpp"
#endif // REGISTER_H