module top(
    input [15:0] sw, //input bits
    input clk,
    input btnC,
    input btnU,
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
    wire [7:0] nextA;
    wire [7:0] nextB;
    wire [7:0] nextY;
    
    assign led[15:8] = A;
    assign led[7:0] = B;
    
    always @(posedge btnC or posedge btnU) begin
        if (btnU) begin
            A <= 8'b0;
            B <= 8'b0;
            Y <= 8'b0;
        end else begin
            A <= nextA;
            B <= nextB;
            Y <= nextY;
        end
    end
    
    clock_divs clock(
        .clock(clk),
        .reset(btnU),
        .div_clk(div_clock)
    );
    
    seven_seg_scanner scanner(
        .div_clock(div_clock),
        .reset(btnU),
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
        .data(nextY)
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
        .data(nextA)
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
        .data(nextB)
    );
    
    ADD add(
        .A(A),
        .B(B),
        .Y(AplusB)
    );
    
    SUB sub(
        .A(A),
        .B(B),
        .Y(AminusB)
    );
    
    SHL shl(
        .A(A),
        .Y(SHL)
    );
    
    SHR shr(
        .A(A),
        .Y(SHR)
    );
    
    CMP cmp(
        .A(A),
        .B(B),
        .Y(CMP)
    );
    
    AND and1(
        .A(A),
        .B(B),
        .Y(AND)
    );
    
    OR or1(
        .A(A),
        .B(B),
        .Y(OR)
    );

    XOR xor1(
        .A(A),
        .B(B),
        .Y(XOR)
    );
    
    NAND nand1(
        .A(A),
        .B(B),
        .Y(NAND)
    );
    
    NOR nor1(
        .A(A),
        .B(B),
        .Y(NOR)
    );
    
    XNOR xnor1(
        .A(A),
        .B(B),
        .Y(XNOR)
    );
    
    INV inv(
        .A(A),
        .Y(INV)
    );
    
    NEG neg(
        .A(A),
        .Y(NEG)
    );
    
endmodule
