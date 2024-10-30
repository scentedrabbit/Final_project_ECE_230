module full_adder(
    input A, B, Cin,
    output Y, Cout
);
    wire Sum;
    assign Sum = A ^ B;
    assign Y = Sum ^ Cin;
    assign Cout = (Sum & Cin) | (A & B);
    
endmodule

module ripple_full_adder(
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] Y,
    output Cout
);
    wire [8:0] carry;
    assign carry[0] = Cin;
    
    genvar i;
    generate
        for(i = 0; i < 8; i = i + 1) begin
            full_adder fa(
                .A(A[i]),
                .B(B[i]),
                .Cin(carry[i]),
                .Y(Y[i]),
                .Cout(carry[i+1])
            );
        end
    endgenerate
    
    assign Cout = carry[8];
endmodule
