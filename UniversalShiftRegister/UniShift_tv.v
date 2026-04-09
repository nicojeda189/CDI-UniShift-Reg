module tb_THEUniversalShiftReg;

    // 1. Declare inputs as 'reg' (registers hold values in testbenches)
    reg clk;
    reg clr;
    reg [1:0] mode;
    reg [1:0] para_in;
    reg sr_in;
    reg sl_in;

    // 2. Declare outputs as 'wire' (connects to the module's output)
    wire [1:0] out;

    // 3. Instantiate the module using your NEW name and NEW output variable
    THEUniversalShiftReg uut (
        .clk(clk),
        .clr(clr),
        .mode(mode),
        .para_in(para_in),
        .sr_in(sr_in),
        .sl_in(sl_in),
        .out(out)       // Updated from .q(q) to .out(out)
    );

    // 4. Generate a fake clock (Ticks every 5 nanoseconds)
    always #5 clk = ~clk;

    // 5. Run the actual test sequence
    initial begin
        // These two lines are REQUIRED in EDA Playground to see the waveforms!
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_THEUniversalShiftReg);

        // --- STEP 1: INITIALIZE & CLEAR ---
        clk = 0;
        clr = 1;              // Press the "Wipe Clean" button
        mode = 2'b00;
        para_in = 2'b00;
        sr_in = 0;
        sl_in = 0;
        
        #10 clr = 0;          // Release the clear button
        
        // --- STEP 2: TEST PARALLEL LOAD (Mode 11) ---
        // Let's instantly load a '1' into the left LED and a '0' into the right LED
        #10 mode = 2'b11; para_in = 2'b10;
        
        // --- STEP 3: TEST HOLD (Mode 00) ---
        // Prove that it remembers the '10' we just loaded
        #10 mode = 2'b00;
        
        // --- STEP 4: TEST SHIFT RIGHT (Mode 01) ---
        // Shift right, and push a new '1' in from the left side
        #10 mode = 2'b01; sr_in = 1; 
        // Wait another clock tick to shift right again
        #10 sr_in = 1;
        
        // --- STEP 5: TEST SHIFT LEFT (Mode 10) ---
        // Shift left, and push a new '0' in from the right side
        #10 mode = 2'b10; sl_in = 0;
        // Wait another clock tick to shift left again
        #10 sl_in = 0;

        // --- STEP 6: TEST CLEAR DURING OPERATION ---
        // Hit the clear button while it's running to prove it wipes to '00'
        #10 clr = 1;
        #10 clr = 0;

        // End the simulation
        #10 $finish;
    end

endmodule
