function g = EA(A,B) 
% First lets initilize our first round values
r0 = A;
r1 = B;
new_r2 = r0 - r1;
while(true)
    if new_r2 >= r1
        new_r2 = new_r2 - r1;
        continue
    end
    if new_r2 == 0
        g = r1;
        return
    end
    % We need a new iteration
    r0 = r1;
    r1 = new_r2;
    new_r2 = r0 - r1;
end
end