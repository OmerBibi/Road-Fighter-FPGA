

module	siftah_mover	(	
			input	logic	clk,
			input	logic	resetN,
			input	logic	startOfFrame,  // short pulse every start of frame 30Hz 
			input	logic	plusIsPressed,
			input	logic	minusIsPressed,
       // add the box here 
			
			output logic [10:0] Ypos // active in case of collision between two objects
);
logic [10:0] Ypos_PS;
logic [10:0] Ypos_NS;


always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN)
	begin 
		Ypos_PS <= 11'd10;
	end 
	else if (startOfFrame) begin 
		Ypos_PS <= Ypos_NS;
		
	if (plusIsPressed && !minusIsPressed) begin 
			Ypos_NS = Ypos_PS + 1 ; 
		if (Ypos_NS >=  85)
		Ypos_NS = 11'd84;			
		end
	if (!plusIsPressed && minusIsPressed) begin 
			Ypos_NS = Ypos_PS - 1;
			if (Ypos_PS <=  9)
			Ypos_NS = 11'd10;
		end	
		end
	end
	assign Ypos = Ypos_PS;

	 
endmodule
