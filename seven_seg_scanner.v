module seven_seg_scanner(
    input div_clock,
    input reset,
    output reg [3:0] anode
);

    reg [1:0] sel;
    
    always @(posedge div_clock or posedge reset) begin
        if (reset) begin
            sel <= 2'b00;
        end else begin
            sel <= sel + 1'b1;
        end
    end

    // The reset line should set things back to segment 0
    always @(*) begin
        case (sel)
            2'b00: anode <= 4'b1110;
            2'b01: anode <= 4'b1101;
            2'b10: anode <= 4'b1011;
            2'b11: anode <= 4'b0111;
        endcase
    end
endmodule