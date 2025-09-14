`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2025 09:04:43 PM
// Design Name: 
// Module Name: testbench
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


module tb_caesar_cipher;

    parameter WORD_LENGTH = 1024;
    reg [WORD_LENGTH*8-1:0] word;
    reg [7:0] key;
    reg mode;
    wire [WORD_LENGTH*8-1:0] result;

    // Instantiate the caesar_cipher module
    caesar_cipher #(.WORD_LENGTH(WORD_LENGTH)) uut (
        .word(word),
        .key(key),
        .mode(mode),
        .result(result)
    );

    integer idx;

    initial begin
        // Initialize input
        key = 8'd3; // Shift by 3 as typical Caesar cipher
        mode = 1'b1; // Encrypt

        // Fill word with some test data (first 16 characters for demo, rest zero)
        word = {WORD_LENGTH*8{1'b0}};
        word[0*8 +: 8]  = "A";
        word[1*8 +: 8]  = "B";
        word[2*8 +: 8]  = "C";
        word[3*8 +: 8]  = "1";
        word[4*8 +: 8]  = "2";
        word[5*8 +: 8]  = "3";
        word[6*8 +: 8]  = "a";
        word[7*8 +: 8]  = "b";
        word[8*8 +: 8]  = "c";
        word[9*8 +: 8]  = "Z";
        word[10*8 +: 8] = "z";
        word[11*8 +: 8] = "9";
        word[12*8 +: 8] = " ";
        word[13*8 +: 8] = ",";
        word[14*8 +: 8] = "!";
        word[15*8 +: 8] = "?";
        // remaining characters are by default zero

        #10;
        $display("----- Encryption -----");
        for (idx = 0; idx < 16; idx = idx + 1)
            $write("%s", result[idx*8 +: 8]);
        $display("");

        // Now decrypt
        mode = 1'b0;
        #10;
        $display("----- Decryption -----");
        for (idx = 0; idx < 16; idx = idx + 1)
            $write("%s", result[idx*8 +: 8]);
        $display("");

        $finish;
    end

endmodule

