///////////////////////////////
//  Test bench for hw21_3
//

module hw21_3_tb;

parameter per = 10;
parameter n1 = 4;
parameter n2 = 8;
parameter n3 = 10;

logic [n1-1:0] a1;
logic [n1-1:0] p1;
logic [n1-1:0] y1;
logic [n1-1:0] z1;

logic [n2-1:0] a2;
logic [n2-1:0] p2;
logic [n2-1:0] y2;
logic [n2-1:0] z2;

logic [n3-1:0] a3;
logic [n3-1:0] p3;
logic [n3-1:0] y3;
logic [n3-1:0] z3;

hw21_3 #(
.m (n1)) dut4 (
.a (a1),
.p (p1),
.y (y1)
);

hw21_3 #(
.m (n1)) dut4Inv (
.a (y1),
.p (p1),
.y (z1)
);
hw21_3 #(
.m (n2)) dut8 (
.a (a2),
.p (p2),
.y (y2)
);

hw21_3 #(
.m (n2)) dut8Inv (
.a (y2),
.p (p2),
.y (z2)
);
hw21_3 #(
.m (n3)) dut10 (
.a (a3),
.p (p3),
.y (y3)
);

hw21_3 #(
.m (n3)) dut10Inv (
.a (y3),
.p (p3),
.y (z3)
);

// Stimuli
//
integer  i ;
initial  begin
  $display( "\n*** SIMULATION BEGINS ***\n" ) ;  // Mark the beginning of simulation
  p1  <= #1  4'b0011 ;
  for  ( i  =  0 ;  i  <  16 ;  i  =  i + 1 )
    begin
      a1  <= #1  i ;
      #(per/2) ;
      $display( "Inverse of %4b = %4b and %4b" , a1 , y1 , z1 ) ;  // Print the result
      #(per/2) ;
    end
  $display( "\n***  ***  ***  ***  ***\n" ) ;  // Mark the end of simulation
  p2  <= #1  8'b00011011 ;
  for  ( i  =  0 ;  i  <  256 ;  i  =  i + 1 )
    begin
      a2  <= #1  i ;
      #(per/2) ;
      $display( "Inverse of %8b = %8b and %8b" , a2 , y2 , z2 ) ;  // Print the result
      #(per/2) ;
    end
  p3  <= #1  10'b0000001001 ;
  for  ( i  =  0 ;  i  <  1024 ;  i  =  i + 1 )
    begin
      a3  <= #1  i ;
      #(per/2) ;
      $display( "Inverse of %10b = %10b and %10b" , a3 , y3 , z3 ) ;  // Print the result
      #(per/2) ;
    end
  $display( "\n***  ***  ***  ***  ***\n" ) ;  // Mark the end of simulation
  $display( "\n***  SIMULATION ENDS  ***\n" ) ;  // Mark the end of simulation
  $stop ;  // End the simulation
end

endmodule 