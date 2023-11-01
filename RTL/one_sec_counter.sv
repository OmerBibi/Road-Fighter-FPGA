// (c) Technion IIT, Department of Electrical Engineering 2020 

// Implements a slow clock as an one-second counter with
// a one-second output pulse and a 0.5 Hz duty50 output
// Turbo input sets both outputs 16 times faster
 
 module one_sec_counter      	
	(
   // Input, Output Ports
	input  logic clk, 
	input  logic resetN, 
	input  logic turbo,
	output logic one_sec, 
	output logic duty50
   );
	
	int oneSecCount ;
	int sec ;		 // gets either one seccond or Turbo top value

// counter limit setting 
	
//       ----------------------------------------------	
	localparam oneSecVal = 26'd50_000_000; // for DE10 board un-comment this line 
//	localparam oneSecVal = 26'd20; // for quartus simulation un-comment this line 
//       ----------------------------------------------	
	
	assign  sec = turbo ? oneSecVal/10 : oneSecVal;


	
   always_ff @( posedge clk or negedge resetN )
   begin
	
		// asynchronous reset
		if ( !resetN ) begin
			one_sec <= 1'b0;
			duty50 <= 1'b0;
			oneSecCount <= 26'd0;
		end // if reset
		
		// executed once every clock 	
		else begin
			if (oneSecCount >= sec) begin
				one_sec <= 1'b1;
				duty50 <= ~duty50;
				oneSecCount <= 0;
			end
			else begin
				oneSecCount <= oneSecCount + 1;
				one_sec		<= 1'b0;
			end
		end // else clk
		
	end // always
endmodule