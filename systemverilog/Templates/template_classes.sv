////////////////////////////////////////////////////////////////////////////////
// Module Name  : template_classes
// File name    : template_classes.sv
// Description  : Template for SystemVerilog Class
// Type         : 
// Limitations  : None
// Model Styles : 
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 16/10/2020
////////////////////////////////////////////////////////////////////////////////

/* SV Class
  - Declared inside a module, program, package, interface etc.
  - User defined data type which has
    - methods or member tasks/functions
      - member methods cannot be overloaded i.e. multiple definitions of a class
        member method (task/function) with different number/types of arguments.
    - properties or member variables
      - property can only be of a variable type but not a net type
      - by default, a property value is initialized to default value sasy 
        x for 4-state logic type and 0 for 2-state logic types.
    - static properties and methods  (not bound to any class object)
      - static properties are default initialized to 0 but can also be explicitly
        intialized.
      - static methods can only modify static properties. They can be called either
        from the class name using scope resolution operator :: (recommended) or from
        class handle using . member access operator
    - parameters to make the class into a parameterized or template class
          - parameter can be a value or a type
          - parameter may have a default value which can be overriden during class
            specialization (new class created for new paramter value).
          - when parameter is a type such as T, then member methods must work for
            all expected type overrides during class instantiation. This includes
            SV types such as enum and struct.
          - Every new parameter value creates a new class with new set of static
            members. This is called class specialization.
  - Used for OOP for TB and Simulation Models
  - Supports OOP features such as
    - Inheritance
          - SV allows only single inheritance
          - parent class is called super class and derived class is called sub-class or 
            child class.
          - derived class can have its own properties and methods in addition to the properties
            and methods (which it can override optionally) of the parent class that it inherits.
          - subclass constructor automaticaly calls base class constructor  as the first thing
            when it is invoked during instantiation. This is true when the base class constructor
            is a default constructor. However if base class has an explicit constructord defined 
            with one or more arguments than the derived class needs to explictly call the base 
            class constructor with appropriate arguments.
          - derived class object can refer to base class object using refernce called "super" 
    - Data Encapsulation (Hiding) 
      - By default member properties and methods are publically visible for handle of 
        the object instance of the class.
      - To make members private, use keyword local. 
      - To make members accessible to only subclasses but not publically, use protected keyword
    - Abstract Modeling 
    - Polymorphism (overriding)
  - Declaring variable of an SV class creates what is called as a Handle. 
  - In addition to user defined properties and methods, a class handle also contains
    a hidden member pointer variable which points to location in memory where object 
    data is stored.
  - An object instance corresponding to a class is created for a handle by 
    explictly calling the class method or class constructor called new. New is by 
    defaulot defined for any class. It allocates memory to store the member 
    variables or properties of the class handle and assigns location of this memory 
    to the hidden member pointer property of the class handle. 
  - User can also explicitly declare and define new class constructor as a function 
    with no return value (for example to initialize member property values).
  - A class handle thus points to null unless it is initialized or assigned to the new
    class constructor either as an initializer during declaration or as an explicit 
    assignment to new after declaration.
  - Properties and Method members of a class instance are accessed using the "." member
    access operator.
  - A class instance can be referred to by keyword this in the member methods to access
    member properties and member methods.
  - SV has automatic garbage collection (responsibility of the simulator) which means
    lifetime of object pointed to by a class handle ends when the handle is either
    - No longer used (say going out of scope)
    - Or is explicitly assigned null value. (rarely)
*/

