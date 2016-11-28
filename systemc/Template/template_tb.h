#ifndef TEMPLATE_TB_H_
#define TEMPLATE_TB_H_

#include <systemc.h>

// Module that generates stimulus for DUT or DUV 
class stimulus: public sc_module
{

public:

	// Port declarations (all ports of type output)
	sc_out<sc_logic> out_A;
	sc_out<sc_logic> out_B;

	SC_HAS_PROCESS( stimulus );
	stimulus( sc_module_name name );

	void process_stim( void );
};

// Module that tracks the output of the DUT or DUV
class monitor: public sc_module
{

public:

	// Port declarations (all ports of type input)
	sc_in<sc_logic> in;

	SC_HAS_PROCESS( monitor );
	monitor( sc_module_name name );

	void process_mon( void );
};

#endif /* TEMPLATE_TB_H_ */