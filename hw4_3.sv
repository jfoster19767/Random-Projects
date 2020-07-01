//////////////////////////////////
// Top level module developed by Jason Foster
//

module hw4_3 (
	input logic rn,
	input logic ck,
	input logic frst,
	input logic start,
	input logic [511:0] imsg,
	output logic ready,
	output logic [255:0] mdig
);

reg [2047:0] K = 2048'hc67178f2bef9a3f7a4506ceb90befffa8cc7020884c8781478a5636f748f82ee682e6ff35b9cca4f4ed8aa4a391c0cb334b0bcb52748774c1e376c0819a4c116106aa070f40e3585d6990624d192e819c76c51a3c24b8b70a81a664ba2bfe8a192722c8581c2c92e766a0abb650a735453380d134d2c6dfc2e1b213827b70a851429296706ca6351d5a79147c6e00bf3bf597fc7b00327c8a831c66d983e515276f988da5cb0a9dc4a7484aa2de92c6f240ca1cc0fc19dc6efbe4786e49b69c1c19bf1749bdc06a780deb1fe72be5d74550c7dc3243185be12835b01d807aa98ab1c5ed5923f82a459f111f13956c25be9b5dba5b5c0fbcf71374491428a2f98;
reg [2047:0] W = 2048'h0;

reg [31:0] a;
reg [31:0] b;
reg [31:0] c;
reg [31:0] d;
reg [31:0] e;
reg [31:0] f;
reg [31:0] g;
reg [31:0] h;

reg [31:0] H0;
reg [31:0] H1;
reg [31:0] H2;
reg [31:0] H3;
reg [31:0] H4;
reg [31:0] H5;
reg [31:0] H6;
reg [31:0] H7;

reg [31:0] T1;
reg [31:0] T2;

reg [6:0] t;

reg isReady;
reg [255:0] Data_Out;

reg part1;
reg part2;
reg part3;

