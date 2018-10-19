function [ B ] = delta_J( X,Y )
%X=[--x--1]
%Y=[y]

B=((X'*X)^-1)*(X')*Y;
end

