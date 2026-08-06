`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2026 09:39:12 AM
// Design Name: 
// Module Name: tt_um_vending_machine
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


module tt_um_MrMalro_vending_machine_buggy(

input wire [7:0] ui_in,
output wire [7:0] uo_out,
input wire [7:0] uio_in,
output wire [7:0] uio_out,
output wire [7:0] uio_oe,
input wire ena,
input wire clk,
input wire rst_n
    
    );
    
// Map inputs to familiar names
wire nickel  = ui_in[0];
wire dime    = ui_in[1];
wire quarter = ui_in[2];

// Tie off unused bidirectional pins (required by Tiny Tapeout)
assign uio_out = 8'b0;
assign uio_oe  = 8'b0;

// state declarations
localparam S0 = 3'd0;   // 0 cents
localparam S5 = 3'd1;   // 5 cents
localparam S10 = 3'd2;   // 10 cents
localparam S15 = 3'd3;   // 15 cents
localparam S20 = 3'd4;   // 20 cents
localparam S25 = 3'd5;   // 25 cents

// state registers
reg[2:0] current_state;
reg[2:0] next_state;

// output assignments
assign uo_out[0] = (current_state == S25);  // dispenses
assign uo_out[3:1] = current_state;     // debug, shows what state your in
assign uo_out[7:4] = 4'b0;      // zeroed out since the pins are unused


// state register - update on clock edge
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        current_state <= S0;
    else 
        current_state <= next_state;
end

// next state logic
always@(*) begin
    next_state = current_state;
    
    case(current_state)
        S0: begin
            if (quarter)
                next_state = S25;
            else if (dime)
                next_state = S10;
            else if (nickel)
                next_state = S5;
            else
                next_state = S0;
     end
     
        S5: begin
            if (quarter)
                next_state = S25;
            else if (dime)
                next_state = S15;
            else if (nickel)
                next_state = S10;
            else
                next_state = S5;
     end
     
        S10: begin
            if (quarter)
                next_state = S25;
            else if (dime)
                next_state = S20;
            else if (nickel)
                next_state = S20;
            else
                next_state = S10;
     end

        S15: begin
            if (quarter)
                next_state = S25;
            else if (dime)
                next_state = S25;
            else if (nickel)
                next_state = S20;
            else
                next_state = S15;
     end    

        S20: begin
            if (quarter)
                next_state = S25;
            else if (dime)
                next_state = S25;
            else if (nickel)
                next_state = S25;
            else
                next_state = S20;
        end
        
        S25: begin
            next_state = S0;
        end
        
        default: begin
            next_state = S0;
        end
        endcase
        
end             // closes out always @(*)
endmodule
