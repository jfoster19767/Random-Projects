///////////////////////////////////////
// Top level 
//
module hw3_3 (

input logic rn,
input logic ck,
input logic mode,
input logic start,
input logic [23:0] itxt,
input logic [23:0] key,

output logic [23:0] otxt,
output logic ready
);

Basic_Encryption_Control Control (
.Reset (rn),
.Clock (ck),
.mode (mode),
.Start (start),
.Ptext (itxt),
.Key (key),
.Ctext (otxt),
.Ready (ready)
);

endmodule 