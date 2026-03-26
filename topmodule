module ShiftRegister(
    input in,
    input reset,
    input clk,
    output reg [7:0] out
);
   always @(posedge clk) begin
    if (reset) begin
    out <= 8'b00000000; 
   end else begin
    out <= {out[6:0],in}; 
    end
   end
endmodule

