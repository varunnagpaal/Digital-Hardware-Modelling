#ifndef TEMPLATE_MODULE_H_
#define TEMPLATE_MODULE_H_

#include <systemc.h>

// Module Interface
class template_module: public sc_module
{
private:
	// Internal state variables of the module
	
	// Other module references or static instances
	
public:
	// Constructor with 1 or more arguments: name(mandatory), more arguments etc.
	SC_HAS_PROCESS( template_module );	
	template_module( sc_module_name name,
                     unsigned int arg_extra );
	
	// I/O Channels
	// I/O Ports
	
	// One or more functions to be registered as simulation process (thread/method)
	// with the simulation kernel
	void process( void );
	
	// normal c++ member functions which are not to be used as simulation processes
	void mem_func();
};


#endif /* TEMPLATE_MODULE_H_ */
