%ʹ�����ر�Ҷ˹���ƹ��ĵ���� 

A=train(:,2:15);
B=test(:,2:14);  %��ȡ��ʹ������
A0=[];A1=[];
for i=1:length(A(:,1)) %����δ���-�����������
    if(A(i,1)==0)
        A0=[A0;A(i,2:14)];
    else
        A1=[A1;A(i,2:14)];
    end
end

pw0=length(A0(:,1))/length(A(:,1)); %����test��train�Ĺ��������һ��p(wi)
pw1=1-pw0;
for j=1:13                              %�����������p(��|wi)
    [n0(j),s0(j)]=normfit(A0(:,j));
    [n1(j),s1(j)]=normfit(A1(:,j));
end
predt=ones(length(B(:,1)),2);
for i=1:length(B(:,1))                  %����p(wi|X)������p(X)һ�£�������
    for j=1:13
        predt(i,1)=predt(i,1)*normpdf(B(i,j),n0(j),s0(j));
        predt(i,2)=predt(i,2)*normpdf(B(i,j),n1(j),s1(j));
    end
    predt(i,1)=predt(i,1)*pw0;
    predt(i,2)=predt(i,2)*pw1;
end
ansa=[];
   for i=1:length(predt(:,1))           %�����ǵ��-δ����Ķ����࣬��ʹ����ʽ�����һ����ĵ������
       ansa(i,1)=predt(i,2)/(predt(i,1)+predt(i,2));
   end
   csvwrite('ans.csv',ansa,1);
