
// game controller dudy Febriary 2020
// (c) Technion IIT, Department of Electrical Engineering 2021 
//updated --Eyal Lev 2021


module	game_controller	(	
			input	logic	clk,
			input	logic	resetN,
			input	logic	startOfFrame,  // short pulse every start of frame 30Hz 
			input	logic	drawing_request_Red,
			input	logic	drawing_request_Yellow,
			input	logic	drawing_request_Gas,
			input logic one_sec,
			input logic GasFailed,
			input logic YellowPassed,
			input logic [1:0] speed,
			input logic GameWon,
			input logic TruckPassed,
			input	logic	drawing_request_Truck,
			input	logic	enter,
			input logic GameOver,
			input logic HolePassed,
			input	logic	drawing_request_Hole,
			
       // add the box here 
			
		  // active in case of collision between two objects
			output logic SingleHitPulse, // critical code, generating A single pulse in a frame 
			output logic GasEnable,
			output logic YellowEnable,
			output logic speedResetN,
			output logic addScore,
			output logic WinFlag,
			output logic TruckEnable,
			output logic idle_request,
			output logic addFuel,
			output logic gameOverFlag,
			output logic HoleEnable
			
			
			
			
);

// drawing_request_Ball   -->  smiley
// drawing_request_1      -->  brackets
// drawing_request_2      -->  number/box 
enum logic [2:0] {s_fuel, s_wait, s_yellowcar,s_bluetruck, s_gameWon, s_idle, s_gameOver, s_hole} game_ps, game_ns;
logic [2:0] Timer_ps, Timer_ns ,flag_ps, flag_ns;
logic [1:0] hole_flag_ns, hole_flag_ps ;
logic collisionGas, collisionYellow, collisionTruck, collisionHole ;
assign collisionYellow = ( drawing_request_Red &&  drawing_request_Yellow );
assign collisionGas = ( drawing_request_Red &&  drawing_request_Gas );
assign collisionTruck = ( drawing_request_Red &&  drawing_request_Truck );
assign collisionHole = ( drawing_request_Red &&  drawing_request_Hole ); 
// any collision 
						 						




always_ff@(posedge clk or negedge resetN)
begin
	if(!resetN)
	begin 
		game_ps <= s_idle;
		Timer_ps <= 3'd6;
		flag_ps <= 3'd1;
		hole_flag_ps <= 2'd2;
	end 
	else if(GameOver)
		game_ps <= s_gameOver;
	else if(GameWon)
		game_ps <= s_gameWon;
	else begin 
			game_ps <= game_ns;
			Timer_ps <= Timer_ns;
			flag_ps <= flag_ns;
			hole_flag_ps <= hole_flag_ns;
			// default 
		end 
	end

always_comb begin
	game_ns = game_ps;
	Timer_ns = Timer_ps;
	flag_ns = flag_ps;
	hole_flag_ns = hole_flag_ps;
	SingleHitPulse = 1'b0;
	GasEnable = 1'b0;
	YellowEnable =1'b0;
	speedResetN =1'b1;
	addScore = 1'b0;
	WinFlag = 1'b0;
	TruckEnable = 1'b0;
	idle_request = 1'b0;
	addFuel = 1'b0;
	gameOverFlag= 1'b0;
	HoleEnable = 1'b0;
	case (game_ps)
	s_idle: begin
					idle_request = 1;
					if (enter)
						game_ns = s_wait;
					
			end
	s_wait: begin
					if(Timer_ps == 3 && hole_flag_ps == 0 && speed !=0 )begin
						SingleHitPulse = 1'b1;
						game_ns = s_hole;
					end
					if(Timer_ps == 0) begin
							SingleHitPulse = 1'b1;
							hole_flag_ns = hole_flag_ps - 1;
							case (flag_ps)
							3'd0 : game_ns = s_fuel;
							3'd1 : game_ns = s_yellowcar;
							3'd2 : game_ns = s_bluetruck;
							3'd3 : game_ns = s_fuel;
							3'd4 : game_ns = s_yellowcar;
							3'd5 : game_ns = s_fuel;
							3'd6 : game_ns = s_fuel;
							3'd7 : game_ns = s_bluetruck;
							
							default: game_ns = s_fuel;
							endcase
						
					end
					else begin
						if(one_sec) begin
							Timer_ns =Timer_ps - 1;
						end
					end
			end
	s_yellowcar: begin
		YellowEnable = 1'b1;
		flag_ns = flag_ps + 1;
		if(YellowPassed) begin
			game_ns = s_wait;
			Timer_ns = 3;
			addScore = 1'b1;
			end
		if(collisionYellow) begin
			game_ns = s_wait;
			Timer_ns = 4;
			speedResetN = 1'b0;
			addFuel = 1;
			end
		end
	s_hole: begin
		HoleEnable = 1'b1;
		hole_flag_ns = 2;
		if(HolePassed) begin
			game_ns = s_wait;
			end
		if(collisionHole) begin
			game_ns = s_wait;
			speedResetN = 1'b0;
			end
		end
	s_bluetruck: begin
		TruckEnable = 1'b1;
		flag_ns = flag_ps + 1;
		if(TruckPassed) begin
			game_ns = s_wait;
			Timer_ns = 3;
			addScore = 1'b1;
			end
		if(collisionTruck) begin
			game_ns = s_wait;
			Timer_ns = 4;
			speedResetN = 1'b0;
			end
		end
	s_fuel: begin
		flag_ns = flag_ps + 1;
		GasEnable = 1'b1;
		if(GasFailed) begin
			game_ns = s_wait;
			Timer_ns = 3;
			end
		if(collisionGas) begin
			game_ns = s_wait;
			Timer_ns = 4;
			addFuel = 1;
			addScore = 1'b1;
			end
		end
	s_gameWon: begin
		speedResetN = 1'b0;
		WinFlag = 1'b1;
		
		end
	s_gameOver: begin
		speedResetN = 1'b0;
		gameOverFlag = 1'b1;
		
		end
		
	endcase
end
endmodule