/*
  Declaring  which has a null value unless 
  it is initialized to point to an object instance in memory created using class 
  method called new.

*/
module template_classes;
  class stimulus;
    int   _data;
    logic _valid = 0;         // default value of member property

    task set(input int data); // declaration and definition of member method
      _data = data;
    endtask: set    

    function int get();       // declaration and definition of member method
      return _data;
    endfunction: get

    extern function int mul(input int factor);  // declaration of member method but no definition.
  endclass: stimulus

  // definition of a previously declared (extern) member function
  function int template_classes::mul(input int factor); // note: scope resolution operator ::
    _data = _data*factor;
  endfunction: mul
  
  stimulus stmHandle1;        // this handle is uninitialzied and therefore has null value
  stimulus stmHandle2 = new;  // this handle points to an object instance created in memory
  stmHandle1 = new;           // handle now points to an object instance of class created in memory by new class constructor

  initial begin
    stmHandle1._data = 100;
    stmHandle2.set (stmHandle1.get() *5);

    $display("Handle 1 data: %0d, Handle 2 data: %0d", stmHandle1.data, stmHandle2.data);    
  end

 //  Class: monitor
  class monitor;
    //  Group: Variables
    int         _data;
    logic [7:0] _address;
    logic       _enable = 0;
    
    //  Group: Functions
    function new(string name = "monitor",     // Class constructor New
                 input int data, 
                           address
                );
        _data = data;
        _address = address;
    endfunction: new    
  endclass: monitor

  //  Class: frame
  class frame;
    //  Group: Variables
            string        _fName;
            logic [15:0]  _address;
            logic [7:0]   _data;
            logic         _parity = 0;  // intial value redundant here since constructor updates it
            int           _frmId = 0; 
    static  int           _frmCnt = 0;  // static property explicitly initialized shared by all object instances of the class
    
    //  Group: Functions
    function new( string fName = "frame",
                  input int address,
                            data
                );
      _fName = fName;
      _address = address;
      _data = data;
      generate_parity();
      ++_frmCnt;
      _frmId = _frmCnt;
    endfunction: new

    extern function void          generate_parity(parameters);    
    extern function logic [24:0]  getFrame(parameters);

    static function int getFrameCount();
      return _frmCnt;
    endfunction
  endclass: frame

  function void frame::generate_parity();
    this._parity = ^{_address, _data};  // accessing member
  endfunction: generate_parity

  // packing method: returns a single vector which packs all properties of the object instance
  function logic [24:0] frame::getFrame();
    return ({_address, _data, _parity});
  endfunction: name

  initial begin
    frame fx = new("frame X", 0xF110, 1);   // fx has address=0xF110, data=1, frmId = 1
    frame fy = new("frame Y", 0xF111, 13);  // fx has address=0xF111, data=12, frmId = 1

    $display("Total number of frames created: $0d", frame::getFrameCount()); // calling static method using ::

    frame fz  = new("frame Z", 0xF11D, 100);

    $display("Total number of frames created: $0d", fz.getFrameCount());    // calling static method using .
  end

  //  Aggregate or Composite class
  class videoFormatX;
    //  Group: Variables
    frame listFrames[1080][1920];
  
    //  Group: Functions
  
    //  Constructor: new
    function new( string formatName = "videoFormatX",
                  input logic [15:0] baseAddress,
                        logic [7:0]  defaultData
                );
      for(int i = 0; i < 1080; ++i)
        for (int j= 0; j < 1920; ++j)
          this.listFrames[i][j] = new(baseAddress, defaultData);  // calling base class constructor
    endfunction: new
  endclass: videoFormatX

  videoFormatX fmtX = new("HD", 0x111F, 0);
  fmtX.listFrames[0][0]._address = 0x112F;  // hierarhichal member access

  // Inheritance: derived class
  class TagFrame extends Frame;
    local int tag;        // local member property visible only inside the class but not publocally through object member access operator "."
    protected int tagId;  // protected member property accessible only locally or to derived class but not publically 

    // derived class constructor automatically calls base class constructor
    function new( input int address,
                            data
                );
      // when base class constructor is not a default constructor but an explicitly defined constructor
      // than it is not  automatically called (infact compiler error is produced) and one needs to explictly
      // call the base class constructor (with appropriate arguments) as the first statement in the derived
      // class constructor before any other derived class constructor code is called.
      // base class constructor is called via the super keyword which is reference to the base class object
      // first line of derived class constructor must call base class constructor with appropriate arguments
      // otherwise a default base class constructor call is automatically inserted.
      // Note: base class constructor call is allowed at only one level of inheritance and not for multiple
      // inheritance i.e. super.new(...) is allowed but not super.super.new (...)
      // so if base class constructor has arguments, then each subclass constructor must pass the arguments
      // bottom to top from last level subclass constructor to super parent class constructor. 
      super.new(address, data);          
      Frame::_frmCnt++;
      this.tag = Frame::_frmCnt;
      this.tagId = super._frmId;        // super refers to the base class object allowing member access of base class object       
    endfunction //new()
  endclass //TagFrame extends Frame

  class ErrorFrame extends TagFrame;
    local static int errCount = 0;      // local member property cannot be accessed publically using object member access operator "."
    function new(input int address,
                           data);
      super.new(address, data);      
    endfunction //new()

    function void check_error()
      if(super._parity)
        errCount++;
    endfunction:check_error

    function int get_error_cnt()
      return ErrorFrame::errCount;
    endfunction: get_error_cnt
  endclass //ErrorFrame extends TagFrame

  //  Paramterized and Template Class: tQueue
  class tQueue #(parameter int D = 1024, 
                          type T = int);
    local T data[D];
    static local depth;
    local int size;

    //  Group: Functions
    task enqueue(parameters);
      //...
    endtask: enqueue
    
    task dequeue(parameters);
      //...
    endtask: dequeue

    function int getsize();
      return size;
    endfunction: name

    function bool isFull();
      return ((size == depth) ? True:False);
    endfunction
    
    function bool isEmpty();
      return ((size == 0) ? True:False);
    endfunction

    //  Constructor: new
    function new(string name = "queue");
      tQueue::depth = D;
    endfunction: new

    initial begin
      tQueue #(.depth(512), .T(logic [3:0]) fifoQueue = new;

      fifoQueue.enqueue(...);
      fifoQueue.dequeue(...);

    end  
  endclass: tQueue

endmodule: template_classes