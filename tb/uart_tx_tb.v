`timescale 1ns/1ps

module uart_tx_tb;
    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;
    wire baud_tick;
    wire tx_serial;
    wire tx_done;

    baud_gen #(
        .CLKS_PER_BIT(8)
    ) baud_gen_inst (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    uart_tx dut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .baud_tick(baud_tick),
        .tx_serial(tx_serial),
        .tx_done(tx_done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tx_start = 0;
        tx_data = 8'h00;

        #10 rst = 0;
        #20;

        tx_data = 8'hAA;
        tx_start = 1;
        #10 tx_start = 0;

        wait (tx_done == 1);
        #50;

        tx_data = 8'h55;
        tx_start = 1;
        #10 tx_start = 0;

        wait (tx_done == 1);
        #50;

        $display("Test complete");
        $finish;
    end

    initial begin
        $dumpfile("uart_tx_tb.vcd");
        $dumpvars(0, uart_tx_tb);
    end
endmodule
