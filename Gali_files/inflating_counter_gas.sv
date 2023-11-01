// (c) Technion IIT, Department of Electrical Engineering 2018 

// Implements the inflating counter by instantiating
// two counters and a comparator

module inflating_counter_gas
	(
   // Input, Output Ports
	input logic clk, 
	input logic resetN, 
	input logic enable,
	input logic addFuel,
	input	logic [1:0]	speed,

   
	output logic [3:0] Units,
	output logic [3:0] Tens,
	
	output logic gameOver
	
   );
	
	logic enableT, load_units, load_tens;
	logic [3:0]  init_units, init_tens;
	assign enableT = (enable && (speed != 3'b0)) ;
	assign gameOver = ( (Units == 0) && (Tens == 0) ) ;
	always_comb begin
		load_units = 1;
		load_tens = 1;
		init_units = Units; 
		init_tens = Tens; 
		if(addFuel) begin
			if (Tens <= 7) begin
				load_tens = 0;
				init_tens = Tens + 2;
			end
			else begin
				load_units = 0;
				init_units = 9;
			end
		end
	end
	
	// Fast counter instantiation
	down_counter unitsC(
				.clk(clk),
				.resetN(resetN),
				.enable(enableT || addFuel ),
				.enable_cnt(1'b1),
				.loadN(load_units),
				.init (init_tens),
				.count(Units)
				);

	// Slow counter instantiation
	down_counter tensC(
				.clk(clk),
				.resetN(resetN),
				.enable(enableT || addFuel),
				.enable_cnt( (Units == 0) || ( addFuel && load_tens )),
				.loadN(!addFuel),
				.init (init_tens),
				.count(Tens)
				
				);	

				
	
	
endmodule
