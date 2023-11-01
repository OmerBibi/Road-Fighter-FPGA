// (c) Technion IIT, Department of Electrical Engineering 2018 

// Implements an up-counter that has also control inputs,
// loadN, enable_cnt and enable to control the count
// and data input - init[3:0] for the load functionality


module down_counter 
	(
   // Input, Output Ports
   input logic clk, 
   input logic resetN,
   input logic enable,
	input logic loadN,
   input logic enable_cnt,
   input logic [3:0] init,
   output logic [3:0] count 
   );

 	 
 
   always_ff @( posedge clk , negedge resetN )
   begin
      
      if (!resetN) begin // Asynchronic reset
			count = 4'd9;
	  end
		
	  else begin
		if (enable) begin
			if (!loadN) begin
				count = init;
			end
			else begin
				if (count == 0 && enable_cnt)
					count = 9;
				else
					count = (enable_cnt) ? count - 1 : count;
			end
		end
		else begin
			 end
	  end

   end // always
	 
endmodule

