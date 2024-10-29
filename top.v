module top(
    input [3:0] sw, //sel
    input [15:8] sw, //input bits
    input clk,
    input btnC,
    output [15:0] led, // [15:8] display A value, [7:0] for display B value
    output [6:0] seg, //display segments 
    output [3:0] an //display anodes
    );
    
    wire div_clock;
    wire [15:8] A;
    wire [7:0] B;
    wire [7:0] AplusB;
    wire [7:0] AminusB;
    wire [7:0] SHL;
    wire [7:0] SHR;
    wire [7:0] CMP;
    wire [7:0] AND;
    wire [7:0] OR;
    wire [7:0] XOR;
    wire [7:0] NAND;
    wire [7:0] NOR;
    wire [7:0] XNOR;
    wire [7:0] INV;
    wire [7:0] NEG;
    
    assign A = led[15:8];
    assign B = led[7:0];
endmodule
