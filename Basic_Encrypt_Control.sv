///////////////////////////////
//  HW1 created by jason Foster 9/19/19
//
module Basic_Encryption_Control (Reset, Clock, Start, Ptext, Key, Ctext, Ready, mode);

input Reset;
input Clock;
input Start;
input mode;
input [23:0] Ptext;
input [23:0] Key;

output logic [23:0] Ctext;
output Ready;

reg [3:0] Round_Count;
reg [23:0] State;
reg [23:0] Output;
reg IsReady;
// my transforms dont work together, so lets split them up
reg Is_SBOX;
reg Is_PBOX;
reg Is_RBOX;
reg XOR;

// INITILIZATION //
always @ (posedge Clock or negedge Reset)
	if(!Reset) 
		begin : params1
			Round_Count <= 4'b0;
			State <= 24'b0;
			Is_SBOX <= 1'b0;
			Is_PBOX <= 1'b0; 
			Is_RBOX <= 1'b0;
			IsReady <= 1'b0;
			XOR <= 1'b0;
		end
	else if(!mode)
		if(Start)
			begin : params2
				State <= Ptext ^ Key;
				Round_Count <= 4'b0001;
				Is_SBOX <= 1'b1;
				IsReady <= 1'b0;
			end
		else if(Round_Count == 4'b1100)
			// DONE //
			begin : params3
				IsReady <= 1;
				Ctext <= State;
			end
		else if(Is_SBOX == 1'b1)
			// Sbox //
			begin : params4
				State[23:21] <= SBOX(State[23:21]);
				State[20:18] <= SBOX(State[20:18]);
				State[17:15] <= SBOX(State[17:15]);
				State[14:12] <= SBOX(State[14:12]);
				State[11:9] <= SBOX(State[11:9]);
				State[8:6] <= SBOX(State[8:6]);
				State[5:3] <= SBOX(State[5:3]);
				State[2:0] <= SBOX(State[2:0]);
				Is_SBOX <= 1'b0;
				Is_PBOX <= 1'b1;
			end
		else if(Is_PBOX == 1'b1)
			begin : params5
				// Pbox //
				State <= PBOX(State, mode);
				Is_PBOX <= 1'b0;
				Is_RBOX <= 1'b1;
			end
		else if(Is_RBOX == 1'b1)
			begin : params6
				// Rbox //
				State <= RBOX(State, Round_Count);
				Is_RBOX <= 1'b0;
			end
		else
			begin : params7
				// Shuffle with key //
				State <= State ^ Key;
				Round_Count <= Round_Count + 4'b0001;
				Is_SBOX <= 1'b1;
			end
	else if(mode)
		if(Start) 
			begin : params8
				State <= Ptext;
				Round_Count <= 4'b1011;
				XOR <= 1'b1;
				IsReady <= 1'b0;
			end
		else if(Round_Count == 0)
			// DONE //
			begin : params9
				State <= State ^ Key;
				XOR <= 1'b0;
				Round_Count <= Round_Count - 4'b0001;
			end
		else if(Round_Count == 4'b1111)
			begin : params55
				IsReady <= 1'b1;
				Ctext <= State;
			end
		else if(XOR)
			begin : params13
				State = State ^ Key;
				XOR <= 1'b0;
				Is_RBOX <= 1'b1;
			end
		else if(Is_RBOX)
			begin : params10
				State <= RBOX(State, Round_Count);
				Is_RBOX <= 1'b0;
				Is_PBOX <= 1'b1;
			end
		else if(Is_PBOX)
			begin : params11
				// Pbox //
				State <= PBOX(State, mode);
				Is_PBOX <= 1'b0;
				Is_SBOX <= 1'b1;
			end
		else if(Is_SBOX)
			// Sbox //
			begin : params12
				State[23:21] <= SBOX(State[23:21]);
				State[20:18] <= SBOX(State[20:18]);
				State[17:15] <= SBOX(State[17:15]);
				State[14:12] <= SBOX(State[14:12]);
				State[11:9] <= SBOX(State[11:9]);
				State[8:6] <= SBOX(State[8:6]);
				State[5:3] <= SBOX(State[5:3]);
				State[2:0] <= SBOX(State[2:0]);
				Is_SBOX <= 1'b0;
				XOR <= 1'b1;
				Round_Count <= Round_Count - 4'b0001;
			end
	assign Ready = IsReady;	

		
function logic [23:0] RBOX;
	input [23:0] Bits_In;
	input [3:0] Round;
	reg [23:0] Bits_Out;

	Bits_Out = Bits_In;
	for(int j=0; j<4; j++)
		begin
		Bits_Out[6*j] = Bits_In[6*j] ^ Round[j];
		end
	return Bits_Out;
endfunction		

function logic [23:0] PBOX;
	input [23:0] Bits_In;
	input mode;
	reg [23:0] Bits_Out;
	
	if(!mode)
		for(int j=0, k=0; j<24; j++)
			begin
				k = j+9;  // Add my index
				if(k >= 24) k = k - 24;
				Bits_Out[j] = Bits_In[k];
			end
	else
		for(int j=0, k=0; j<24; j++)
			begin
				k = j+15;  // Add my index
				if(k >= 24) k = k - 24;
				Bits_Out[j] = Bits_In[k];
			end
	return Bits_Out;
endfunction

function logic [2:0] SBOX;
	input [2:0] Bits_In;
	reg [2:0] Bits_Out;
		if(Bits_In == 3'b000) Bits_Out = 3'b101;
		else if(Bits_In == 3'b001) Bits_Out = 3'b010;
		else if(Bits_In == 3'b010) Bits_Out = 3'b001;
		else if(Bits_In == 3'b011) Bits_Out = 3'b011;
		else if(Bits_In == 3'b100) Bits_Out = 3'b100;
		else if(Bits_In == 3'b101) Bits_Out = 3'b000;
		else if(Bits_In == 3'b110) Bits_Out = 3'b111;
		else if(Bits_In == 3'b111) Bits_Out = 3'b110;
	return Bits_Out;
endfunction	
	
endmodule 