always @ (posedge ck or negedge rn)
// Clear all registers // 
	if(!rn)
		begin : params1
			a <= 32'h0;
			b <= 32'h0;
			c <= 32'h0;
			d <= 32'h0;
			e <= 32'h0;
			f <= 32'h0;
			g <= 32'h0;
			h <= 32'h0;
			T1 <= 32'h0;
			T2 <= 32'h0;
			H0 <= 32'h6a09e667;
			H1 <= 32'hbb67ae85;
			H2 <= 32'h3c6ef372;
			H3 <= 32'ha54ff53a;
			H4 <= 32'h510e527f;
			H5 <= 32'h9b05688c;
			H6 <= 32'h1f83d9ab;
			H7 <= 32'h5be0cd19;
			t <= 7'b0;
			isReady <= 1'b0;
			Data_Out <= 256'h0;
			part1 <= 1'b0;
			part2 <= 1'b0;
			part3 <= 1'b0;
		end
	else if(start)
		begin : params200
			a <= H0;
			b <= H1;
			c <= H2;
			d <= H3;
			e <= H4;
			f <= H5;
			g <= H6;
			h <= H7;
			T1 <= 32'h0;
			T2 <= 32'h0;
			isReady <= 1'b0;
			t <= 7'b0;
			part1 <= 1'b1;
			part2 <= 1'b0;
			part3 <= 1'b0;
		end
	else if(t == 7'b1000000)
		begin : params2
			isReady <= 1'b1;
			Data_Out <= {H0 + a, H1 + b, H2 + c, H3 + d, H4 + e, H5 + f, H6 + g, H7 + h};
			// Compute the intermediate hash value //
			H0 <= a + H0;
			H1 <= b + H1;
			H2 <= c + H2;
			H3 <= d + H3;
			H4 <= e + H4;
			H5 <= f + H5;
			H6 <= g + H6;
			H7 <= h + H7;
			part1 <= 1'b0;
			part2 <= 1'b0;
			part3 <= 1'b0;
			t <= t + 1'b1;
		end
	else if(part1)
		begin : params3
			// Prepare the message schedule //
			// look, I didnt want to do this. But I can't figure out why Im getting "t is not a constant" error //
			if(t == 0)
				begin : params4
					W[31:0] <= imsg[31:0];
				end
			else if(t == 1)
				begin : params5
					W[63:32] <= imsg[63:32];
				end
			else if(t == 2)
				begin : params6
					W[95:64] <= imsg[95:64];
				end
			else if(t == 3)
				begin : params7
					W[127:96] <= imsg[127:96];
				end
			else if(t == 4)
				begin : params8
					W[159:128] <= imsg[159:128];
				end
			else if(t == 5)
				begin : params9
					W[191:160] <= imsg[191:160];
				end
			else if(t == 6)
				begin : params10
					W[223:192] <= imsg[223:192];
				end
			else if(t == 7)
				begin : params11
					W[255:224] <= imsg[255:224];
				end
			else if(t == 8)
				begin : params12
					W[287:256] <= imsg[287:256];
				end
			else if(t == 9)
				begin : params13
					W[319:288] <= imsg[319:288];
				end
			else if(t == 10)
				begin : params14
					W[351:320] <= imsg[351:320];
				end
			else if(t == 11)
				begin : params15
					W[383:352] <= imsg[383:352];
				end
			else if(t == 12)
				begin : params16
					W[415:383] <= imsg[415:383];
				end
			else if(t == 13)
				begin : params17
					W[447:416] <= imsg[447:416];
				end
			else if(t == 14)
				begin : params18
					W[479:448] <= imsg[479:448];
				end
			else if(t == 15)
				begin : params19
					W[511:480] <= imsg[511:480];
				end
			else if(t == 16)
				begin : params20
					W[543:512] <= Sigma1(W[479:448]) + W[319:288] + Sigma0(W[63:32]) + W[31:0];
				end
			else if(t == 17)
				begin : params21
					W[575:544] <= Sigma1(W[511:480]) + W[351:320] + Sigma0(W[95:64]) + W[63:32];
				end
			else if(t == 18)
				begin : params22
					W[607:576] <= Sigma1(W[543:512]) + W[383:352] + Sigma0(W[127:96]) + W[95:64];
				end
			else if(t == 19)
				begin : params23
					W[639:608] <= Sigma1(W[575:544]) + W[415:384] + Sigma0(W[159:128]) + W[127:96];
				end
			else if(t == 20)
				begin : params24
					W[671:640] <= Sigma1(W[607:576]) + W[447:416] + Sigma0(W[191:160]) + W[159:128];
				end
			else if(t == 21)
				begin : params25
					W[703:672] <= Sigma1(W[639:608]) + W[479:448] + Sigma0(W[223:192]) + W[191:160];
				end
			else if(t == 22)
				begin : params26
					W[735:704] <= Sigma1(W[671:640]) + W[511:480] + Sigma0(W[255:224]) + W[223:192];
				end
			else if(t == 23)
				begin : params27
					W[767:736] <= Sigma1(W[703:672]) + W[543:512] + Sigma0(W[287:256]) + W[255:224];
				end
			else if(t == 24)
				begin : params28
					W[799:768] <= Sigma1(W[735:704]) + W[575:544] + Sigma0(W[319:288]) + W[287:256];
				end
			else if(t == 25)
				begin : params29
					W[831:800] <= Sigma1(W[767:736]) + W[607:576] + Sigma0(W[351:320]) + W[319:288];
				end
			else if(t == 26)
				begin : params30
					W[863:832] <= Sigma1(W[799:768]) + W[639:608] + Sigma0(W[383:352]) + W[351:320];
				end
			else if(t == 27)
				begin : params31
					W[895:864] <= Sigma1(W[831:800]) + W[671:640] + Sigma0(W[415:384]) + W[383:352];
				end
			else if(t == 28)
				begin : params32
					W[927:896] <= Sigma1(W[863:832]) + W[703:672] + Sigma0(W[447:416]) + W[415:384];
				end
			else if(t == 29)
				begin : params33
					W[959:928] <= Sigma1(W[895:864]) + W[735:704] + Sigma0(W[479:448]) + W[447:416];
				end
			else if(t == 30)
				begin : params34
					W[991:960] <= Sigma1(W[927:896]) + W[767:736] + Sigma0(W[511:480]) + W[479:448];
				end
			else if(t == 31)
				begin : params35
					W[1023:992] <= Sigma1(W[959:928]) + W[799:768] + Sigma0(W[543:512]) + W[511:480];
				end
			else if(t == 32)
				begin : params36
					W[1055:1024] <= Sigma1(W[991:960]) + W[831:800] + Sigma0(W[575:544]) + W[543:512];
				end
			else if(t == 33)
				begin : params37
					W[1087:1056] <= Sigma1(W[1023:992]) + W[863:832] + Sigma0(W[607:576]) + W[575:544];
				end
			else if(t == 34)
				begin : params38
					W[1119:1088] <= Sigma1(W[1055:1024]) + W[895:864] + Sigma0(W[639:608]) + W[607:576];
				end
			else if(t == 35)
				begin : params39
					W[1151:1120] <= Sigma1(W[1087:1056]) + W[927:896] + Sigma0(W[671:640]) + W[639:608];
				end
			else if(t == 36)
				begin : params40
					W[1183:1152] <= Sigma1(W[1119:1088]) + W[959:928] + Sigma0(W[703:672]) + W[671:640];
				end
			else if(t == 37)
				begin : params41
					W[1215:1184] <= Sigma1(W[1151:1120]) + W[991:960] + Sigma0(W[735:704]) + W[703:672];
				end
			else if(t == 38)
				begin : params42
					W[1247:1216] <= Sigma1(W[1183:1152]) + W[1023:992] + Sigma0(W[767:736]) + W[735:704];
				end
			else if(t == 39)
				begin : params43
					W[1279:1248] <= Sigma1(W[1215:1184]) + W[1055:1024] + Sigma0(W[799:768]) + W[767:736];
				end
			else if(t == 40)
				begin : params44
					W[1311:1280] <= Sigma1(W[1247:1216]) + W[1087:1056] + Sigma0(W[831:800]) + W[799:768];
				end
			else if(t == 41)
				begin : params45
					W[1343:1312] <= Sigma1(W[1279:1248]) + W[1119:1088] + Sigma0(W[863:832]) + W[831:800];
				end
			else if(t == 42)
				begin : params46
					W[1375:1344] <= Sigma1(W[1311:1280]) + W[1151:1120] + Sigma0(W[895:864]) + W[863:832];
				end
			else if(t == 43)
				begin : params47
					W[1407:1376] <= Sigma1(W[1343:1312]) + W[1183:1152] + Sigma0(W[927:896]) + W[895:864];
				end
			else if(t == 44)
				begin : params48
					W[1439:1408] <= Sigma1(W[1375:1344]) + W[1215:1184] + Sigma0(W[959:928]) + W[927:896];
				end
			else if(t == 45)
				begin : params49
					W[1471:1440] <= Sigma1(W[1407:1376]) + W[1247:1216] + Sigma0(W[991:960]) + W[959:928];
				end
			else if(t == 46)
				begin : params50
					W[1503:1472] <= Sigma1(W[1439:1408]) + W[1279:1248] + Sigma0(W[1023:992]) + W[991:960];
				end
			else if(t == 47)
				begin : params51
					W[1535:1504] <= Sigma1(W[1471:1440]) + W[1311:1280] + Sigma0(W[1055:1024]) + W[1023:992];
				end
			else if(t == 48)
				begin : params52
					W[1567:1536] <= Sigma1(W[1503:1472]) + W[1343:1312] + Sigma0(W[1087:1056]) + W[1055:1024];
				end
			else if(t == 49)
				begin : params53
					W[1599:1568] <= Sigma1(W[1535:1504]) + W[1375:1344] + Sigma0(W[1119:1088]) + W[1087:1056];
				end
			else if(t == 50)
				begin : params54
					W[1631:1600] <= Sigma1(W[1567:1536]) + W[1407:1376] + Sigma0(W[1151:1120]) + W[1119:1088];
				end
			else if(t == 51)
				begin : params55
					W[1663:1632] <= Sigma1(W[1599:1568]) + W[1439:1408] + Sigma0(W[1183:1152]) + W[1151:1120];
				end
			else if(t == 52)
				begin : params56
					W[1695:1664] <= Sigma1(W[1631:1600]) + W[1471:1440] + Sigma0(W[1215:1184]) + W[1183:1152];
				end
			else if(t == 53)
				begin : params57
					W[1727:1696] <= Sigma1(W[1663:1632]) + W[1503:1472] + Sigma0(W[1247:1216]) + W[1215:1184];
				end
			else if(t == 54)
				begin : params58
					W[1759:1728] <= Sigma1(W[1695:1664]) + W[1535:1504] + Sigma0(W[1279:1248]) + W[1247:1216];
				end
			else if(t == 55)
				begin : params59
					W[1791:1760] <= Sigma1(W[1727:1696]) + W[1567:1536] + Sigma0(W[1311:1280]) + W[1279:1248];
				end
			else if(t == 56)
				begin : params60
					W[1823:1792] <= Sigma1(W[1759:1728]) + W[1599:1568] + Sigma0(W[1343:1312]) + W[1311:1280];
				end
			else if(t == 57)
				begin : params61
					W[1855:1824] <= Sigma1(W[1791:1760]) + W[1631:1600] + Sigma0(W[1375:1344]) + W[1343:1312];
				end
			else if(t == 58)
				begin : params62
					W[1887:1856] <= Sigma1(W[1823:1792]) + W[1663:1632] + Sigma0(W[1407:1376]) + W[1375:1344];
				end
			else if(t == 59)
				begin : params63
					W[1919:1888] <= Sigma1(W[1855:1824]) + W[1695:1664] + Sigma0(W[1439:1408]) + W[1407:1376];
				end
			else if(t == 60)
				begin : params64
					W[1951:1920] <= Sigma1(W[1887:1856]) + W[1727:1696] + Sigma0(W[1471:1440]) + W[1439:1408];
				end
			else if(t == 61)
				begin : params65
					W[1983:1952] <= Sigma1(W[1919:1888]) + W[1759:1728] + Sigma0(W[1503:1472]) + W[1471:1440];
				end
			else if(t == 62)
				begin : params66
					W[2015:1984] <= Sigma1(W[1951:1920]) + W[1791:1760] + Sigma0(W[1535:1504]) + W[1503:1472];
				end
			else if(t == 63)
				begin : params67
					W[2047:2016] <= Sigma1(W[1983:1952]) + W[1823:1792] + Sigma0(W[1567:1536]) + W[1535:1504];
				end
			part1 <= 1'b0;
			part2 <= 1'b1;
		end
	else if(part2)
		begin : params202
			// Part 3 //
			if(t == 0) 
				begin : params68
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[31:0] + W[31:0];
				end
			else if(t == 1)
				begin : params70
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[63:32] + W[63:32];
				end
			else if(t == 2)
				begin : params71
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[95:64] + W[95:64];
				end
			else if(t == 3)
				begin : params72
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[127:96] + W[127:96];
				end
			else if(t == 4)
				begin : params73
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[159:128] + W[159:128];
				end
			else if(t == 5)
				begin : params74
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[191:160] + W[191:160];
				end
			else if(t == 6)
				begin : params75
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[223:192] + W[223:192];
				end
			else if(t == 7)
				begin : params76
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[255:224] + W[255:224];
				end
			else if(t == 8)
				begin : params77
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[287:256] + W[287:256];
				end
			else if(t == 9)
				begin : params78
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[319:288] + W[319:288];
				end
			else if(t == 10)
				begin : params79
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[351:320] + W[351:320];
				end
			else if(t == 11)
				begin : params80
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[383:352] + W[383:352];
				end
			else if(t == 12)
				begin : params81
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[415:384] + W[415:384];
				end
			else if(t == 13)
				begin : params82
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[447:416] + W[447:416];
				end
			else if(t == 14)
				begin : params83
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[479:448] + W[479:448];
				end
			else if(t == 15)
				begin : params84
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[511:480] + W[511:480];
				end
			else if(t == 16)
				begin : params85
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[543:512] + W[543:512];
				end
			else if(t == 17)
				begin : params86
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[575:544] + W[575:544];
				end
			else if(t == 18)
				begin : params87
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[607:576] + W[607:576];
				end
			else if(t == 19)
				begin : params88
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[639:608] + W[639:608];
				end
			else if(t == 20)
				begin : params89
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[671:640] + W[671:640];
				end
			else if(t == 21)
				begin : params90
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[703:672] + W[703:672];
				end
			else if(t == 22)
				begin : params91
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[735:704] + W[735:704];
				end
			else if(t == 23)
				begin : params92
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[767:736] + W[767:736];
				end
			else if(t == 24)
				begin : params93
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[799:768] + W[799:768];
				end
			else if(t == 25)
				begin : params94
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[831:800] + W[831:800];
				end
			else if(t == 26)
				begin : params95
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[863:832] + W[863:832];
				end
			else if(t == 27)
				begin : params96
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[895:864] + W[895:864];
				end
			else if(t == 28)
				begin : params97
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[927:896] + W[927:896];
				end
			else if(t == 29)
				begin : params98
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[959:928] + W[959:928];
				end
			else if(t == 30)
				begin : params99
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[991:960] + W[991:960];
				end
			else if(t == 31)
				begin : params100
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1023:992] + W[1023:992];
				end
			else if(t == 32)
				begin : params101
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1055:1024] + W[1055:1024];
				end
			else if(t == 33)
				begin : params102
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1087:1056] + W[1087:1056];
				end
			else if(t == 34)
				begin : params103
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1119:1088] + W[1119:1088];
				end
			else if(t == 35)
				begin : params104
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1151:1120] + W[1151:1120];
				end
			else if(t == 36)
				begin : params105
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1183:1152] + W[1183:1152];
				end
			else if(t == 37)
				begin : params106
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1215:1184] + W[1215:1184];
				end
			else if(t == 38)
				begin : params107
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1247:1216] + W[1247:1216];
				end
			else if(t == 39)
				begin : params108
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1279:1248] + W[1279:1248];
				end
			else if(t == 40)
				begin : params109
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1311:1280] + W[1311:1280];
				end
			else if(t == 41)
				begin : params110
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1343:1312] + W[1343:1312];
				end
			else if(t == 42)
				begin : params111
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1375:1344] + W[1375:1344];
				end
			else if(t == 43)
				begin : params112
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1407:1376] + W[1407:1376];
				end
			else if(t == 44)
				begin : params113
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1439:1408] + W[1439:1408];
				end
			else if(t == 45)
				begin : params114
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1471:1440] + W[1471:1440];
				end
			else if(t == 46)
				begin : params115
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1503:1472] + W[1503:1472];
				end
			else if(t == 47)
				begin : params116
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1535:1504] + W[1535:1504];
				end
			else if(t == 48)
				begin : params117
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1567:1536] + W[1567:1536];
				end
			else if(t == 49)
				begin : params118
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1599:1568] + W[1599:1568];
				end
			else if(t == 50)
				begin : params119
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1631:1600] + W[1631:1600];
				end
			else if(t == 51)
				begin : params120
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1663:1632] + W[1663:1632];
				end
			else if(t == 52)
				begin : params121
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1695:1664] + W[1695:1664];
				end
			else if(t == 53)
				begin : params122
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1727:1696] + W[1727:1696];
				end
			else if(t == 54)
				begin : params123
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1759:1728] + W[1759:1728];
				end
			else if(t == 55)
				begin : params124
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1791:1760] + W[1791:1760];
				end
			else if(t == 56)
				begin : params125
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1823:1792] + W[1823:1792];
				end
			else if(t == 57)
				begin : params126
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1855:1824] + W[1855:1824];
				end
			else if(t == 58)
				begin : params127
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1887:1856] + W[1887:1856];
				end
			else if(t == 59)
				begin : params128
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1919:1888] + W[1919:1888];
				end
			else if(t == 60)
				begin : params129
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1951:1920] + W[1951:1920];
				end
			else if(t == 61)
				begin : params130
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[1983:1952] + W[1983:1952];
				end
			else if(t == 62)
				begin : params131
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[2015:1984] + W[2015:1984];
				end
			else if(t == 63)
				begin : params132
					T1 <= h + Sum1(e) + Ch(e,f,g) + K[2047:2016] + W[2047:2016];
				end
			T2 <= Sum0(a) + Maj(a,b,c);
			part2 <= 1'b0;
			part3 <= 1'b1;
		end
		else if(part3)
			begin : params204
				h <= g;
				g <= f;
				f <= e;
				e <= d + T1;
				d <= c;
				c <= b;
				b <= a;
				a <= T1 + T2;
				t <= t + 1'b1;
				part3 <= 1'b0;
				part1 <= 1'b1;
			end		
		
