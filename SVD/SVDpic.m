%SVDѹ��ͼƬ����

A=imread('A.png'); %��ȡͼƬ
A=double(A);
AR=A(:,:,1);
AG=A(:,:,2);
AB=A(:,:,3); %��ͨ��
[UR,SR,VR]=svd(AR);
[UG,SG,VG]=svd(AG);
[UB,SB,VB]=svd(AB); %SVD�ֽ�
K=1000; %����r
URr=UR(:,1:K);UGr=UG(:,1:K);UBr=UB(:,1:K);
SRr=SR(1:K,1:K);SGr=SG(1:K,1:K);SBr=SG(1:K,1:K);
VRr=VR(:,1:K);VGr=VG(:,1:K);VBr=VB(:,1:K); %ȡѹ����USV
BR=URr*SRr*VRr'; %ƴ��ͼƬ
BG=UGr*SGr*VGr';
BB=UBr*SBr*VBr';
B(:,:,1)=BR;
B(:,:,2)=BG;
B(:,:,3)=BB;
B=uint8(fix(B));
figure(1);
imshow(B); %��ʾͼƬ
