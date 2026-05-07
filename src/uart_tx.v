module uart_tx (
    input clk,
    input rst,

    input tx_start,
    input [7:0] tx_data,
    input baud_tick,

    output reg tx_serial,
    output reg tx_done
);

    localparam IDLE       = 3'b000;
    localparam START_BIT  = 3'b001;
    localparam DATA_BITS  = 3'b010;
    localparam STOP_BIT   = 3'b011;
    localparam CLEANUP    = 3'b100;

    reg [2:0] state;
    reg [2:0] bit_index;
    reg [7:0] tx_data_reg;

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            bit_index <= 0;
            tx_data_reg <= 0;
            tx_serial <= 1'b1;
            tx_done <= 1'b0;
        end else begin
            tx_done <= 1'b0;

            case (state)
                IDLE: begin
                    tx_serial <= 1'b1;
                    if (tx_start) begin
                        tx_data_reg <= tx_data;
                        bit_index <= 0;
                        state <= START_BIT;
                    end
                end

                START_BIT: begin
                    tx_serial <= 1'b0;
                    if (baud_tick) begin
                        state <= DATA_BITS;
                    end
                end

                DATA_BITS: begin
                    tx_serial <= tx_data_reg[bit_index];
                    if (baud_tick) begin
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            bit_index <= 0;
                            state <= STOP_BIT;
                        end
                    end
                end

                STOP_BIT: begin
                    tx_serial <= 1'b1;
                    if (baud_tick) begin
                        state <= CLEANUP;
                    end
                end

                CLEANUP: begin
                    tx_done <= 1'b1;
                    state <= IDLE;
                end

                default: begin
                    state <= IDLE;
                    tx_serial <= 1'b1;
                end
            endcase
        end
    end
endmodule
