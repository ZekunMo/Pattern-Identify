%ʹ�����ر�Ҷ˹����̩̹����Ҵ���
%TRAIN,TEST���Ѿ���ȡ�õ���������

A0=[];A1=[];AGE=[];
for i=1:length(TRAIN(:,1))
    if(TRAIN(i,4)~=0)
        AGE=[AGE;TRAIN(i,2:7)]; %������䲻Ϊ������
    end
end
DATA=[AGE(:,1),AGE(:,2),AGE(:,4),AGE(:,5),ones(length(AGE(:,1)),1)];%ƴ����������
Y=AGE(:,3); %����
S=((DATA'*DATA)^-1)*(DATA')*Y; %�������
for i=1:length(TRAIN(:,1))
    if(TRAIN(i,4)==0) %�ҳ�����Ϊ������ ������С���˷���������
        TRAIN(i,4)=TRAIN(i,2)*S(1)+TRAIN(i,3)*S(2)+TRAIN(i,5)*S(3)+TRAIN(i,6)*S(4)+S(5); 
    end
end
for i=1:length(TEST(:,1))
    if(TEST(i,3)==0)
        TEST(i,3)=TEST(i,1)*S(1)+TEST(i,2)*S(2)+TEST(i,4)*S(3)+TEST(i,5)*S(4)+S(5);
    end
end
for i=1:length(TRAIN(:,1)) %����δ���-�����������
    if(TRAIN(i,1)==0)
        A0=[A0;TRAIN(i,2:7)];
    else
        A1=[A1;TRAIN(i,2:7)];
    end
    
end

pw0=length(A0(:,1))/length(TRAIN(:,1)); 
pw1=1-pw0;
                            %�����������p(��|wi)
    [n(1),s(1)]=normfit(A0(:,3));
    [n(2),s(2)]=normfit(A1(:,3));
    [n(3),s(3)]=normfit(A0(:,6));
    [n(4),s(4)]=normfit(A1(:,6));
    
    countc=zeros(3,2);
    countf=zeros(2,2);
    counts=zeros(10,2);
    countp=zeros(10,2);
    for i=1:length(A0(:,1))  %��������µ���������
        for j=1:3  %ͳ�ƿͲյȼ�
            if(A0(i,1)==j)
               countc(j,1)=countc(j,1)+1; 
               break;
            end
        end
        if(A0(i,2)==0) %�ֱ�ͳ���Ա�����
            countf(1,1)=countf(1,1)+1; 
        else
            countf(2,1)=countf(2,1)+1; 
        end
        for j=1:10
            if(A0(i,4)==j-1)
               counts(j,1)=counts(j,1)+1; 
               break;
            end
        end  %ͳ���ֵܽ�����ż
        for j=1:10
            if(A0(i,5)==j-1)
               countp(j,1)=countp(j,1)+1; 
               break;
            end
        end  %ͳ�Ƹ�ĸ����
    end
    pwc(1:3,1)=countc(1:3,1)/ length(A0(:,1));  %�������
    pwf(1:2,1)=countf(1:2,1)/ length(A0(:,1));
    pws(1:10,1)=counts(1:10,1)/ length(A0(:,1));
    pwp(1:10,1)=countp(1:10,1)/ length(A0(:,1));
      
    for i=1:length(A1(:,1))
        for j=1:3
            if(A1(i,1)==j)
               countc(j,2)=countc(j,2)+1; 
               break;
            end
        end
        if(A1(i,2)==0)
            countf(1,2)=countf(1,2)+1; 
        else
            countf(2,2)=countf(2,2)+1; 
        end
        for j=1:10
            if(A1(i,4)==j-1)
               counts(j,2)=counts(j,2)+1; 
               break;
            end
        end
        for j=1:10
            if(A1(i,5)==j-1)
               countp(j,2)=countp(j,2)+1; 
               break;
            end
        end
    end
    pwc(1:3,2)=countc(1:3,2)/ length(A1(:,1)); 
    pwf(1:2,2)=countf(1:2,2)/ length(A1(:,1));
    pws(1:10,2)=counts(1:10,2)/ length(A1(:,1));
    pwp(1:10,2)=countp(1:10,2)/ length(A1(:,1));
            
 B=TEST(:,1:6);   
predt=ones(length(B(:,1)),2);
for i=1:length(B(:,1))                  %����p(wi|X)������p(X)һ�£�������
    
        predt(i,1)=predt(i,1)*normpdf(B(i,3),n(1),s(1)); %��֪��������������
        predt(i,2)=predt(i,2)*normpdf(B(i,3),n(2),s(2)); %��֪�������Ҵ����
        predt(i,1)=predt(i,1)*normpdf(B(i,6),n(3),s(3)); %��֪��Ʊ����������
        predt(i,2)=predt(i,2)*normpdf(B(i,6),n(4),s(4)); %��֪��Ʊ���Ҵ����
        %��֪��ɢ��������������
        predt(i,1)=predt(i,1)*pwc(B(i,1),1)*pwf(B(i,2)+1,1)*pws(B(i,4)+1,1)*pwp(B(i,5)+1,1); 
        %��֪��ɢ��������������
        predt(i,2)=predt(i,2)*pwc(B(i,1),2)*pwf(B(i,2)+1,2)*pws(B(i,4)+1,2)*pwp(B(i,5)+1,2);
   
    predt(i,1)=predt(i,1)*pw0;
    predt(i,2)=predt(i,2)*pw1;
end
predt=predt';
[~,ansa]=max(predt); %�ҳ����ʴ��Ԫ��λ��
ansa=ansa'-1; %��Ϊ0-1ֵ

   csvwrite('ans.csv',ansa,1);
