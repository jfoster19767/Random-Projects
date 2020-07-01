// Combinational GF(2^m) multiplier
//
module  gf_2m_mult  #(
  parameter  m  =  4  // Default value of m
)  (
  input  logic  [m-1:0]  a ,  // N-bit input A
  input  logic  [m-1:0]  b ,  // N-bit input B
  input  logic  [m-1:0]  p ,  // N-bit field polynomial
  output logic  [m-1:0]  y    // N-bit output Y
) ;


// Internal nets
//
logic  [m-1:0]  x  [m-1:0] ;  // Products
logic  [m-1:0]  t  [m-2:0] ;  // Reduced partial sums
logic  [m-1:0]  s  [m-1:0] ;  // Partial sums
//
genvar  i ;


// Internal products
//
generate
  for  ( i  =  0 ;  i  <  m ;  i  =  i + 1 )
	 begin : params1
		assign  x[i]  =  a[i]  ?  b  :  0 ;
	 end
endgenerate

// Partial sums
//
assign  s[m-1]  =  x[m-1] ;
//
generate
  for  ( i  =  m-2 ;  i  >=  0 ;  i  =  i - 1 )
	 begin : params2
		 assign  t[i]  =  ( s[i+1][m-1] ? p : {m{1'b0}} )  ^  { s[i+1][m-2:0] , 1'b0 } ;
		 assign  s[i]  =  t[i]  ^  x[i] ;
	 end

endgenerate

// Output
//
assign  y  =  s[0] ;


endmodule
