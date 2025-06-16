module fsm(
    input   clk,
    input   rst_n,

    output reg wr_en,

    output [7:0] fifo_data,
    
    input [3:0] fifo_words
);

    reg [1:0] state, next_state;

    // constantes para os estados
    parameter WRITING    = 2'd0;
    parameter WAIT_STOP  = 2'd1;
    parameter WAIT_DRAIN = 2'd2;

    assign fifo_data = 8'hAA; // Dados constantes

    // lógica sequencial de estado
    always @(posedge clk) begin
        state <= (!rst_n) ? WRITING : next_state;
    end

    // lógica combinacional de transição de estados
    always @(*) begin
        case (state)
            WRITING: next_state <= (fifo_words >= 4'd5) ? WAIT_STOP : WRITING;
            WAIT_STOP: next_state <= WAIT_DRAIN;
            WAIT_DRAIN: next_state <= (fifo_words <= 4'd2) ? WRITING : WAIT_DRAIN;
            default: next_state = WRITING;
        endcase
    end

    // lógica de saída
    always @(*) begin
        case (state)
            WRITING: wr_en = 1'b1;
            default: wr_en = 1'b0;
        endcase
    end
endmodule
