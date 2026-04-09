// Not properly set up for Vivado use *technically but its basically all there im referring to timescale im probably including a manual clock instatiation, since theres a few real world issues when making an fpga

module manual_bidirectional_shifter (
    input wire [3:0] sw,    //  4 slide switches
    output reg [3:0] led    //  4 output LEDs
);

    // Give the switches readable names
    wire data_stream  = sw[0];
    wire shift_right  = sw[1];
    wire manual_trigger = sw[2]; // we are manually triggering our bit signals instead of using a clock thatll be too fast
    wire reset        = sw[3];

    // The entire block ONLY wakes up when Switch 2 goes UP, or Switch 3 goes UP
    always @(posedge manual_trigger or posedge reset) begin
        
        if (reset) begin
            // If Switch 3 was flipped, wipe the LEDs
            led <= 4'b0000;
        end 
        else begin
            // Otherwise, it was Switch 2 that was flipped! Do the shift.
            if (shift_right) begin
                // Shift Right: Insert data at the top (bit 3)
                led <= {data_stream, led[3:1]};
            end else begin
                // Shift Left: Insert data at the bottom (bit 0)
                led <= {led[2:0], data_stream};
            end
        end
        
    end

endmodule
