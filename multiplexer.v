module multiplexer(
    input [7:0] ADD, SUB, SHL, SHR, CMP, AND, OR, XOR, NAND, NOR, XNOR, INV, NEG, STO, SWP, LOAD,
    input [3:0] sel,
    output reg [7:0] data
    );
    
    always @(*) begin
        case (sel)
        //arithmetic operations
        4'b0000: data <= ADD;
        4'b0001: data <= SUB;
        4'b0010: data <= SHL;
        4'b0011: data <= SHR;
        4'b0100: data <= CMP;
        //bitwise operations
        4'b0101: data <= AND;
        4'b0110: data <= OR;
        4'b0111: data <= XOR;
        4'b1000: data <= NAND;
        4'b1001: data <= NOR;
        4'b1010: data <= XNOR;
        4'b1011: data <= INV;
        //using two compliments to work with neg numbers in full adder
        4'b1100: data <= NEG;
        //Storing, loading, and swapping data
        4'b1101: data <= STO;
        4'b1110: data <= SWP;
        4'b1111: data <= LOAD;
        endcase
    end
    
endmodule