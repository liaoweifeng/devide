%%%%
%将单条数据中的多个动作进行分割提取
clear all
close all
%%
%读取数据
load('191217_fs_1.mat')
[m,n]= size(A);
B = abs(A);
F= angle(A);
%%
% 设计Butterworth低通滤波器
fs=500;
Wp=100/fs;Ws=108/fs;              
[nn,Wn]=buttord(Wp,Ws,1,6);    
[a0,b0]=butter(nn,Wn);
[h,f]=freqz(a0,b0,'whole',fs);        %求数字低通滤波器的频率响应
f=(0:length(f)-1*fs/length(f));     %进行对应的频率转换
%%
%异常值去除，逐行
B1=[];
for i = 1:m
    y = hampel(B(i,:));
    y=hampel(y);
    B1=[B1
        y];
end
%% 
% 小波去噪，逐行
B2=[];
for i = 1:m
y= wden(B1(i,:), 'sqtwolog', 's', 'sln', 3, 'sym5');
B2=[B2
   y];
end
%% 
% 主成分分析与选择，空间降维
A1=B2;
covarianceMatrix1 =A1*A1'/size(A1,2); %求出其协方差矩阵
[E1, D1] = eig(covarianceMatrix1); 
[dummy1,order1] = sort(diag(-D1)); 
E1 = E1(:,order1);%将特征向量按照特征值大小进行降序排列，每一列是一个特征向量
T = A1'*E1;
P=T(:,1:10)';%前十个子空间信号
%%
%子空间融合信号
[ranks,weights] = relieff(P,1:length(P(:,2)),3);
t=zeros(1,length(P(:,1)));
weightsT=0;
for i=1:5
    t=weights(i)*P(:,i)+t;
    weightsT=weightsT+weights(i);
end
t=t/weightsT;
%%
%分段拟合去噪
[detrend_t]=detrend(t);
%%
%计算滑动方差
for i=1:length(detrend_t)-50
    SlapVar(i)=var(detrend_t(i:50+i-1));
end
%%
%计算自适应阈值
[threshold]=findThreshold(SlapVar);
%%
%分割
[Times]=Segmentaion(SlapVar,threshold);%分割出的结果







