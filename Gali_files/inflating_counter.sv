// (c) Technion IIT, Department of Electrical Engineering 2018 

// Implements the inflating counter by instantiating
// two counters and a comparator

module inflating_counter 
	(
   // Input, Output Ports
	input logic clk, 
	input logic resetN, 
	input logic enable,
	input logic addScore,
	input	logic [1:0]	speed,

   
	output logic [3:0] Units,
	output logic [3:0] Tens,
	output logic [3:0] Hundreds,
	output logic gameWon
	
   );
	
	logic enableT;
	assign enableT = (enable && (speed != 3'b0)) ;
	assign gameWon = ((Units == 9) && (Tens == 9) && (Hundreds == 9)) ||((Tens == 9) && (Hundreds == 9) && addScore);
	
	// Fast counter instantiation
	up_counter unitsC(
				.clk(clk),
				.resetN(resetN),
				.enable(enableT),
				.enable_cnt(1'b1),
				.loadN(1'b1),
				.init (4'b0000),
				.count(Units)
				);

	// Slow counter instantiation
	up_counter tensC(
				.clk(clk),
				.resetN(resetN),
				.enable(enableT || addScore),
				.enable_cnt((Units == 9) || (addScore)),
				.loadN(1'b1),
				.init (4'b0000),
				.count(Tens)
				
				);	
	up_counter hundredsC(
				.clk(clk),
				.resetN(resetN),
				.enable(enableT || addScore),
				.enable_cnt( ((Units == 9)&&(Tens == 9)) || (addScore && (Tens > 8))  ),
				.loadN(1'b1),
				.init (4'b0000),
				.count(Hundreds)
				
				);	
				
	
	
endmodule
