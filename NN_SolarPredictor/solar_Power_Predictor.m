clear all
clc
%%input G & Temp
%%input G
load('solar_data.mat');
Max1=max(Ginput(1,:));
Max2=max(Ginput(2,:));
Max3=max(Toutput(1,:));
Max4=max(Toutput(2,:));
Max5=max(Toutput(3,:));

Ginput(1,:)=Ginput(1,:)/Max1;
Ginput(2,:)=Ginput(2,:)/Max2;
Toutput(1,:)=Toutput(1,:)/Max3;
Toutput(2,:)=Toutput(2,:)/Max4;
Toutput(3,:)=Toutput(3,:)/Max5;
%save (norm1.mat,Max1,Max2,Max3,Max4,Max5)

P=Ginput;
Q=Toutput;
net = newff([min(Ginput(1,:)) 1;min(Ginput(2,:)) 1],[7 5 4 3],{'tansig' 'tansig' 'tansig' 'purelin'});
net.trainParam.epochs = 300;
%net.trainParam.goal = 0.007;
pv = train(net,P,Q);
gensim(pv,-1)

