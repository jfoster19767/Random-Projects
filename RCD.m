function N = RCD(X,Y)
% Random Coordinate Descent developed by Jason Foster 10/16/2019
dimX = size(X);
N = zeros(dimX(2),1);
old_R = 0;
while(true)
    % First, pick a random row
    E = zeros(dimX(2),1);
    r = randi(dimX(2));
    % if the random index that gets picked is the same then the function
    % returns. . .
    if r == old_R
        continue
    end
    % 
    E(r) = 1;
    % Then project the current iterate onto that row
    M = N + (transpose(X(:,r))*(Y - X*N))/norm(X(:,r))^2 .*E;
    % Did we converge?
    if norm(M-N) < .000000000001
        return
    end
    N = M;
    old_R = r;
end
end