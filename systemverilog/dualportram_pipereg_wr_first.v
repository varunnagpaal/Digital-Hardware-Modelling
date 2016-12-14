//--------------------------------------Interface----------------------------//
module ram_2port_pipe(
    input clk,
    input wr,
    input [9:0] raddr,
    input [17:0] din,
    input [9:0] waddr,
    output [17:0] dout1
    );
//---------------------------------End Interface-----------------------------//

//----------------------------------Architecture-----------------------------//
reg [9:0] raddr_reg;
reg [17:0] mem [0:1023];
reg [17:0] dout, dout1;
//---------------------------------End Architecture--------------------------//

//--------------------------------------Body---------------------------------//
always@(posedge clk)
begin
    raddr_reg <= raddr;
    dout <= mem[raddr_reg];
    if(wr)
        mem[waddr] <= din;
end

always @(posedge clk)
begin
    dout1 <= dout;
end
//-----------------------------------End Body -------------------------------//

endmodule
