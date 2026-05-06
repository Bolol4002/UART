module uart_tx (
    input  wire       clk,
    input  wire       rst,

    input  wire       baud_tick,   // 1-cycle pulse per bit period
    input  wire       tx_start,
    input  wire [7:0] data_in,

    output reg        tx,
    output reg        busy
);

localparam IDLE  = 2'b00;
localparam START = 2'b01;
localparam DATA  = 2'b10;
localparam STOP  = 2'b11;

reg [1:0] state;
reg [2:0] bit_index;
reg [7:0] data_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        state     <= IDLE;
        tx        <= 1'b1;
        busy      <= 1'b0;
        bit_index <= 3'd0;
        data_reg  <= 8'd0;
    end else begin
        case (state)

        // ---------------- IDLE ----------------
        IDLE: begin
            tx        <= 1'b1;
            busy      <= 1'b0;
            bit_index <= 0;

            if (tx_start) begin
                busy     <= 1'b1;
                data_reg <= data_in;
                state    <= START;
            end
        end

        // ---------------- START ----------------
        START: begin
            tx <= 1'b0;

            if (baud_tick) begin
                state <= DATA;
            end
        end

        // ---------------- DATA ----------------
        DATA: begin
            tx <= data_reg[bit_index];

            if (baud_tick) begin
                if (bit_index < 7) begin
                    bit_index <= bit_index + 1;
                end else begin
                    bit_index <= 0;
                    state     <= STOP;
                end
            end
        end

        // ---------------- STOP ----------------
        STOP: begin
            tx <= 1'b1;

            if (baud_tick) begin
                state <= IDLE;
            end
        end

        default: state <= IDLE;

        endcase
    end
end

endmodule