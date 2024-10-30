 module ADD(
    input [7:0] A, 
    input [7:0] B,
    output [7:0] Y,
    output Cout
);
    ripple_full_adder add(
        .A(A),
        .B(B),
        .Cin(1'b0),
        .Y(Y),
        .Cout(Cout)
    );

endmodule

module SUB(
    input [7:0] A,
    input [7:0] B,
    output [7:0] Y,
    output Cout
);
    ripple_full_adder sub(
        .A(A),
        .B(~B),
        .Cin(1'b1),
        .Y(Y),
        .Cout(Cout)
    );
endmodule

module SHL(
    input [7:0] A,
    output [7:0] Y,
);
    assign Y = A << 1;
endmodule

module SHR(
    input [7:0] A,
    output [7:0] Y,
);
    assign Y = A >> 1;
endmodule

module CMP(
    input [7:0] A,
    input [7:0] B,
    output [7:0] Y
);
    assign Y = (A == B) ? 8'b00000000 :    // Y = 0 if A == B
               (A > B)  ? 8'b00000001 :    // Y = 1 if A > B
                           8'b11111111; 
endmodule

module AND(
    input [7:0] A, 
    input [7:0] B,
    output [7:0] Y
);
    assign Y = A & B;
endmodule

module OR(
    input [7:0] A, 
    input [7:0] B,
    output [7:0] Y
);
    assign Y = A | B;
endmodule

module XOR(
    input [7:0] A, 
    input [7:0] B,
    output [7:0] Y
);
    assign Y = A ^ B;
endmodule

module NAND(
    input [7:0] A, 
    input [7:0] B,
    output [7:0] Y
);
    assign Y = ~(A & B);
endmodule

module NOR(
    input [7:0] A, 
    input [7:0] B,
    output [7:0] Y
);
    assign Y = ~(A | B);
endmodule

module XNOR(
    input [7:0] A, 
    input [7:0] B,
    output [7:0] Y
);
    assign Y = ~(A ^ B);
endmodule

module INV(
    input [7:0] A,
    output [7:0] Y
);
    assign Y = ~A;
endmodule

module NEG(
    input [7:0] A,
    input [7:0] B,
    output [7:0] Y,
    output Cout
);
    ripple_full_adder sub(
        .A(8'b0),
        .B(~A),
        .Cin(1'b1),
        .Y(Y),
        .Cout(Cout)
    );
endmodule

module STO(
    input [7:0] Y,
    output [7:0] Y_out
);
    assign Y_out = Y;
endmodule

module SWP(
    input [7:0] A_in,
    input [7:0] B_in,
    output [7:0] A_out,
    output [7:0] B_out
    );
    assign A_out = B_in;
    assign B_out = A_in;
endmodule

module LOAD(
    input [7:0] A,
    output [7:0] Y
);
    assign Y = A;
endmodule




