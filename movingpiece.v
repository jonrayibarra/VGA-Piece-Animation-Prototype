`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:07:41 12/03/2017 
// Design Name: 
// Module Name:    movingpiece 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module movingpiece(
	input wire clk_refresh,
	input wire reset,
	input wire [1:0] controller,
	input wire [9:0] pixelX,
	input wire [9:0] pixelY,
	output piece_on
    );

	integer H_Display = 640; // end of hor display 639
	// start of hor FP 640
	integer V_Display = 480; // end of ver display 479
	// start of ver FP 480
	
	// outlining the piece: line
	integer leftside = 310; // piece's left side
	integer rightside = 328; // piece's right side
	wire [9:0] top; // piece's top barrier
	wire [9:0] bottom; // piece's bottom barrier
	
	integer size = 50; // piece's size... if done correctly
	// it should display a line
	integer velocity = 4; // piece's movement speed
	
	wire piece_on; // determines if the piece is displayed
	//wire [2:0] piece_color;
	
	reg [9:0] currentstate;
	reg [9:0] nextstate;
	
	always@ (posedge clk_refresh, posedge reset) begin
		if (reset) begin
			currentstate <= 0;
			currentstate <= 0;
		end
		
		else begin
			currentstate <= nextstate;
			currentstate <= nextstate;
		end
	end
	
	assign top = currentstate; // setting top barrier
	assign bottom = top + size - 1; // setting bottom barrier
	assign piece_on = ((leftside <= pixelX) && (rightside >= pixelX) && (top <= pixelY) && (bottom >= pixelY));
	
	always@ (posedge clk_refresh) begin
		nextstate = currentstate;
		if (controller[1] & (bottom < (V_Display - 1 - velocity)))
			nextstate = currentstate + velocity;
			
		else if (controller[0] & (top > velocity))
			nextstate = currentstate - velocity;
	end	
		
endmodule
