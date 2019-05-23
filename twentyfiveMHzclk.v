`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:48:09 12/02/2017 
// Design Name: 
// Module Name:    twentyfiveMHzclk 
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
module twentyfiveMHzclk(
	input wire clk, // clk signal from pin V10
	input wire reset,
	output wire refresh_clk // 25MHz clk
    );
	 
	reg [15:0] counter;
	
	always@ (posedge clk or posedge reset) begin
		if (reset == 1'b1 || counter == 16'b1111111111111111)
			counter <= 16'b0;
			
		else
			counter <= counter + 1'b1;
			
	end
	
	assign refresh_clk = counter[1];

endmodule
