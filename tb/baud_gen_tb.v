`timescale 1ns/1ps

module baud_gen_tb;

    reg clk;
    reg rst;

    wire baud_tick;

    baud_gen #(
        .CLKS_PER_BIT(8)
    ) dut (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    // 10ns clock period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        #20;
        rst = 0;

        // Run long enough to observe multiple ticks
        #200;

        $finish;
    end

    // Monitor tick generation
    always @(posedge clk) begin
        if (baud_tick)
            $display("Tick generated at time = %0t", $time);
    end

    initial begin
        $dumpfile("baud_gen_tb.vcd");
        $dumpvars(0, baud_gen_tb);
    end

endmodule