/////////////////////////////////////
// Test bench for my encrypter
//
module hw3_3_tb;

parameter per = 10;

logic rn;
logic ck;
logic mode;
logic start;
logic [23:0] ptxt;
logic [23:0] key;
logic [23:0] ctxt;
logic ready;

hw3_3 DUT (
.rn (rn),
.ck (ck),
.mode (mode),
.start (start),
.itxt (ptxt),
.key (key),
.otxt (ctxt),
.ready (ready)
) ;

endmodule 