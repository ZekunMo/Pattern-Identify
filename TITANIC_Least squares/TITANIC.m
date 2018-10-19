DATA=[train{:,3}];
for i=1:length(train(:,1))
    if strcmp(train{i,5},'male')
        SEX(i)=0;
    else
        SEX(i)=1;
    end
end
DATA=[DATA; SEX];
DATA=[DATA ;train{:,6}];
DATA=[DATA ;train{:,7}];
DATA=[DATA ;train{:,8}];
DATA=[DATA ;train{:,10}];
DATA=DATA';
DATA=[DATA ones(length(DATA(:,1)),1)];
Y=[train{:,2}]';
B=delta_J(DATA,Y);
TEST=[test{:,2}];
for i=1:length(test(:,1))
    if strcmp(test{i,4},'male')
        SEXT(i)=0;
    else
        SEXT(i)=1;
    end
end
TEST=[TEST; SEXT];
TEST=[TEST; test{:,5}];
TEST=[TEST; test{:,6}];
TEST=[TEST; test{:,7}];
TEST=[TEST; test{:,9}];
TEST=TEST';
TEST=[TEST ones(length(TEST(:,1)),1)];
ANS=TEST*B;
for i=1:length(ANS)
    if ANS(i)>0.5
        ANS(i)=1;
    else
        ANS(i)=0;
    end
end
ANS=[test{:,1};ANS'];
ANS=ANS';

csvwrite('ANS.csv',ANS)