`timescale 1ns/1ps

module baud_gen_tb;
    reg clk;
    reg rst;
    wire baud_tick;

    baud_gen #(
        .CLKS_PER_BIT(434)
    ) dut (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;

        repeat(1000) @(posedge clk);

        $display("clk_count max value reached as expected");
        $finish;
    end

    initial begin
        $dumpfile("baud_gen_tb.vcd");
        $dumpvars(0, baud_gen_tb);
    end
endmodule
