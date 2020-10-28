////////////////////////////////////////////////////////////////////////////////
// Module Name  : template_polymorphism
// File name    : template_polymorphism.sv
// Description  : Template for SystemVerilog Polymorphism facilties
// Type         : 
// Limitations  : None
// Model Styles : 
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 16/10/2020
////////////////////////////////////////////////////////////////////////////////


/* SV Polymorphism, Overriding
  - A handle of base class is a declaration but it may point to object instance
    of a derived class. This is concept of Polymorphism.
  - One can always point a handel of a base class to object instance of a derived
    class. This is valid since a handle is just a pointer (reference) to a memory 
    location where data of the class instance resides. However, by doing this only 
    the base class members are accessible through base class handle and derived 
    class members cannot be accessed even though the base class handle points to 
    the derived class instance. In fact accessing derived class member properties
    from base class handle will produce compiler/runtime error. Also any methods
    of base class overidden in derived class would not be called when method call
    is made through base class handle even though base class handle is pointing 
    to a derived class instance.
  - Motivation for Virtual Methods: When accessing class members via a handle, 
    the resolution is done according to the type of handle and not the instance 
    pointed to by the class handle. A solution to this is to use dynamic casting 
    to copy back derived class instance back into derived class handle. This is 
    done by dynamic casting base class handle (pointing to the derived class 
    instance) to a derived class handle. But this not an elegant solution. 
    Instead use Virtual Methods!
  - Virtual Method
      - a method declared virtual automatically becomes virtual in all its
       derived classes at any level of inheritance hierarchy.
      - properties cannot be declared as virtual. In case a derived class
        property is needed to be accessed via a base class handle, then the only
        way to access the property indirectly is via call to a virtual method.
  - Virtual or Abstract Class
      - Can only be inherited and cannot be instantiated though virtual class 
        handle may be declared.
      - Only an abstract class can have pure virtual methods or prototypes i.e.
        methods with signature but no implementation. A pure virtual method has
        prefix of keywords "pure" and "virtual". The implementation of pure 
        virtual methods of an abstract class is provided by derived class which
        overrides the pure virtual abstract class method.
      - a derived class which inherits an abstract class as a base class must 
        override implementation of pure virtual methods in the base abstract class.
        Without this, the derived class instances cannot be created.
      - So a Virtual or Abstract class can have
          - methods
          - virtual methods
          - pure virtual methods
      - A normal class can have
          - methods
          - Virtual Methods
          - But no pure virtual methods
*/

// Naive Polymorphism: base class handle points to derived class instance. Doesn't work!!
base b1;
derived d1 = new(...);          // assume derived->base
b1 = d1;                        // base class handle points to derived class object
d1.methodOverriddenInDerived(); // Not OK: will call base class member method instead of derived class overridden member method
d1.derivedProperty = ...;       // Not OK: compiler/runtime error: base class handle cannot access derived class member property

// Trick to make Naive polymorphism work: somehow copy the base class handle pointing to a derived class instance back to a derived class handle.
derived d2;
d2 = b1;                        // Illegal: direct copy of base class handle pointing to derived class instance back into a derived class handle
$cast(d2, b1);                  // OK: dynamic casting checks whether base class handle b1 actually points to a derived class instance. 
                                //     If N, 0 is retuned and runtime error is flagged as this is illegal.
                                //     If Y, it is legal to assign (reference from) base class handle to derived class handle
                                // $cast is a subroutine defined both as a task and a function in SV.
d1.methodOverriddenInDerived(); // OK: will call overidden derived class member method now!
d1.derivedProperty = ...;       // OK: derived class handle can now access derived class member property

// Elegant Polymorphism: delcare class method of base class as Virtual!
class base;
  virtual function void doSomething();  // base class method declared virtual becomes automatically virtual in all derived classes
    $display("Base Class");
  endfunction: doSomething  
endclass: base

class derived_L1 extends base;
  virtual function void doSomething();  // overriding base class method. Note: virtual keyword here is redundant as this method was already declared virtual in base class.
    $display("Derived L1 class -> Base class");
  endfunction: doSomething
endclass //derived_L1 extends base

class derived_L2 extends derived_L1;
  function void doSomething()   // overriding derived_L1 class method. Note: virtual keyword here is redundant as this method was already declared virtual in base class.
    $display("Derived L2 class -> Derived L1 class");
  endfunction: doSomething
endclass //derived_L2 extends derived_L1

initial begin
  base b1;
  derived_L1 l1_inst_1 = new();
  derived_L2 l2_inst_1 = new();

  b1 = l1_inst_1;
  b1.doSomething();         // prints "Derived L1 class -> Base class"
  
  l1_inst_1 = l2_inst_1;
  l1_inst_1.doSomething();  // prints "Derived L2 class -> Derived L1 class"

end

// Abstrac or Virtual Class

virtual class base;
  //  Group: Variables

  //  Group: Constraints

  //  Group: Functions

  //  Constructor: new
  function new(string name = "base");
  endfunction: new
endclass: base