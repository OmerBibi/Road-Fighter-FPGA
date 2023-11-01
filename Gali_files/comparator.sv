// (c) Technion IIT, Department of Electrical Engineering 2018 

// Implements a simple equality one-bit out comparator


module comparator 
	(
   // Input, Output Ports
	input logic [3:0] vect1,
	input logic [3:0] vect2,
	output logic cmp
   );
	
   // Combinatorial logic
      
 	assign cmp = (vect1 == vect2) ? 1'b1 : 1'b0;
		
	

endmodule
