// okay this is not ready for Vivado but were using EDA playground tihs time around sooo it dont matter too much (yet) but thats when next week's final workshop comes in.
module THEUniversalShiftReg (
    input wire clk,
    input wire clr,          // This is our reset butotn im just following that godly diagram 
    input wire [1:0] mode,   // 2-bit switches (S1, S0)
    input wire [1:0] para_in,// Parallel inputs (I1, I0)
    input wire sr_in,        // Serial Right In (enters from the left)
    input wire sl_in,        // Serial Left In (enters from the right)
   output reg [1:0] out       // The 2 output LEDs (q[1] is Left, q[0] is Right)
);
    // This block triggers every time the clock ticks OR the clear button is pressed
    always @(posedge clk or posedge clr) begin
        
        if (clr) begin
            out <= 2'b00; // If Clr is pressed, wipe the register to 00
            
        end else begin
            // If Clear is NOT pressed, let the MUX do its job based on a NEW thing I havnt shown fully
          // CASE statements, because we are working with a Multiplexer we will be using behavoiral code
          // as shown through the non-blocking assignments <= however, were now being shown through the specifics 
          // the specifics of these 2 bit cases , 00 01 10 and 11 THAT is our switches, S, we called it mode,
          // it will use the same idea of code for the concatnation from sr_in as are larger vlaue and the positive bit 1 in, due to
          // how we set where our inputs are coming from!, 
            case (mode)
                2'b00: out <= out;                       // MODE 0: HOLD
                2'b01: out <= {sr_in, q[1]};           // MODE 1: SHIFT RIGHT
                2'b10: out <= {q[0], sl_in};           // MODE 2: SHIFT LEFT
                2'b11: out <= para_in;                 // MODE 3: PARALLEL LOAD
            endcase
          // you can easily increase this code yourself using the SIPO shift register by going "oh we need 8 bits" "let me change the inputs and outputs [#:#] bit width and
          // change the input lenght within the values, it would change syntax a little but its practically the same. 
          // this is how we get a simple universal shift register done!!!!
        end
    end

endmodule
