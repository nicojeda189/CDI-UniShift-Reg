//m5_makerchip_module   // We will need to change this to Test_bench (); and we would need timescale but we can worry about that later.
   Test_bench ();
    reg  in;
    wire [7:0] out;
    reg  [4:0] cycle; // Our way to continue a count in the Shift Register
    ShiftRegister TestBench_DUT (
        .clk(clk),    
        .reset(reset), 
        .in(in),
        .out(out)
    );
    always @(posedge clk) begin
        if (reset) begin
            cycle <= 0;
            in <= 0;
        end else begin
            cycle <= cycle + 1;      
            case (cycle) // we are feeding the data in one cycle case at a time. 
                5'd1: in <= 1;
                5'd2: in <= 1;
                5'd3: in <= 0;
                5'd4: in <= 1;
                default: in <= 0; 
            endcase
        end
    end
    assign passed = (cycle > 5'd12); // passed is a makerchip custom case
endmodule
