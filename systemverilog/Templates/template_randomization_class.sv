////////////////////////////////////////////////////////////////////////////////
// Module Name  : template_scope_randomization
// File name    : template_scope_randomization.sv
// Description  : Template for SystemVerilog Scope Randomization facilties
// Type         : 
// Limitations  : None
// Model Styles : 
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 11/11/2020
////////////////////////////////////////////////////////////////////////////////

// Class properties need to be prefixed with attribute rand or randc in order
// to randomize them
// rand - uniform distribution i.e. all possible random values have equal probabilities
//        and every time a value is randomly produced, it could be repetition of already 
//        produced values
// randc - uniform distribution without repititon i.e. cyclic. all values are 
//         produced during each iteration of randomization
// Every SV class has a built-in virtual randomize function called randomize that can be
// invoked on instance of class with class properties defined with rand or randc
// attributes. It returns 1 if randomization was succesfful or 0 if failed

class randclass1;
  //  Group: Variables
  rand bit[2:0] var1; 
  rand bit[2:0] var2;
  var3;

  //  Constructor: new
  function new(string name = "template_randomization_class");
  endfunction: new
endclass: randclass1

randclass1 objrand1 = new();

// randomize every member property declared with rand or randc attribute prefix
int pass = randclass1.randomize();    // randomize var1, var2 but nor var3
if (!pass) begin
  $display("randomization failure");
end

// class variables can be selectively randomized by passing them as arguments to randomize 
// member method. This enables to randomize (uniform rand but not cyclic randc) even 
// those class properties which are NOT marked with rand or randc prefix attributes. 
// Also, once a class property is passed as an argument to randomize, then only that 
// property is randomized and the other class properties are left unchanged.
int pass = randclass1.randomize(var2);    // randomize var2 only
if (!pass) begin
  $display("randomization failure");
end
int pass = randclass1.randomize(var2, var3);    // randomize var2 and var3 but not var1
if (!pass) begin
  $display("randomization failure");
end

// Every class property which is prefixed with rand or randc attribute has an in-built enable bit 
// called rand_mode. This bit is enabled by defualt for every random class property but can be explictly 
// disabled or enabled using built-in task rand_mode() which can be applied to the specific random
// declared property. rand_mode() task method can also be called for class instance in which case 
// it is applied to all the radom class properties
randclass1.rand_mode(0);// disable randomization for all class properties
randclass1.var2.rand_mode(1);// enable randomization for only var2 property only
var1_rand_mode = randclass1.var1.rand_mode(); // read the random mode for random proerty var1
var1_rand_mode = randclass1.var3.rand_mode(); // error since var3 is not a random property

// When aggrgrating classes i.e one class has objects of another class
// then if we wish to randomize the member properties of the containee
// class then container class must delcare it with rand attribute
// otherwise when calling randomize on container class object, the containee
// class object properties will not be randomized

class randcontainerclass;
  rand int prop1;
  randc unsigned prop2;

  rand class randclass1 rc1;
endclass: randcontainerclass

randcontainerclass rccobj1 = new();
pass = rccobj1.randomize();
if (!pass) begin
  $display("randomization failure");
end

// One can defined constraint blocks inside class to constraint the range and probability distribution
// of the random class properties
class randclass3;
  //  Group: Variables
  randc logic [2:0] var1;
  randc bit   [1:0] var2;
  rand unsigned var3;
  logic flag;

  //  Group: Constraints
  constraint  {(var1%2 == 0) }
  constraint constr_odd_var2  {(var2%2 != 0) }
  constraint constr_range_var3  {var3 inside {[0:4096], [8192:16384], 32278}; } // 
  constraint constr_flag {  conditional constraint
    flag == 1 -> var3 > 1024;
    flag == 0 -> var3 < 512;
  }
  

  //  Constructor: new
  function new(string name = "randclass3");
  endfunction: new 

endclass: randclass3

randclass3 rc3obj1 = new();
rc3obj1.randomize();

// When inheriting classes, constraints can also be inherited, overridden or new added
class randclass4 extends randclass3;
  constraint constr_even_var1 { }                               // removes constr_even_var1 inherited from randlcass3
  constraint constr_odd_var2 { (var2%2 != 0) && (var2 != 3) }   // override constraint constr_odd_var2
  constraint constr_ranges {var1 inside {2,4,6,8};}             // adding new constraint for var1
  constraint constr_dist_var3 {var3 dist {0:= 30, [2:2024]:=75, [3000:4000]:/500 }}  // override constr_range_var3 with weighted distribution. 0 has weight 30. 2:2024 each get weight of 200. 3000:4000 each get weight of  500/1000 = 1/2
  constraint constr_flag {                                      // override constr_flag with conditional constraint
    if(flag == 1)  var3 >2048;
    else           var3 < 768;
  }
endclass: randclass4

randclass4 rc4obj1 = new();
rc4obj1.randomize();

// pre-randomize and post-randomize are two special callback functions
// which dont return a value and which take no arguments such that 
// when explicitly defined by user, they are automatically called by 
// the in-built virtual function randomize before and after randomization
// generally pre-randomize is called to prepare and check something required during
// randomization and post-randomization is done to check if randomization
// results are consistent with expectations and wouldnt break stuff ahead

//