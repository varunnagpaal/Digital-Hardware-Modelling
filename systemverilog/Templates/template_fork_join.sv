/* Verilog : Parallel Fork-Join is little bit like thread barrier */

fork
  a;b;c; // Parallel block: statement blocks a, b and c are spawned and excute in parallel
join
         // Execution control reaches here only after all forked statement blocks a, b and c executing in parallel have completed

/* Note
  - Each statement block inside a forked parallel block 
    - start executing simultaneously but execute in any unpredictable order
    - is subjected to its own specified timing controls and completes accordingly
    - execution order of statement blocks depends upon simulator and unknown
      - can cause race condition
      - can cause deadlock if one of the statement block never returns(joins)
  - can be a procedural statement of any complexity such as 
    task call, loops, assignment statements, further nested sequential or fork-joins(parallel) blocks etc.

*/
     module test_tb     
      reg [7:0] data;
      
      initial begin      
          fork
                data = 8'hef; // apply stimulus at t = 0s
            #10 data = 8'h00; // apply stimulus at t = 10
            #20 data = 8'h0F; // apply stimulus at t = 20

            // two repeat loops apply stimulus in parallel at different inerval sets
            // very difficult to do this with sequential statements nstead of paralle fork-join
            #20 repeat(8)           
                #10 data = data+1;  // apply stimulus at t = 30,40,50,60,70,80,90,100
            #25 repeat (8)
                #10 data = data+2; // apply stimulus at t = 25,35,45,55,65,75,85,95
          join          
      end
       
     endmodule: test_tb


  /* SystemVerilog enhancements to parallel fork-join 
     Two new fork-join variants
     - join_any
        - proceeeds (completes the fork) as soon as any of the statement blocks complete while other blocks are running
        
     - join_none
        - proceeeds (completes the fork) immediately while statement blocks are still running
        - a bit like non=blocking or async spawn
      
      SV further provides process control constructs to control forked statement blocks outside the forked statement
      - disable fork
          - terminates all parallel forked processes which are still active (ones which have not completed)
          - used after join_any
      - wait fork
        - waits until ALL parallel forked processes complete execution.
        - affects all forks in current scope
  */
      /* Example 1 */
        fork
          a;b;c;
        join_any
        // Assume a has finished while b,c are active when control reacher here
        // Upon execution of disable fork here,  b and c will be terminated 
        // and execution will go to next statement
        disable fork; 
        ....


      /* Example 2 */
        fork
          a;b;c;
        join_any // as soon as one of a,b or c finish, execution goes to next line


        fork
          d;
        join_none; // execution control will not wait for d to complete and continue execution on next line

        e;          // e may execute while d is executing or after d finished execution

        wait fork;  // after e finishes, wait for all previous forks (2 here) to complete
        f;