'include "./constants.sv"
'include "./typdefs.sv"

package package_example;

  function color getColorCode( LED_COLOR color )
    // return 24-bit color code corresponding to the LED COLOR
  endfunction : getColorCode

  function color mixTwoColors( LED_COLOR color1, LED_COLOR color2 );
    // mix two colors and return the 24-bit color code of resultant color
  endfunction : color mixTwoColors
endpackage : package_example