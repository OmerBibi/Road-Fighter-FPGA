

module	car_mover	(	
			input	logic	clk,
			input	logic	resetN,
			input	logic	startOfFrame,  // short pulse every start of frame 30Hz 
			input	logic	[3:0] keypad,
			input	logic	keypadIsvalid,
			
       // add the box here 
			
			output logic [10:0] Xpos, // active in case of collision between two objects
			output logic EdgeColN
);
logic [10:0] Xpos_PS;
logic [10:0] Xpos_NS;


always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN)
	begin 
		Xpos_NS <= 11'd212;
		Xpos_PS <= 11'd212;
	end 
	else begin
		if (startOfFrame) begin 
		EdgeColN = 1;
		Xpos_PS <= Xpos_NS;
		if (keypadIsvalid) begin
			if (keypad == 6) begin 
					Xpos_NS = Xpos_PS + 4 ; 
					if (Xpos_NS >=  354)begin
						Xpos_NS = 11'd350;	
						EdgeColN = 0;
					end
				end
			if (keypad == 4) begin 
					Xpos_NS = Xpos_PS - 4;
						if (Xpos_PS <= 206) begin
							Xpos_NS = 11'd202;
							EdgeColN = 0 ;
						end
					end	
				end
			end
		end	
	end
	assign Xpos = Xpos_PS;

	 
endmodule
