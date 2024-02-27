/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Instantiate the Johnson counter with adaptations
johnson johnson_counter(
    .clk(clk),
    .r(ui_in[0]), // Assuming ui_in[0] is used as reset for the example
    .out(uo_out)  // Mapping Johnson counter output to uo_out
);

// Assuming the Johnson counter doesn't need to read inputs or control IOs dynamically
assign uio_out = 8'bz; // High impedance as we don't use these in this example
assign uio_oe = 8'b0;  // Disable output (set as input) as we don't use these

endmodule

module johnson (clk, r, out);
    parameter size=7;
    input clk;
    input r;
    output reg [0:size] out;

    always @ (posedge clk or posedge r) begin
        if (r)
            out = 8'b0000_0000;
        else
            out = {~out[size], out[0:size-1]};
    end
endmodule

  

endmodule
