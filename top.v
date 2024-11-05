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
    reg [7:0] Y;
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
    
    always @(posedge clk or posedge btnC) begin
        if (btnC) begin
            A <= 8'b0;
            B <= 8'b0;
            Y <= 8'b0;
        end
    end
    
    clock_divs clock(
        .clock(clk),
        .reset(btnC),
        .div_clk(div_clock)
    );
    
    seven_seg_scanner scanner(
        .div_clock(div_clock),
        .reset(btnC),
        .anode(an)
    );
    
    seven_seg_decoder decoder(
        .A(A),
        .B(B),
        .AplusB(AplusB),
        .AminusB(AminusB),
        .anode(an),
        .segs(seg)
    );
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
        //.SWP
        .LOAD(A),
        .data(Y)
        
    );
    
    ADD add(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    SUB sub(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    SHL shl(
        .A(A),
        .Y(Y)
    );
    
    SHR shr(
        .A(A),
        .Y(Y)
    );
    
    CMP cmp(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    AND and1(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    OR or1(
        .A(A),
        .B(B),
        .Y(Y)
    );

    XOR xor1(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    NAND nand1(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    NOR nor1(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    XNOR xnor1(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    INV inv(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    NEG neg(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    STO sto(
        .Y(Y),
        .Y_out(A)
    );
    
    SWP swp(
        .A(A),
        .B(B),
        .Y(Y)
    );
    
    LOAD load(
        .A(A),
        .Y(A)
    );
endmodule
