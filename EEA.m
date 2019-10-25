function [S, T] = EEA(A,B)
% First lets initilize our first round values
r0 = A;
r1 = B;
new_r2 = r0 - r1;
cuts = 1;
round = 1;
S0 = 1;
T0 = 0;
S1 = 0;
T1 = 1;
Q1 = 0;
while(true)
    if new_r2 >= r1
        new_r2 = new_r2 - r1;
        cuts = cuts + 1;
        continue
    end
    Q2 = Q1;
    Q1 = cuts;
    if round >= 2
        S2 = S0 - Q2*S1;
        S0 = S1;
        S1 = S2;
        T2 = T0 - Q2*T1;
        T0 = T1;
        T1 = T2;
    end
    if new_r2 == 0
        S = S2;
        T = T2;
        return
    end
    % We need a new iteration
    r0 = r1;
    r1 = new_r2;
    new_r2 = r0 - r1;
    cuts = 1;
    round = round + 1;
end

end