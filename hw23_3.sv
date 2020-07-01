///////////////////////////////////
// top level for hw23_3
//

module hw23_3 (
	input logic [7:0] a,
	output logic [7:0] y
);


assign y[7] = a[7] ^ a[6] ^ a[5] ^ a[3] ^ a[1];
assign y[6] = a[6] ^ a[5] ^ a[3] ^ a[1];
assign y[5] = a[6] ^ a[3] ^ a[1];
assign y[4] = a[7] ^ a[1];
assign y[3] = a[3] ^ a[1];
assign y[2] = a[6] ^ a[5] ^ a[4] ^ a[3];
assign y[1] = a[6] ^ a[3] ^ a[2] ^ a[1];
assign y[0] = a[7] ^ a[6] ^ a[5] ^ a[3] ^ a[0];

endmodule 