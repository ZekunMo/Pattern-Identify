%SVD压缩图片测试

A=imread('A.png'); %读取图片
A=double(A);
AR=A(:,:,1);
AG=A(:,:,2);
AB=A(:,:,3); %分通道
[UR,SR,VR]=svd(AR);
[UG,SG,VG]=svd(AG);
[UB,SB,VB]=svd(AB); %SVD分解
K=1000; %设置r
URr=UR(:,1:K);UGr=UG(:,1:K);UBr=UB(:,1:K);
SRr=SR(1:K,1:K);SGr=SG(1:K,1:K);SBr=SG(1:K,1:K);
VRr=VR(:,1:K);VGr=VG(:,1:K);VBr=VB(:,1:K); %取压缩后USV
BR=URr*SRr*VRr'; %拼回图片
BG=UGr*SGr*VGr';
BB=UBr*SBr*VBr';
B(:,:,1)=BR;
B(:,:,2)=BG;
B(:,:,3)=BB;
B=uint8(fix(B));
figure(1);
imshow(B); %显示图片
