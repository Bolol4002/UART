module baud_gen #(
    parameter CLKS_PER_BIT = 434
)(
    input clk,
    input rst,

    output reg baud_tick
);
    reg [15:0] clk_count;

    always @(posedge clk) begin
        if (rst) begin
            clk_count <= 0;
            baud_tick <= 0;
        end else begin
            if (clk_count == CLKS_PER_BIT - 1) begin
                clk_count <= 0;
                baud_tick <= 1;
            end else begin
                clk_count <= clk_count + 1;
                baud_tick <= 0;
            end
        end
    end
endmodule
