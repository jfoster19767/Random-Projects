///////////////////////////////
// Testbench for HW 4
//

module hw4_3_tb;

logic rn;
logic ck;
logic frst;
logic start;
logic [511:0] imsg;
logic ready;
logic [255:0] mdig;

hw4_3 DUT(
.rn (rn),
.ck (ck),
.frst (frst),
.start (start),
.imsg (imsg),
.ready (ready),
.mdig (mdig)
);

endmodule 