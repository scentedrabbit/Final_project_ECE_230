module top(
    input [15:0] sw, //input bits
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
        .operation(sw[3:0]),
        .zero(4'b0),
        .upperY(Y[7:4]),
        .lowerY(Y[3:0]),
        .anode(an),
        .segs(seg)
    );
     multiplexer mux_y(
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
        .SWP(Y),
        .LOAD(Y),
        .data(Y)
    );
    
    multiplexer mux_A(
        .sel(sw[3:0]),
        .ADD(A),
        .SUB(A),
        .SHL(A),
        .SHR(A),
        .CMP(A),
        .AND(A),
        .OR(A),
        .XOR(A),
        .NAND(A),
        .NOR(A),
        .XNOR(A),
        .INV(A),
        .NEG(A),
        .STO(Y),
        .SWP(B),
        .LOAD(sw[15:8]),
        .data(A)
    );
    
    multiplexer mux_B(
        .sel(sw[3:0]),
        .ADD(B),
        .SUB(B),
        .SHL(B),
        .SHR(B),
        .CMP(B),
        .AND(B),
        .OR(B),
        .XOR(B),
        .NAND(B),
        .NOR(B),
        .XNOR(B),
        .INV(B),
        .NEG(B),
        .STO(B),
        .SWP(A),
        .LOAD(B),
        .data(B)
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
    
endmodule
