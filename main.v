`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:39:07 12/02/2017 
// Design Name: 
// Module Name:    main 
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
module main(
	input wire clk,
	input wire reset,
	input wire [1:0] switch,
	output wire hsync,
	output wire vsync,
	output wire [2:0] rgb,
	output wire [2:0] rgb_piece,
	output wire [9:0] pixelX,
	output wire [9:0] pixelY
    );
	 
	 reg [2:0] rgb_color; // this register loads the color that is needed to output wire rgb
	 wire clk_refresh; // this is used for the refresh rate of the screen which needs 25MHz
	 wire video_on; // displays video if output from h_v_synchronizer is 1 otherwise 0
	 wire piece_on; // displays piece if ouput from movingpiece is 1 otherwise 0
	 
	 twentyfiveMHzclk instance1(clk, reset, clk_refresh); // this instance takes a 50MHz clk 
	 //and returns an output of 25MHz clk needed for the refresh rate of the screen
	 
	 h_v_synchronizer instance2(.clk_refresh(clk_refresh), .hsync(hsync), .vsync(vsync), .video_on(video_on), .pixelX(), .pixelY()); // this instance keeps track
	 // of our position on the screen, when video should be displayed
	 
	 movingpiece instance3(.clk_refresh(clk_refresh), .reset(reset), .controller(switch), .pixelX(pixelX), .pixelY(pixelY), .piece_on(piece_on));

	always@ (posedge clk, posedge reset) begin
		if (reset)
			rgb_color <= 3'b0;
			
		else
			rgb_color <= 3'b110;
			
	end
	
	assign rgb = (video_on) ? rgb_color : 3'b0;
	assign rgb_piece = (piece_on) ? 3'b001 : 3'b000;
	
endmodule
