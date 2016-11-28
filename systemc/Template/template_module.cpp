#include "template_module.h"

// Module implementation
template_module::template_module( sc_module_name name ): sc_module( name )
{
	// Register function as simulation process(thread or method) with the simulation kernel
	// Static Sensitivity list declaration for processes registered as method/thread
}

// Simulation process has no arguments and return no values 
// since it is invoked only by simulation kernel 
void template_module::process()
{

}