assign ready = isReady;
assign mdig = Data_Out;

		
function logic [31:0] Ch;
	input [31:0] x;
	input [31:0] y;
	input [31:0] z;
	
	reg [31:0] Bits_Out;
	
	Bits_Out = (x & y) ^ (~x & z);
	
	return Bits_Out;
endfunction	

function logic [31:0] Maj;
	input [31:0] x;
	input [31:0] y;
	input [31:0] z;
	
	reg [31:0] Bits_Out;
	
	Bits_Out = (x & y) ^ (x & z) ^ (y & z);
	
	return Bits_Out;
endfunction

function logic [31:0] Sum0;
	input [31:0] x;
	
	reg [31:0] Bits_Out;
	
	Bits_Out = ((x >> 2) | (x << 30)) ^ ((x >> 13) | (x << 19)) ^ ((x >> 22) | (x << 10));
	
	return Bits_Out;
endfunction

function logic [31:0] Sum1;
	input [31:0] x;
	
	reg [31:0] Bits_Out;
	
	Bits_Out = ((x >> 6) | (x << 26)) ^ ((x >> 11) | (x << 21)) ^ ((x >> 25) | (x << 7));
	
	return Bits_Out;
endfunction

function logic [31:0] Sigma0;
	input [31:0] x;
	
	reg [31:0] Bits_Out;
	
	Bits_Out = ((x >> 7) | (x << 25)) ^ ((x >> 18) | (x << 14)) ^ (x >> 3);
	
	return Bits_Out;
endfunction

function logic [31:0] Sigma1;
	input [31:0] x;
	
	reg [31:0] Bits_Out;
	
	Bits_Out = ((x >> 17) | (x << 15)) ^ ((x >> 19) | (x << 13)) ^ (x >> 10);
	
	return Bits_Out;
endfunction

endmodule 