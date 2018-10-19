score=[
    1,1,1,0,0;
    3,3,3,0,0;
    4,4,4,0,0;
    5,5,5,0,0;
    0,2,0,4,4;
    0,0,0,5,5;
    0,1,0,2,2;
    ];
[U,S,V]=svd(score);
for i=1:length(S(1,:))
    if(S(i,i)<0.1)
        S(i,i)=0;
    end
end
i=1;
while S(i,i)~=0
    i=i+1;
end
i=i-1;
V=V';
Vr=V(1:i,:)';
Ur=U(:,1:i);
Sr=S(1:i,1:i);
