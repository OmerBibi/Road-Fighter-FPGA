

module	speed_controller	(	
			input	logic	clk,
			input	logic	resetN, 
			input	logic	[3:0] keypad,
			input	logic	keypadIsvalid,
			input logic one_sec,
			input logic brake,
			
       // add the box here 
			
			output logic [1:0] speed // active in case of collision between two objects
);

enum logic [1:0] {s_stop, s_slow, s_fast} speed_PS, speed_NS;
logic [1:0] counter_PS, counter_NS;



always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN)
	begin 
		speed_PS <= s_stop;
		counter_PS <= 2;
	end
	else begin
		speed_PS <= speed_NS;
		counter_PS <= counter_NS;
	end
end
	
always_comb begin
	speed_NS = speed_PS;
	counter_NS = counter_PS;
	speed = 2'd1;
	case (speed_PS)
	s_stop: begin
				speed = 2'd0;
				if(one_sec && counter_PS != -0)
				counter_NS = counter_PS - 1;
				if(keypad == 8 && keypadIsvalid && counter_PS == 0 ) begin
					speed_NS = s_slow;
					counter_NS = 2'd2;
				end
		end
	s_slow: begin
				speed = 2'd1;
				if (!brake)
					speed_NS = s_stop;
				else begin
					if(one_sec && counter_PS !=0)
					counter_NS = counter_PS - 1;
					if(counter_PS == 0)begin
						if(keypad == 8 && keypadIsvalid) begin
							speed_NS = s_fast;
							counter_NS = 2'd2;
						end
						if(keypad == 2 && keypadIsvalid) begin
								speed_NS = s_stop;
								counter_NS = 2'd2;
							end
					end
				end
		end
	s_fast: begin
				speed = 2'd2;
				if (!brake)
					speed_NS = s_stop;
				else begin
					if(one_sec && counter_PS !=0)
					counter_NS = counter_PS - 1;
					if(keypad == 2 && keypadIsvalid && counter_PS == 0 ) begin
						speed_NS = s_slow;
						counter_NS = 2'd2;
					end
				end
		end
	endcase
end
	 
endmodule
