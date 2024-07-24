`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.07.2024 14:45:00
// Design Name: 
// Module Name: RAM_tb
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


module dual_port_ram_tb;


    // Signals
    reg clk;
    reg [7:0] data_in_a, data_in_b;
    reg [5:0] addr_a, addr_b;
    reg we_a, we_b;
    wire [7:0] data_out_a, data_out_b;

    // Instantiate the dual-port RAM module
    dual_port_ram uut (
        .clk(clk),
        .data_in_a(data_in_a),
        .data_in_b(data_in_b),
        .addr_a(addr_a),
        .addr_b(addr_b),
        .we_a(we_a),
        .we_b(we_b),
        .data_out_a(data_out_a),
        .data_out_b(data_out_b)
    );

  // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;
  
   // Initial stimulus
    initial begin
        // Initialize signals
        data_in_a = 0;
        data_in_b = 0;
        addr_a = 0;
        addr_b = 0;
        we_a = 0;
        we_b = 0;

        // Test case 1: Write to Port A, Read from Port A
        #10;
        addr_a = 6'd5;
        data_in_a = 8'hFF;
        we_a = 1;
        #10; // Perform write operation
        we_a = 0;
        #10; // Read after write
        addr_a = 6'd5;
        #10;

        // Test case 2: Write to Port B, Read from Port B
        addr_b = 6'd10;
        data_in_b = 8'hAA;
        we_b = 1;
        #10; // Perform write operation
        we_b = 0;
        #10; // Read after write
        addr_b = 6'd10;
        #10;

        // Test case 3: Concurrent read and write on different ports
        addr_a = 6'd8;
        data_in_a = 8'h55;
        we_a = 1;   // Write to Port A
        addr_b = 6'd10;
        we_b = 0;   // Read from Port B
        #10;
        we_a = 0;
        #10;  // Perform operations
        addr_a = 6'd8;
        addr_b = 6'd10;
        #10;

        // Test case 4: Simultaneous Write to Both Ports
        addr_a = 6'd20;
        data_in_a = 8'hAB;
        we_a = 1;   // Write to Port A
        addr_b = 6'd25;
        data_in_b = 8'hCD;
        we_b = 1;   // Write to Port B
        #10;
        we_a = 0;
        we_b = 0;
        #10;  // Perform operations
        addr_a = 6'd20;
        addr_b = 6'd25;
        #10;

        // Test case 5: Simultaneous Read from Both Ports
        addr_a = 6'd20;
        addr_b = 6'd25;
        we_a = 0;
        we_b = 0;
        #10; // Read after write
        #10;

        // Test case 6: Read-Write Conflict
        addr_a = 6'd30;
        data_in_a = 8'hEF;
        we_a = 1;
        addr_b = 6'd30;
        we_b = 0;  // Read from Port B while writing to Port A
        #10;
        we_a = 0;
        we_b = 0;
        #10; // Perform operations

        // Add more test cases as needed

        $finish;
    end

endmodule