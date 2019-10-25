function N = RK(X,Y)
% Random Kaczmarz algorithm developed by Jason Foster 10/15/2019
dimX = size(X);
N = zeros(dimX(2),1);
old_R = 0;
while(true)
    % First, pick a random row
    r = randi(length(X));
    % if the random index that gets picked is the same then the function
    % returns. . .
    if r == old_R
        continue
    end
    % Then project the current iterate onto that row
    M = N + ((Y(r) - X(r,:)*N) / norm(X(r,:))^2)*transpose(X(r,:));
    % Did we converge?
    if norm(M-N) < .000000000001
        return
    end
    N = M;
    old_R = r;
end
end