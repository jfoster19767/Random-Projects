function [N, Alice_Pub_Key, Bob_Pub_Key, C, Cs] = RSA(P,Q,M)
% find N
N = P*Q;
% find 0(N)
oN = (P-1)*(Q-1);
% Pick a value e such that the gcd (e,oN) == 1
Alice_Pub_Key = 2;
while(true)
    if EA(oN,Alice_Pub_Key) ~= 1   
        Alice_Pub_Key = Alice_Pub_Key + 1;
        continue
    end
    break
end
Bob_Pub_Key = Alice_Pub_Key + 1;
while(true)
    if EA(oN,Bob_Pub_Key) ~= 1   
        Bob_Pub_Key = Bob_Pub_Key + 1;
        continue
    end
    break
end
% find d
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

Alice_Pri_Key = vpi(Alice_Pri_Key);
Alice_Pub_Key = vpi(Alice_Pub_Key);
Bob_Pri_Key = vpi(Bob_Pri_Key);
Bob_Pub_Key = vpi(Bob_Pub_Key);

% The public key is Used to encrypt a plaintext
% The private key is used to decrypt a ciphertext

C = mod(M^Bob_Pub_Key,N);
disp("Alice's Encrypted Ciphertext to Bob is " + num2str(C))
%M = mod(C^Bob_Pri_Key,N);

% The digital signature, for alice lets make it 5.

Cs = mod(vpi(5)^Alice_Pri_Key,N);
disp("Alice's Encrypted Digital Signature to Bob is " + num2str(Cs))
%Ms = mod(Cs^Alice_Pub_Key,N);

disp("n = " + num2str(N))
disp("Alices public key is " + num2str(Alice_Pub_Key))
disp("Bobs public key is " + num2str(Bob_Pub_Key))

return

end