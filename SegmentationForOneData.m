%%%%
%�����������еĶ���������зָ���ȡ
clear all
close all
%%
%��ȡ����
load('191217_fs_1.mat')
[m,n]= size(A);
B = abs(A);
F= angle(A);
%%
% ���Butterworth��ͨ�˲���
fs=500;
Wp=100/fs;Ws=108/fs;              
[nn,Wn]=buttord(Wp,Ws,1,6);    
[a0,b0]=butter(nn,Wn);
[h,f]=freqz(a0,b0,'whole',fs);        %�����ֵ�ͨ�˲�����Ƶ����Ӧ
f=(0:length(f)-1*fs/length(f));     %���ж�Ӧ��Ƶ��ת��
%%
%�쳣ֵȥ��������
B1=[];
for i = 1:m
    y = hampel(B(i,:));
    y=hampel(y);
    B1=[B1
        y];
end
%% 
% С��ȥ�룬����
B2=[];
for i = 1:m
y= wden(B1(i,:), 'sqtwolog', 's', 'sln', 3, 'sym5');
B2=[B2
   y];
end
%% 
% ���ɷַ�����ѡ�񣬿ռ併ά
A1=B2;
covarianceMatrix1 =A1*A1'/size(A1,2); %�����Э�������
[E1, D1] = eig(covarianceMatrix1); 
[dummy1,order1] = sort(diag(-D1)); 
E1 = E1(:,order1);%������������������ֵ��С���н������У�ÿһ����һ����������
T = A1'*E1;
P=T(:,1:10)';%ǰʮ���ӿռ��ź�
%%
%�ӿռ��ں��ź�
[ranks,weights] = relieff(P,1:length(P(:,2)),3);
t=zeros(1,length(P(:,1)));
weightsT=0;
for i=1:5
    t=weights(i)*P(:,i)+t;
    weightsT=weightsT+weights(i);
end
t=t/weightsT;
%%
%�ֶ����ȥ��
[detrend_t]=detrend(t);
%%
%���㻬������
for i=1:length(detrend_t)-50
    SlapVar(i)=var(detrend_t(i:50+i-1));
end
%%
%��������Ӧ��ֵ
[threshold]=findThreshold(SlapVar);
%%
%�ָ�
[Times]=Segmentaion(SlapVar,threshold);%�ָ���Ľ��







