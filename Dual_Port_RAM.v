`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 13:54:46
// Design Name: 
// Module Name: Dual_Port_RAM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dual_port_ram (
    input wire clk,
    input wire [7:0] data_in_a, data_in_b,        // Data inputs for port A and port B
    input wire [5:0] addr_a, addr_b,              // Address inputs for port A and port B
    input wire we_a, we_b,                        // Write enable signals for port A and port B
    output reg [7:0] data_out_a, data_out_b       // Data outputs for port A and port B
);
    // Declare the RAM variable
    reg [7:0] ram [63:0];  // 8x64-bit RAM

    always @(posedge clk) begin
        if (we_a) begin
            ram[addr_a] <= data_in_a;
        end
        data_out_a <= ram[addr_a];

        if (we_b) begin
            ram[addr_b] <= data_in_b;
        end
        data_out_b <= ram[addr_b];
    end
endmodule

