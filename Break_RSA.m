function Break_RSA
% Simulate breaking the RSA encryption scheme 
% Developed by Jason Foster 10/14/19

% It would be trivial to "break" RSA if I knew what the values were when I
% started, So I'll let MATLAB choose them so I won't know the value going
% in. Well, until I enter debug mode. . .

Primes = [3	5 7	11 13 17 19	23 29 ...
31	37	41	43	47	53	59	61	67	71 ...
73	79	83	89	97	101	103	107	109	113 ...
127	131	137	139	149	151	157	163	167	173 ...
179	181	191	193	197	199	211	223	227	229 ...
233	239	241	251	257	263	269	271	277	281 ...
283	293	307	311	313	317	331	337	347	349 ...
353	359	367	373	379	383	389	397	401	409 ...
419	421	431	433	439	443	449	457	461	463];
% Since the values get to large to store in 64bits I need to change the
% data type
Primes = vpi(Primes);

% My message doesnt have to be prime, but still should be random
M = randi(50);
M = vpi(M);

% Now lets pick P and Q

while(true)
    P = Primes(randi(length(Primes)));
    Q = Primes(randi(length(Primes)));
    % We didnt randomly select the same number for P and Q, R-right?
    if P == Q
        continue
    end
    break
end

% Now lets call RSA and encrypt the message 
[N, Alice_Pub_Key, Bob_Pub_Key, C, Cs] = RSA(P,Q,M);

% I know N, since its part of the public key (n, e) so lets break it down
% into p and q to get the secret key.

[Break_P, Break_Q] = Shor(str2num(strtrim(num2str(N))));
oN = (Break_P-1)*(Break_Q-1);

% Now that I got oN I simply Use the EEA and the public keys of Alice and
% Bob and now I got their private keys.

[~, T] = EEA(oN,Alice_Pub_Key);
if T > 0
    Alice_Pri_Key = T;
else
    Alice_Pri_Key = oN + T;
end
[~, T] = EEA(oN,Bob_Pub_Key);
if T > 0 
    Bob_Pri_Key = T;
else
    Bob_Pri_Key = oN + T;
end

% Now what could Alice possibly have told Bob?

Break_Message = mod(C^Bob_Pri_Key,N);

% Did I successfully break RSA?

Break_Message = vpi(Break_Message);
if Break_Message == M
    disp("RSA Broken successfully, Alice's Message To Bob Was, " + num2str(Break_Message))
end

end