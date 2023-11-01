
module	TurboDetector	(	
			input	logic [1:0]	speed,
			
			output logic turbo
			
);

assign turbo = speed == 2;

endmodule
