////////////////////////////////////////
// Top level module for hw21
// Developed by Jason Foster 9/30/19

module  hw21_3  #(
  parameter  m  =  4  // Default value of m
)  (
  input  logic  [m-1:0]  a ,  // N-bit input A
  input  logic  [m-1:0]  p ,  // N-bit field polynomial
  output logic  [m-1:0]  y    // N-bit output Y
) ;

// Internal Nets // 

logic [m-1:0] outS0;

logic [m-1:0] S [m-1:0];
logic [m-1:0] T [m-2:0];

// Initilization //

gf_2m_mult #(
.m (m)) mult1(
.a (a),
.b (a),
.p (p),
.y (outS0)
);

assign S[0] = outS0;
assign T[0] = outS0;

// Iteration //

genvar i;

generate
	for (i = 1; i < m-1; i = i + 1)
		begin : Params
			gf_2m_mult #(
			.m (m)) mult2(
			.a (S[i-1]),
			.b (S[i-1]),
			.p (p),
			.y (S[i])
			);
			gf_2m_mult #(
			.m (m)) mult3(
			.a (T[i-1]),
			.b (S[i]),
			.p (p),
			.y (T[i])
			);
		end
endgenerate

// Finalization //

assign y = T[m-2];

endmodule
