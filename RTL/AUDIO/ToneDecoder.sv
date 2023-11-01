/// (c) Technion IIT, Department of Electrical Engineering 2021 
//-- This module  generate the correet prescaler tones for a single ocatave 

//-- Dudy Feb 12 2019 
//-- Eyal Lev --change values to 31.5 MHz   Apr 2023

module	ToneDecoder	(	
					input	logic [3:0] tone, 
					output	logic [9:0]	preScaleValue
		);

logic [15:0] [9:0]	preScaleValueTable = { 


//---------------VALUES for 31.5MHz------------------------

10'h1D6,   // decimal =470.32      Hz =261.62  do    31_500_000/256/<FREQ_Hz>
10'h1BC,   // decimal =443.92      Hz =277.18  doD
10'h1A3,   // decimal =419.00      Hz =293.66  re
10'h18B,   // decimal =395.49      Hz =311.12  reD
10'h175,   // decimal =373.29      Hz =329.62  mi
10'h160,   // decimal =352.35      Hz =349.22  fa
10'h14D,   // decimal =332.55      Hz =370    faD
10'h13A,   // decimal =313.89      Hz =392    sol
10'h128,   // decimal =296.28      Hz =415.3  solD
10'h118,   // decimal =279.64      Hz =440    La
10'h108,   // decimal =263.96      Hz =466.16  laD
10'h0F9, // decimal =249.14      Hz =493.88  si
10'h0EB,   // decimal =235.15      Hz =523.25  do   Next OCTAV
10'h0DD,   // decimal =221.96      Hz =554.36  doD  Next OCTAV 
10'h0D1,   // decimal =209.50      Hz =587.33  reD  Next OCTAV
10'h0C5} ;   // decimal =197.74      Hz =622.25  reD  Next OCTAV
//10'h1A2,   // decimal =418.98      Hz =233.08  laD
//10'h18B} ; // decimal =395.46      Hz =246.94  si

assign 	preScaleValue = preScaleValueTable [tone] ; 

endmodule






















































