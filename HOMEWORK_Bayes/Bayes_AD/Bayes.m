%使用朴素贝叶斯估计广告的点击率 

A=train(:,2:15);
B=test(:,2:14);  %提取待使用数据
A0=[];A1=[];
for i=1:length(A(:,1)) %按照未点击-点击分类样本
    if(A(i,1)==0)
        A0=[A0;A(i,2:14)];
    else
        A1=[A1;A(i,2:14)];
    end
end

pw0=length(A0(:,1))/length(A(:,1)); %假设test与train的广告点击概率一致p(wi)
pw1=1-pw0;
for j=1:13                              %计算各特征的p(θ|wi)
    [n0(j),s0(j)]=normfit(A0(:,j));
    [n1(j),s1(j)]=normfit(A1(:,j));
end
predt=ones(length(B(:,1)),2);
for i=1:length(B(:,1))                  %计算p(wi|X)，由于p(X)一致，不计算
    for j=1:13
        predt(i,1)=predt(i,1)*normpdf(B(i,j),n0(j),s0(j));
        predt(i,2)=predt(i,2)*normpdf(B(i,j),n1(j),s1(j));
    end
    predt(i,1)=predt(i,1)*pw0;
    predt(i,2)=predt(i,2)*pw1;
end
ansa=[];
   for i=1:length(predt(:,1))           %由于是点击-未点击的二分类，故使用下式计算归一化后的点击概率
       ansa(i,1)=predt(i,2)/(predt(i,1)+predt(i,2));
   end
   csvwrite('ans.csv',ansa,1);
