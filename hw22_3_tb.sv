////////////////////////////////////
// testbench for hw22_3
//

module hw22_3_tb;

parameter per = 10;

logic [7:0] a;
logic [7:0] y;

hw22_3 dut(
.a (a),
.y (y)
);

endmodule 