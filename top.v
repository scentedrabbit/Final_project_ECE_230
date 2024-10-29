module top
#(
    parameter BIT_COUNT = 17 // Use this when passing in to your clock div!
    // The test bench will set it appropriately
)
(
    input [7:0] sw, // A and B
    input clk, // 100 MHz board clock
    input btnC, // Reset
    output [3:0] an, // 7seg anodes
    output [6:0] seg // 7seg segments
);
    wire [3:0] A; 
    wire [3:0] B; 
    wire [3:0] AplusB; 
    wire [3:0] AminusB;
    wire div_clock;
    
    assign A = sw[3:0];
    assign B = sw[7:4]; 
    // Instantiate the clock divider...
    clock_divs clock(
        .clock(clk),
        .reset(btnC),
        .div_clk(div_clock)
    );
    // ... wire it up to the scanner
    seven_seg_scanner scanner(
        .div_clock(div_clock),
        .reset(btnC),
        .anode(an)
    );
    // ... wire the scanner to the decoder
    seven_seg_decoder decoder(
        .A(A),
        .B(B),
        .AplusB(AplusB),
        .AminusB(AminusB),
        .anode(an),
        .segs(seg)
    );
    // Wire up the math block into the decoder
    math_block math(
        .A(A),
        .B(B),
        .AplusB(AplusB),
        .AminusB(AminusB)
    );
    // Do not forget to wire up resets!!
endmodule