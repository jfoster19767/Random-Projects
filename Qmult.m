function [W, X, Y, Z] = Qmult(q1, q2)
% Function developed by Jason Foster 9/21/19
% Lets take our quats as a matrix

a = q1(1);
b = q1(2);
c = q1(3);
d = q1(4);

e = q2(1);
f = q2(2);
g = q2(3);
h = q2(4);

W = a*e - b*f - c*g - d*h;
X = a*f + b*e + c*h - d*g;
Y = a*g - b*h + c*e + d*f;
Z = a*h + b*g - c*f + d*e;
return
end