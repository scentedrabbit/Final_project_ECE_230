module clock_div(
    input clock,
    input reset,
    output reg Q,
    output NotQ
);
    wire D;
    assign NotQ = ~Q;
    assign D = NotQ;
    
    always @(posedge reset, posedge clock) begin
        if (reset) begin
            Q <= 0;
        end else if (clock) begin
            Q <= D;
        end
    end
endmodule



module clock_divs(
    input clock,
    output div_clk,
    input reset
);

    genvar i;
    wire [17:0] clocks;
    assign clocks[0] = clock;
    assign div_clk = clocks[17];
    generate
    for (i = 1; i <= 17; i = i + 1) begin
        clock_div(
            .reset(reset),
            .clock(clocks[i - 1]),
            .Q(clocks[i])
        );
    end
    endgenerate
endmodule

