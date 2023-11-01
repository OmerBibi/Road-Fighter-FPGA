

module	SupermanSpawner	(	
			input	logic	clk,
			input	logic	resetN, 
			input	logic	succeded,
			input	logic	one_sec,
			
			
			output logic  enable,
			output logic  pull

);

enum logic {s_wait, s_spawn} PS, NS;
logic [6:0] counter_PS, counter_NS;



always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN)
	begin 
		PS <= s_wait;
		counter_PS <= 70;
	end
	else begin
		PS <= NS;
		counter_PS <= counter_NS;
	end
end
	
always_comb begin
	NS = PS;
	counter_NS = counter_PS;
	enable = 0;
	pull =0;
	case (PS)
	s_wait: begin
					if( counter_PS == 0) begin
						NS = s_spawn;
						pull = 1;
					end
					else if (one_sec)
					counter_NS = counter_PS - 1;	
				end
	s_spawn: begin
					enable = 1;
					if(succeded) begin
						NS = s_wait;
						counter_NS = 70;
					end
				end
	endcase
end
	 
endmodule
