// base class: counter
//  Class: tCounter
//
class tCounter
  //  Group: Variables
  protected int count;
  //  Group: Functions

  //  Constructor: new
  function new(input int x)
    load(x);
  endfunction: new

  function void load(input int value);
    this.count = value;
  endfunction: name

  function int getcount();
    return count;
  endfunction: name
endclass: tCounter

// derived class: upcounter -> counter
class tUpCounter extends tCounter;
  function new(input int value);
    super.new(value);
  endfunction //new()

  function void next(input int value);
    super.count++;    
  endfunction: name
  
endclass //tUpcounter extends tCounter


// derived class: downconverter -> counter
class tDownCounter extends tCounter;
  function new(input int value);
    super.new(value);
  endfunction //new()

  function void next(input int value);
    super.count--;    
  endfunction: name  
endclass //tDownCounter extends tCounter