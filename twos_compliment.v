module twos_complement(
 input[7:0] A,
 output[7:0] Y
 );
    
    wire c0,c1,c2,c3,c4,c5,c6,c7;

    // First addition
    full_adder lsb1_inter(
        .A(~A[0]),
        .B(1'b1),
        .Y(Y[0]),
        .Cin(1'b0), // Fix to zero
        .Cout(c0)
    );
    
    full_adder lsb2_inter(
        .A(~A[1]),
        .B(1'b0),
        .Y(Y[1]),
        .Cin(c0),
        .Cout(c1)
    );
    
        full_adder msb1_inter(
        .A(~A[2]),
        .B(1'b0),
        .Y(Y[2]),
        .Cin(c1),
        .Cout(c2)
    );
    
    full_adder msb2_inter(
        .A(~A[3]),
        .B(1'b0),
        .Y(Y[3]),
        .Cin(c2),
        .Cout(c3)
    );

    // Second addition
    full_adder lsb_3(
        .A(~A[4]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[4]), // This is now the real summation
        .Cin(c3), // Fix to zero
        .Cout(c4) // We still need to carry to second
        // bit of second addition
    );
    
    full_adder lsb_4(
        .A(~A[5]),
        .B(1'b0),
        .Y(Y[5]),
        .Cin(c4),
        .Cout(c5)
    );
    
    full_adder msb_3(
        .A(~A[6]), // Adding LSB of (A + B)
        .B(1'b0), // We are adding 0, with the optional carry:
        .Y(Y[6]), // This is now the real summation
        .Cin(c5),
        .Cout(c6) 
    );
    
    full_adder msb_4(
        .A(~A[7]),
        .B(1'b0),
        .Y(Y[7]),
        .Cin(c6),
        .Cout(c7)
    );

endmodule