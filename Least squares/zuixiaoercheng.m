%曲线拟合
%xi 1  3 4 5 6 7 8 9 10
%yi 10 5 4 2 1 1 2 3 4
%待拟合函数：y=ax^2+bx+c

% 最小二乘
n=9;d=2;
x1n=[1,9,16,25,36,49,64,81,100]';
x2n=[1,3,4,5,6,7,8,9,10]';
y=[10,5,4,2,1,1,2,3,4]';
X=[x1n,x2n,ones(n,1)];
B=delta_J(X,y);
a=B(1)
b=B(2)
c=B(3)
% 梯度下降
B=zeros(d+1,1);
Y=y;
alpha=0.0002; %学习率
step=1;
while abs( 1/n*(Y-X*B)'*(Y-X*B))>0.1 && step<400000
   B=B-2/n*(-X'*Y+X'*X*B)*alpha;
   step=step+1;
end
a1=B(1)
b1=B(2)
c1=B(3)