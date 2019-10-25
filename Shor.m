% Shor's Factoring Algorithm
% Developed by Jason Foster 9/26/19
function [P, Q] = Shor(N)
tic
working = true;
% So for the first step we need to pick an a
A = 2;
while(working)
% Second step, do math. start R at 2 and increment by 2 since thats the
% range of realistic values that could work
for R = 2:2:N-1
    if mod(A^R,N) == 1 % Possible match
        T = mod(A^(R/2),N);
        P = gcd(T+1,N);
        Q = gcd(T-1,N);
        if P == 1 || P == N % Not a match
            continue
        end
        toc
        return
    end
    
end

% if we got here we had a bad a
A = A + 1;

if A == N % Just in case
    working = false;
end
end
end