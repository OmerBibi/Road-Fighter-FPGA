
// (c) Technion IIT, Department of Electrical Engineering 2021 
//-- Alex Grinshpun Apr 2017
//-- Dudy Nov 13 2017
// SystemVerilog version Alex Grinshpun May 2018
// coding convention dudy December 2018

//-- Eyal Lev 31 Jan 2021

module	objects_mux	(	
//		--------	Clock Input	 	
					input		logic	clk,
					input		logic	resetN,
		   // smiley 
					input		logic	RedCarRequest, // two set of inputs per unit
					input		logic	[7:0] RedCarRGB, 
					     
		  // add the box here 
					input 		logic	GasolineDrawingRequest,
					input		logic	[7:0] RGBGas, 
			  
		  ////////////////////////
		  // background 
					input    	logic RoadDrawingRequest, // box of numbers
					input		logic	[7:0] RoadRGB,   
					input		logic	DRR,
					input		logic	[7:0] NUMRRGB,	
					input		logic	DRL,
					input		logic	[7:0] NUMLRGB,
					input		logic	DRM,
					input		logic	[7:0] NUMMRGB,
					input		logic	[7:0] RGB_MIF,
					input		logic	YellowCarRequest,
					input		logic	[7:0] YellowCarRGB, 
					input		logic	WinRequest, 
					input		logic	[7:0] WinRGB,
					input		logic	TruckRequest, 
					input		logic	[7:0] TruckRGB,
					input		logic	idle_request, 
					input		logic	RightFuelRequest, 
					input		logic	[7:0] RGBRFuel,
					input		logic	LeftFuelRequest,
					input		logic	[7:0] RGBLFuel,
					input		logic	LostRequest, 
					input		logic	[7:0] LostRGB,
					input		logic	HoleRequest, 
					input		logic	[7:0] HoleRGB,
					input		logic	SupermanRequest, 
					input		logic	[7:0] SupermanRGB,
					     
			  
				   output	logic	[7:0] RGBOut
);

always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN) begin
			RGBOut	<= 8'b0;
	end
	
	else begin
		if (SupermanRequest == 1'b1 && idle_request == 1'b0 )   
			RGBOut <= SupermanRGB;  //first priority 
		else if (RedCarRequest == 1'b1 && idle_request == 1'b0 )   
			RGBOut <= RedCarRGB; 
		else if (WinRequest == 1'b1 && idle_request == 1'b0 )   
			RGBOut <= WinRGB;
		else if (LostRequest == 1'b1 && idle_request == 1'b0 )   
			RGBOut <= LostRGB; 
		else if (YellowCarRequest == 1'b1 && idle_request == 1'b0 )   
			RGBOut <= YellowCarRGB;
		else if (TruckRequest == 1'b1 && idle_request == 1'b0 )   
			RGBOut <= TruckRGB;
		else if (GasolineDrawingRequest == 1'b1 && idle_request == 1'b0)
				RGBOut <= RGBGas;
		else if (HoleRequest == 1'b1 && idle_request == 1'b0)
				RGBOut <= HoleRGB;
 		else if (RoadDrawingRequest == 1'b1 && idle_request == 1'b0)
				RGBOut <= RoadRGB;
		else if (DRR == 1'b1 && idle_request == 1'b0)
				RGBOut <= NUMRRGB ;
		else if (DRL == 1'b1 && idle_request == 1'b0)
				RGBOut <= NUMLRGB ;
		else if (DRM == 1'b1 && idle_request == 1'b0)
				RGBOut <= NUMMRGB	;
		else if (RightFuelRequest == 1'b1 && idle_request == 1'b0)
				RGBOut <= RGBRFuel ;
		else if (LeftFuelRequest == 1'b1 && idle_request == 1'b0)
				RGBOut <= RGBLFuel;
		else RGBOut <= RGB_MIF ;// last priority 
		end ; 
	end

endmodule


