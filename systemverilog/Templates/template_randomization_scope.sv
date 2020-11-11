////////////////////////////////////////////////////////////////////////////////
// Module Name  : template_scope_randomization
// File name    : template_scope_randomization.sv
// Description  : Template for SystemVerilog Scope Randomization facilties
// Type         : 
// Limitations  : None
// Model Styles : 
// Author       : Varun Nagpal
// Revision|Date: 0.1 | 16/10/2020
////////////////////////////////////////////////////////////////////////////////

/*  Scope Randomization
    - Refers to SV constraint randomization facilities applied to variable
      not inside classes but in other constructs such as modules
    - A pattern of random data is called as a Sequence.
      - SV doesn't support pure randomization as it is simply useless for
      purpose of verification as on different simulation runs, different
      generate different sequence which makes it impossible to do the 
      catchbug-debug-fix cycle
    - SV instead sypports pseudo-radom generation where we do generate
      sequence which are random patterns but we can deterministically 
      generate same sequence on multiple simulation runs through controlling
      starting value called Seed. To generate same sequence, one needs to
      use same seed. Using a different seed generates a different seqeunce.
      Basically first time a random value is passed to pseudo-random generator,
      it produces a random value. The newly generated random value becomes seed
      for next random number to be generated. So on and so worth, basically making
      sure for a given seed, same sequence is generated for every simulation run.
    - use randomize(variable1, variable2, ..) function defined in the in-built 
      package std to generate random values on variables variable1, variable2 etc. 
      It returns 1 on success. 0 otherwise. Randomization generally fails when specified
      constraints have a conflict which prevents randomizer to generate the random
      sequence. std::randomize() is fully-qualified way to call randomize function.
    - only variable/logic types can be randomized but not nets types.
    - only a single integer type variable can be randomized not real type variables or 
      a collection such as unpacked arrays(static/dynamic/queues). 
    - Random stability
      An issue even with pseudo-random generation is that code changes, code 
      rearrangement, conditional code calling can change the sequence generated
      by randomizer. Random stability refers ability to maintain stability of
      the repeatability of the sequence. SV solves this problem through what
      is known as Hierarchichal Seeding.
    - Hierarchichal Seeding
      - To maintain random stability, SV uses approach called as Hierarchichal Seeding.
        In this, SV moves from top to bottom of design hierarchy and assigns unique and independent
        Random Number Generator(RNG) instance to each of the design artifacts seeded with next random
        value of its topmost artifact.
      - RNG of top level artifacts such as package, module, interface are seeded by defualt with value 1.
        Can be changed during simulation run using commandline argument +svseed=<seed>
      - RNG of next design artifacts such as static thread, dynamic thread, class object is seeded with
        next random value produced by RNG of its parent design artifact. Say for example if RNG of top
        level module seeded with default value 1 produces sequence 1,5,2,11,9,17,18 then if there are declared 
        inside the module following 6 child artifacts in given order, then their individual RNGs are seeded
        with random numbers following seed 1 of the module RNG which is the sequence 5,2,11,9,17,18: 
          
          class instance o1   RNG seed 5
          class instance o2   RNG seed 2
          process p1          RNG seed 11
          process p2          RNG seed 9
          class instance o3   RNG seed 17
          process p3          RNG seed 18
          
      - Further to maintain random stability, we need to make sure RNG seed assignment remains stable
        which means any new child artifacts such as threads, processes, objects etc. must be added in
        code after the existing child artifacts. Otherwise if we insert new child artifacts in between
        existing child artifacts, we will change the RNG seed assignments of existing child artifacts
        as defined by the random sequence produced by parent artifact.
      - One can also manually set random seeds for child artifacts of type threads by making call
        to srandom method with manually defined seed
        - process::self.srandom(seedvalue);. 
          Note: always/initial create static processes. fork-join create dynamic processes.
        - This way we can freely add new processes, rearrange them in code, insert new processes
          with their explicit seeds defined anywhere among existing processes and donot have to 
          worry about breaking random stability.
        - also once a process is manually seeded, its random stability doesn't get affected by
          command-line option +svseed as a mnually seeded process will always geenrate same 
          random sequence.

      
      
      
    
*/

typedef enum logic [3:0] { ADDI, SUBI, MULI, DIVI, XORI, ANDI, NOTI, ORI, JMP, CALL, JGT, JLT, JGTE, JLTE, JE, JNE} tOpcode;
typedef enum logic [15:0] { REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7} tOpcode;

tOpcode opcode;
tRegister register;
logic [16:0] data; 
initial begin
  int ret;
  repeat(1024) begin
    ret = randomize(opcode, register, data); // generate random stimulus

    @(posedge clk);

    // generate constrained random stimulus with UNCONDITIONAL constraint expression defining
    // subset of values using relational constraint  using "with"
    ret = randomize(data) with {data>=15l data<=2000}; 
    ...
    // generate constrained random stimulus with UNCONDITIONAL constraint expression defining
    // subset of values using "with" alongwith "inside"
    ret = randomize(opcode) with {opcode inside {[MULI:XORI], JGTE, JLTE};}; 
    ...
    // generate random stimulus with UNCONDITIONAL constraint expression defining
    // some distribution using "with" alongwith "dist":
    //  reg0, reg1, reg2, reg3 each have weights 3
    //  reg4, reg5, reg, reg7 each have weights 1
    //  probability of each of reg0, reg1, reg2, reg3 is 3/(3*4+1*4) = 3/16
    //  probability of each of reg4, reg5, reg6, reg7 is 1/(3*4+1*4) = 1/16
    //  default weight is 1 if not specified
    ret = randomize(register) with {register dist {[REG0:REG3]:=3, [REG4:REG7]:=1};};

    // generate constrained random stimulus with CONDITIONAL constraint expression defining
    // subset of values using "with" alongwith implication operator ->
    ret = randomize(data) with {(someVar1 == value1) -> data > 255;
                                (someVar1 == value2) -> data < 128;};

    // generate constrained random stimulus with CONDITIONAL constraint expression defining
    // subset of values using "with" alongwith if-else
    ret = randomize(data) with {if(someVar1 == value1) data > 255; else
                                if(someVar1 == value2) data < 128;};                                
  end

  // using randcase with constant probability weights per statement block
  // default weight is 1 when unspecified
  // 0 weight indicates statement should never be executed.
  // only non-negative weights allowed. fractional and negative weights are not allowed
repeat(128) begin
    randcase
      10:   // execute statements in this case with probability = (10/10+20+5) = 10/35
      20:   // execute statements in this case with probability = = (20/10+20+5) = 20/35
      5:    // execute statements in this case with probability = = (5/10+20+5) = 5/35
    endcase
  end

  // using randcase with variable probability weight expressions(non-negative) per statement block
  // below x, y and z are some variables
  // weight expression must yield non-negative value
  repeat(128) begin
    randcase
      x+y+z:   // execute statements in this case with probability = (x+y+z)/(x+y+z+2x+3y+y+.5z)
      2x+3y:   // execute statements in this case with probability = (2x+3y)/(x+y+z+2x+3y+y+.5z)
      y+.5z:   // execute statements in this case with probability = (y+.5z)/(x+y+z+2x+3y+y+.5z)
    endcase
  end
end