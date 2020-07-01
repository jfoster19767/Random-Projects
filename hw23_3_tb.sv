/////////////////////////////////
// testbench for hw23_3
//

module hw23_3_tb;

parameter per = 10;

logic [7:0] a;
logic [7:0] y;
logic [7:0] z;

hw23_3 dut2(
.a (a),
.y (y)
);


hw22_3 dut(
.a (y),
.y (z)
);


endmodule 