module fifo(
    input   clk,
    input   rst_n,

    // Write interface
    input   wr_en,
    input   [7:0] data_in,
    output  full,

    // Read interface
    input   rd_en,
    output  reg [7:0] data_out,
    output  empty,

    // status
    output reg [3:0] fifo_words  // Current number of elements
);

//insira seu código aqui

endmodule