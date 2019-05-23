`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:05:13 12/02/2017 
// Design Name: 
// Module Name:    h_v_synchronizer 
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
module h_v_synchronizer(
	input wire clk_refresh,
	output hsync,
	output vsync,
	output video_on,
	output reg [9:0] pixelX,
	output reg [9:0] pixelY
    );
	 
	 reg display;
	 reg retraceH;
	 reg retraceV;
	 
	 integer H_Display = 640; // end of display 639
	 // start of FP 640
	 integer H_FP = 655; // end of FP 654
	 // start of Retrace 655
	 integer H_Retrace = 751; // end of retrace 750
	 // start of BP 751
	 integer H_BP = 799; // end of horizontal path 799
	 integer V_Display = 480; // end of display 479
	 // start of FP 480
	 integer V_FP = 490; // end of FP 490
	 // start of Retrace 492
	 integer V_Retrace = 492; // end of Retrace 491
	 // start of BP 492
	 integer V_BP = 524; // end of vertical path 524
	 
	 always@ (posedge clk_refresh) begin
		if (pixelX === H_BP) // if we have reached 799 which is
		// the max horizontal length
			pixelX <= 0;
			
		else
			pixelX <= pixelX + 1;
			
	end
	
	always@ (posedge clk_refresh) begin
		if (pixelX === H_BP) begin // if pixelX has reached 799
		// then check pixelY
			if (pixelY === V_BP) // if pixelY has reached 524
				pixelY <= 0;
				
			else
				pixelY <= pixelY + 1;
				
		end
	end
	
	always@ (posedge clk_refresh) begin
		display <= ((pixelX < H_Display) && (pixelY < V_Display));
		// display area is 1 when within hor: 0-639 and ver: 0-479
		retraceH <= ((pixelX >= H_FP) && (pixelX < H_Retrace));
		retraceV <= ((pixelY >= V_FP) && (pixelY < V_Retrace));
		
	end
	
	assign hsync = ~retraceH; // assign 0 to hsync when we
	// are in retrace
	assign vsync = ~retraceV; // assign 0 to vsync when we
	// are in retrace
	assign video_on = display; // video should be on when 
	// within hor: 0-639 and ver: 0-479
	 
endmodule
