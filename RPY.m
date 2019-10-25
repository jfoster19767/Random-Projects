% Developed by Jason Foster 9/14/19
function RPY(Matrix)
% first we need to verify that the matrix we get is a legit 
% rotation matrix. Rotation matrices have a nice property where their 
% determinant is always 1. So lets check that

if det(Matrix) < 0.9990 || det(Matrix) > 1.0010
    disp("This is not a valid rotation matrix!");
    disp("Determinant should be 1, but was actually " + num2str(det(Matrix)));
    return
end

% If you got here our matrix is good... well probably
% so, how do I determine my angles?
% according to http://planning.cs.uiuc.edu/node103.html I can find them
% by performing the following equations

Yaw = atan2d(Matrix(2,1),Matrix(1,1));
Pitch = atan2d(-1*Matrix(3,1),sqrt(Matrix(3,2)^2 + Matrix(3,3)^2));
% Gimbal lock?
if Matrix(3,2) == 0 && Matrix(3,3) == 0
    Roll = atan2d(Matrix(1,2),Matrix(1,3));
else
    Roll = atan2d(Matrix(3,2),Matrix(3,3));
end

disp("Yaw in degrees =  " + num2str(Yaw));
disp("Pitch in degrees =  " + num2str(Pitch));
disp("Roll in degrees =  " + num2str(Roll));

return
end