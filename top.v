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
    reg [7:0] A;
    reg [7:0] B;
    wire [7:0] Y;
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
    
  
   
    
    
    assign led[15:8] = A;
    assign led[7:0] = B;
    
    
     multiplexer mux(
        .sel(sw[3:0]),
        .ADD(AplusB),
        .SUB(AminusB),
        .SHL(SHL),
        .SHR(SHR),
        .CMP(CMP),
        .AND(AND),
        .OR(OR),
        .XOR(XOR),
        .NAND(NAND),
        .NOR(NOR),
        .XNOR(XNOR),
        .INV(INV),
        .NEG(NEG),
        .STO(Y),
        //.SWP,
        .LOAD(A),
        .data(Y)
        
    );
    
endmodule
