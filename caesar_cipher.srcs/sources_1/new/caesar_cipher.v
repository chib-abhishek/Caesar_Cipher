`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2025 09:02:53 PM
// Design Name: 
// Module Name: caesar_cipher
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


module caesar_cipher #
(
    parameter WORD_LENGTH = 1024 // Number of ASCII characters to process
)
(
    input wire [WORD_LENGTH*8-1:0] word,   // Input word (1024 chars, 8192 bits)
    input wire [7:0] key,                  // Cipher key (shift)
    input wire mode,                       // 1: Encrypt, 0: Decrypt
    output reg [WORD_LENGTH*8-1:0] result  // Output (1024 chars, 8192 bits)
);

    integer i;
    reg [7:0] original_char;
    reg [7:0] processed_char;

    always @(*) begin
        for (i = 0; i < WORD_LENGTH; i = i + 1) begin
            original_char = word[i*8 +: 8];
            if (mode) begin // Encryption
                if (original_char >= 8'h30 && original_char <= 8'h39) begin
                    processed_char = original_char + key;
                    if (processed_char > 8'h39)
                        processed_char = processed_char - 8'h0A;
                end else if (original_char >= 8'h41 && original_char <= 8'h5A) begin
                    processed_char = original_char + key;
                    if (processed_char > 8'h5A)
                        processed_char = processed_char - 8'h1A;
                end else if (original_char >= 8'h61 && original_char <= 8'h7A) begin
                    processed_char = original_char + key;
                    if (processed_char > 8'h7A)
                        processed_char = processed_char - 8'h1A;
                end else begin
                    processed_char = original_char;
                end
            end else begin // Decryption
                if (original_char >= 8'h30 && original_char <= 8'h39) begin
                    processed_char = original_char - key;
                    if (processed_char < 8'h30)
                        processed_char = processed_char + 8'h0A;
                end else if (original_char >= 8'h41 && original_char <= 8'h5A) begin
                    processed_char = original_char - key;
                    if (processed_char < 8'h41)
                        processed_char = processed_char + 8'h1A;
                end else if (original_char >= 8'h61 && original_char <= 8'h7A) begin
                    processed_char = original_char - key;
                    if (processed_char < 8'h61)
                        processed_char = processed_char + 8'h1A;
                end else begin
                    processed_char = original_char;
                end
            end
            result[i*8 +: 8] = processed_char;
        end
    end

endmodule

