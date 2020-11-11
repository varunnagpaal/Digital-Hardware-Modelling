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
  rand logic [7:0] arr_var4 [0:127];

  logic flag;

  //  Group: Constraints
  constraint  {(var1%2 == 0) }
  constraint constr_odd_var2  {(var2%2 != 0) }
  constraint constr_range_var3  {var3 inside {[0:4096], [8192:16384], 32278}; } // set membership type constraint
  constraint constr_flag {  conditional constraint
    flag == 1 -> var3 > 1024;
    flag == 0 -> var3 < 512;
  }
  constraint iter1 {      // iterative constraint
    foreach (arr_var4[i])
      (i < 100) arr_var4[i] <= i-1;

    foreach (arr_var4[i])
      (i >= 100) arr_var4[i] <= i+1;     

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
  constraint constr_ranges {var1 inside {2,4,6,8};}             // adding new constraint of type set membership for var1
  constraint constr_dist_var3 {var3 dist {0:= 30, [2:2024]:=75, [3000:4000]:/500 }}  // override constr_range_var3 with weighted distribution. 0 has weight 30. 2:2024 each get weight of 200. 3000:4000 each get weight of  500/1000 = 1/2
  constraint constr_flag {                                      // override constr_flag with conditional constraint
    if(flag == 1)  var3 >2048;
    else           var3 < 768;
  }
endclass: randclass4

randclass4 rc4obj1 = new();
rc4obj1.randomize();

// Just like rand_mode() virtual task method that allows enabling/disabling
// randomization for individual class instance properties or for entire class
// instance, the constraint blocks inside a class also have corresponding
// constraint_mode() virtual task method which allows to turn ON/OFF individual
// constraint blocks for class instance or for entire class instance
randclass4 rc4obj2 = new();
rc4obj2.constraint_mode(0); // disable all constraint blocks for this class instance
rc4obj2.constr_odd_var2.constraint_mode(1);// turn on constr_odd_var2 constraint block only
rd_constr_flag = rc4obj2.constr_flag.constraint_mode(); // read constraint constraint_mode into rd_constr_flag variable
rc4obj2.randomize(); // randomization happens with only constraint constr_odd_var2 turned on and rest constrained turned off

// Randomization and Constraint application order
// 1. All randc properties randomized together in parallel
// 2. All integer type rand properties randomized in order defined using
//    solve [rand_prop_before] before [rand_prop_after]
// 3. All rand properties without any defined order are randomized together in parallel
// 4. Constraints are applied to check if solution is compliant otherwise process is repeated until
//    either a solution is found or all randomization space is exhausted in which case randomization fails 
//    with rodomize function returning 0 and simulator reports that constraint couldnt be met
// Randomization of properties of one only rand type when happening in parallel can lead 
// to problems and its is possible to control order of randomization of only rand type of properties
// unlike rand properties which can be ordered, rand properties cannot be ordered.
// Also, only rand integer typer properties can be ordered. Also when ordering randomization,
// once should be careful not to create circular dependencies
class randclass5;
  rand int var1;
  rand int var2;
  logic var3;

  constraint constr1 {
    /*  solve order constraints  */
    solve var2 before var1;
    solve var3 before var1;

    /*  rand variable constraints  */
    if(var3 == 2'b01)   var1 > (var2+10);
    else                var1 < (var2-100);

    var2 inside {[3:350], [1070:3000]};
    var3 inside {2'b00, 2'b01 2'b10}
  }
   
endclass: randclass5
randclass5 rc5obj1 = new();
rc5obj1.randomize();

// pre-randomize and post-randomize are two special callback functions
// which dont return a value and which take no arguments such that 
// when explicitly defined by user, they are automatically called by 
// the in-built virtual function randomize before and after randomization
// generally pre-randomize is called to prepare and check something required during
// randomization and post-randomization is done to check if randomization
// results are consistent with expectations and wouldnt break stuff ahead

class randclass6;
  rand bit [1:0] var1;
  randc logic var2;
  int var3;

  bit check;

  constraint constr {
    var1 inside {2'b01, 2'b11} ;
    if(var3 % 2 == 0) var2 = 0'b1;
    else              var2 = 1'b1;
  }

  function void pre_randomization();
    var3 = 18;
  endfunction

  function void post_randomization();
    check = var2 & (~|var2);
  endfunction

endclass: randclass6

randclass6 rc6obj1 = new();
rc6obj1.randomize();  // automatically calls pre_randomization before randomization and post_randomization after randomization

// As each class instance has its own Random Number Generator associated with it which
// is seeded by simulator based on hierarhcy and seed of the parent artifact.
// One can also seed class instances manually using call to srandom(seed_value) either
// called in the constructor or called manually anypoint of time later by calling
// built-in instance method srandom(seed_value)
class randclass7;
  function new(int seed_value=10);
    srandom(seed_value);
  endfunction: name
  
endclass: randclass7

randclass7 rc7obj1 = new(13); // passing seed value during instantiation
rc7obj1.randomize();  // randomization based on passed seed value
rc7obj1.srandom(11);  // manually seeding the RNG for class instance with user defined seed

