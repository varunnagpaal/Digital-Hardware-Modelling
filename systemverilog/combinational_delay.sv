
// Interface
module combinational_delay (
    input logic Clk_CI,     // Clock;
    input logic Clk_En,     // Clock Enable
    input logic Rst_RBI,    // Asynchronous reset active low
    input logic [3:0] Data_DI;
    output logic Qq_DO
);

// Architecture
logic Xorred_D;

    // 4 input XOR gate with 10ns propogation delay
    assign #10ns Xorred_D =  Data_DI[0] ^ Data_DI[1] ^ Data_DI[2] ^ Data_DI[3];

    always_ff @(posedge Clk_CI or negedge Rst_RBI) begin : proc_
        if(~Rst_RBI) begin
            Qq_DO <= '0;
        end else begin
            Qq_DO <= Xorred_D;
        end
    end


endmodule
