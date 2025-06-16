module fsm(
    input   clk,
    input   rst_n,

    output reg wr_en,

    output [7:0] fifo_data,
    
    input [3:0] fifo_words
);

    reg [1:0] state, next_state;

    // Constantes para os estados
    parameter WRITING    = 2'd0;
    parameter WAIT_STOP  = 2'd1;
    parameter WAIT_DRAIN = 2'd2;

    assign fifo_data = 8'hAA; // Dados constantes

    // Lógica sequencial de estado
    always @(posedge clk) begin
        if (!rst_n)
            state <= WRITING;
        else
            state <= next_state;
    end

    // Lógica combinacional de transição de estados
    always @(*) begin
        case (state)
            WRITING: begin
                if (fifo_words >= 4'd5)
                    next_state = WAIT_STOP;
                else
                    next_state = WRITING;
            end

            WAIT_STOP: begin
                next_state = WAIT_DRAIN;
            end

            WAIT_DRAIN: begin
                if (fifo_words <= 4'd2)
                    next_state = WRITING;
                else
                    next_state = WAIT_DRAIN;
            end

            default: next_state = WRITING;
        endcase
    end

    // Lógica de saída
    always @(*) begin
        case (state)
            WRITING:    wr_en = 1'b1;
            default:    wr_en = 1'b0;
        endcase
    end
        
endmodule
