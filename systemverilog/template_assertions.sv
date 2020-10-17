/* Immediate Assertion
  - ignored by synthesis tool
  - spans only single clock cycle
  - optionally contains an action block
  - contains a logical expression which returns value 0,1,Z or X when assertion is evaluated
    - pass if evaluated to 1
    - fail if evluated to 0, Z, X
  - in case of failure, an assertion reports with an error message with following info:
    - severity level
      - default severity level is $error.
      - other severity levels
        - $info, $warning
        - $fatal: terminates simulation
    - file name and line number
    - simulation time at which assertion failed
    - label if provided for assertion and scope of assertion
  - recommended to use meaningful labels for assertion as label is used to understand failure 
    reports, code, and tracking assertions during debugging
    <optional_label>: assert(<logical expression>);

    Action block
    - behavior of an assertion upon pass and failure can be customized through Action Blocks
    - action block has optional if/esle blocks which tell what to do when assertion passes or fails
      - optional if(implicit) block following the assert statement and
      - optional else(explicit) block
    - When printing messages inside if block using display function, use %m format specifier to access assertion label
    - %m not required in failure message as label is always included with failure messages
    - common to omit if block and only have else block
    - ignored by synthesis tool and action block can include only code for verification
    - only action blocks allow changing severity levels in form of system tasks which 
      display severity level with a user provided message same as $display task
        - $info, $warning
        - $error: default, reports error message and returns non-zero error code
        - $fatal: terminates simulation
        - when a severity level system task is called inside else block, 
          - first the standard error message is printed 
          - and then the explicitly indicated severity level labelled message is printed
*/

/* Example 1: Simple immediate assertion */
  //  Module: test
  module test

    always_ff @(posedge clk) begin: checkassert
      A1: assert( ~(rd_en) || wr_en );
    end: checkassert
  
  endmodule: test

/* Example 2: Assertion with an Action block having 
              optional if(implicit) and
              optional else(blocks) */
  //  Module: test
  module test

    always_ff @(posedge clk) begin: checkassert
      A1: assert( ~(rd_en) || wr_en );
            // implicit pass block. usually omitted
            $display("%m: success");  // %m required in implicit if block to label the message
          else //explicit fail block in terms of else            
            $fatal("exit test");      // first print default error message and print this fatal message and terminates simulation
            error_cnt++;

      A2: assert ( valid_in && ready_out );
          else $warning("either invaid input data or module not ready");// first print default error message and then print this warning

    end: checkassert
  
  endmodule: test


/* Concurrent Assertions (TODO) */