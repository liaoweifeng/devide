%%绘制部分图所用
clear all
close all
load('191217_fs_1.mat')
[m,n]= size(A);
B = abs(A);
F= angle(A);

fs=500;
Wp=100/fs;Ws=108/fs;              
[nn,Wn]=buttord(Wp,Ws,1,6);    
% 设计Butterworth低通滤波器
[a0,b0]=butter(nn,Wn);
[h,f]=freqz(a0,b0,'whole',fs);        %求数字低通滤波器的频率响应
f=(0:length(f)-1*fs/length(f));     %进行对应的频率转换
% plot(f(1:length(f)/2),abs(h(1:length(f)/2)));       %绘制幅频响应图
% title('巴特沃斯低通滤波器');xlabel('频率/Hz');ylabel('幅度');
B1=[];
for i = 1:m
    y = hampel(B(i,:));
    y=hampel(y);
    B1=[B1
        y];
end


%%

% figure(1)
% f1=filter(a0,b0,F(5,:));
% f2=filter(a0,b0,F(10,:));
% f3=filter(a0,b0,F(15,:));
% f4=filter(a0,b0,F(20,:));
% f5=filter(a0,b0,F(25,:));
% plot(1:n,f1,".");hold on;
% plot(1:n,f2+2,".");hold on;
% plot(1:n,f3+3.2,".");hold on;
% plot(1:n,f4+6,".");hold on;
% plot(1:n,f5+8,".");
%  ylim([-2 10]) ;
%  
% set(gca,'XTick',[0:500:5000]) %x轴范围1-6，间隔1
% xticklabels({'0','1','2','3 ','4','5','6','7','8','9','10'  });
% set(gca,'YTick',[-2:2:10]) %y轴范围0-700，间隔100
% yticklabels({'','5','10','15','20','25',''})
% str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
% str2='\fontsize{12}\fontname{宋体}子载波索引';
% xlabel(str1);
% ylabel(str2);
%%
% figure(2)
% plot(1:n,B(5,:)-2.5,'LineWidth', 1.5);hold on;
% plot(1:n,B(10,:)-3,'LineWidth', 1.5);hold on;
% plot(1:n,B(15,:)+6.2,'LineWidth', 1.5);hold on;
% plot(1:n,B(20,:)+16,'LineWidth', 1.5);hold on;
% plot(1:n,B(25,:)+21,'LineWidth', 1.5);
% set(gca,'XTick',[0:500:5000]) %x轴范围1-6，间隔1
% xticklabels({'0','1','2','3','4','5','6','7','8','9','10'  });
% ylim([12 36]);
% set(gca,'YTick',[12:2:36])
% yticklabels({'','5','','','10','','15','','20','','25','',''})
%  str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
%  str2='\fontsize{12}\fontname{宋体}子载波索引';
%  xlabel(str1);
%  ylabel(str2);
% %  legend('\fontsize{12}\fontname{宋体}子载波\fontname{Time New Roman}5','\fontsize{12}\fontname{宋体}子载波\fontname{Time New Roman}10','\fontsize{12}\fontname{宋体}子载波\fontname{Time New Roman}15','\fontsize{12}\fontname{宋体}子载波\fontname{Time New Roman}20','\fontsize{12}\fontname{宋体}子载波\fontname{Time New Roman}25');
 
 %% 
%  A = B-ones(size(B,1),1)*mean(B);
%  A=A';
%  figure(3)
% %  image(A);
% mesh(A)
%  set(gca,'yTick',[0:500:5000]) %x轴范围1-6，间隔1
%  yticklabels({'0','1','2','3','4','5','6','7','8','9','10'});
%  str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
%  str2='\fontsize{12}\fontname{宋体}子载波索引';
%  ylabel(str1);
%  xlabel(str2);zlabel('\fontsize{12}\fontname{宋体}幅值')
 
 %%
% figure(4)
% plot(1:n,B(1,:)-mean(B(1,:)));hold on;
% plot(1:n,B(4,:)-mean(B(4,:))+2);hold on;
% plot(1:n,B(7,:)-mean(B(7,:))+4);hold on;
% plot(1:n,B(10,:)-mean(B(10,:))+6);hold on;
% plot(1:n,B(13,:)-mean(B(13,:))+8);hold on;
% plot(1:n,B(16,:)-mean(B(16,:))+10);hold on;
% plot(1:n,B(19,:)-mean(B(19,:))+12);hold on;
% plot(1:n,B(22,:)-mean(B(22,:))+14);hold on;
% plot(1:n,B(25,:)-mean(B(25,:))+16);hold on;
% plot(1:n,B(28,:)-mean(B(28,:))+18);
% set(gca,'XTick',[0:500:5000]) %x轴范围1-6，间隔1
% xticklabels({'0','1','2','3','4','5','6','7','8','9','10'  });
% ylim([-2 20]);
%  set(gca,'YTick',[-2:2:20])
% yticklabels({'','1','4','7','10','13','16','19','22','25','28',''})
%  str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
%  str2='\fontsize{12}\fontname{宋体}子载波索引';
%  xlabel(str1);
%  ylabel(str2);
 
 %% 小波去噪
 
   B2=[];
%   lv=5;
for i = 1:m
  y= wden(B1(i,:), 'sqtwolog', 's', 'sln', 3, 'sym5');
  
    B2=[B2
        y];
end

%  figure(5)
%  plot(B1(12,:));
%  set(gca,'XTick',[0:500:5000]) %x轴范围1-6，间隔1
%  xticklabels({'0','1','2','3','4','5','6','7','8','9','10'  });
%    str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
%   str2='\fontsize{12}\fontname{宋体}幅值';
%   xlabel(str1);
%  ylabel(str2);
%  figure(6)
%  plot(B2(12,:))
%   set(gca,'XTick',[0:500:5000]) %x轴范围1-6，间隔1
%  xticklabels({'0','1','2','3','4','5','6','7','8','9','10'  });
%    str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
%   str2='\fontsize{12}\fontname{宋体}幅值';
%    xlabel(str1);
%  ylabel(str2);

 %% 主成分分析与选择
 A1=B2;
 covarianceMatrix1 =A1*A1'/size(A1,2); %求出其协方差矩阵
%E是特征向量构成，它的每一列是特征向量，D是特征值构成的对角矩阵
%这些特征值和特征向量都没有经过排序
[E1, D1] = eig(covarianceMatrix1); 
[dummy1,order1] = sort(diag(-D1)); 
E1 = E1(:,order1);%将特征向量按照特征值大小进行降序排列，每一列是一个特征向量


%%
%表1
% d =-dummy1;
% su = sum(d);toal=zeros(1,90);
% for i =1:90
%     toal(i) = sum(d(1:i))/su;
% end
T = A1'*E1;
P=T(:,1:10)';
% figure(7)
% plot(1:n,P(1,:)-mean(P(1,:))-10);hold on;
% plot(1:n,P(2,:)-mean(P(2,:))+0);hold on;
% plot(1:n,P(3,:)-mean(P(3,:))+20);hold on;
% plot(1:n,P(4,:)-mean(P(4,:))+30);hold on;
% plot(1:n,P(5,:)-mean(P(5,:))+40);hold on;
% plot(1:n,P(6,:)-mean(P(6,:))+50);hold on;
% plot(1:n,P(7,:)-mean(P(7,:))+60);hold on;
% plot(1:n,P(8,:)-mean(P(8,:))+70);hold on;
% plot(1:n,P(9,:)-mean(P(9,:))+80);hold on;
% plot(1:n,P(10,:)-mean(P(10,:))+90);
% set(gca,'XTick',[0:500:5000]) %x轴范围1-6，间隔1
% xticklabels({'0','1','2','3','4','5','6','7','8','9','10'  });
% str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
% str2='\fontsize{12}\fontname{宋体}幅值';
% xlabel(str1);
% ylabel(str2);
 %legend('\fontsize{12}\fontname{Time New Roman}sub-signal 1','\fontsize{12}\fontname{Time New Roman}sub-signal 2','\fontsize{12}\fontname{Time New Roman}sub-signal 3','\fontsize{12}\fontname{Time New Roman}sub-signal 4','\fontsize{12}\fontname{Time New Roman}sub-signal 5','\fontsize{12}\fontname{Time New Roman}sub-signal 6','\fontsize{12}\fontname{Time New Roman}sub-signal 7','\fontsize{12}\fontname{Time New Roman}sub-signal 8','\fontsize{12}\fontname{Time New Roman}sub-signal 9','\fontsize{12}\fontname{Time New Roman}
 %legend('\fontsize{12}\fontname{Time New Roman}sub-signal 1','\fontsize{12}\fontname{Time New Roman}sub-signal 2','\fontsize{12}\fontname{Time New Roman}sub-signal 3','\fontsize{12}\fontname{Time New Roman}sub-signal 4','\fontsize{12}\fontname{Time New Roman}sub-signal 5','\fontsize{12}\fontname{Time New Roman}sub-signal 6','\fontsize{12}\fontname{Time New Roman}sub-signal 7','\fontsize{12}\fontname{Time New Roman}sub-signal 8','\fontsize{12}\fontname{Time New Roman}sub-signal 9','\fontsize{12}\fontname{Time New Roman}sub-signal 10');



[S,T,F,P]=spectrogram(a2,500,250,512,40);
DbP2=10*log10(abs(P));
% imagesc(DbP2)
% ylim([0 100]);
% zlim([-100 20]);
% set(gca,'XTick',[0:0.5:6]) %x轴范围1-6，间隔1
% xticklabels({'0','','1','','1.5','','2','','2.5','','3'});
% str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
% str2='\fontsize{12}\fontname{宋体}频率\fontname{Time New Roman}(Hz)';
% xlabel(str1);
% ylabel(str2)

 
%  figure(19);
% [S,T,F,P]=spectrogram(a3,500,250,512,40);
% DbP3=10*log10(abs(P));
% imagesc(DbP3)
% ylim([0 100]);
% zlim([-100 20]);
% set(gca,'XTick',[0:0.5:6]) %x轴范围1-6，间隔1
% xticklabels({'0','','1','','1.5','','2','','2.5','','3'});
% str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
% str2='\fontsize{12}\fontname{宋体}频率\fontname{Time New Roman}(Hz)';
% xlabel(str1);
% ylabel(str2)

%%
%特征增强
[m1,n1]=size(DbP2(1:100,:));

% figure(20)
% lab1=randsrc(m1,n1,[0,1; 0.97,0.03]);
% [r,c]=find(lab1==1)
% 
% for i = 1:length(c)
%      DbP2(r(i),c(i)) = mean(mean(DbP2));
% end

% figure(21)
len = length(a2);
Fs = 500*0.96;
t=(0:len-1)/Fs;
% sigma=0.05;
% t2=a2 + sigma*randn(size(t));
% [S,T,F,P]=spectrogram(t2,500,250,512,40);
% DbP2=10*log10(abs(P));

% figure(22)
%  t3 = resample(a2,480,500);
%  [S,T,F,P]=spectrogram(t3,480,240,512,40);
% DbP2=10*log10(abs(P));

% figure(23)
% t4 = resample(a2,510,500);
% [S,T,F,P]=spectrogram(t4,510,260,512,40);

% figure(24)
% [S,T,F,P]=spectrogram(a2,500,250,512,40);
% DbP2=10*log10(abs(P));
% DbP2= DbP2*0.98;
% DbP3= DbP2*1.02;
% imagesc(DbP2)
% ylim([0 100]);
% zlim([-100 20]);
% set(gca,'XTick',[0:0.5:6]) %x轴范围1-6，间隔1
% xticklabels({'0','','1','','1.5','','2','','2.5','','3'});
% str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
% str2='\fontsize{12}\fontname{宋体}频率\fontname{Time New Roman}(Hz)';
% xlabel(str1);
% ylabel(str2);
% 
% figure(25)
% imagesc(DbP3)
% ylim([0 100]);
% zlim([-100 20]);
% set(gca,'XTick',[0:0.5:6]) %x轴范围1-6，间隔1
% xticklabels({'0','','1','','1.5','','2','','2.5','','3'});
% str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
% str2='\fontsize{12}\fontname{宋体}频率\fontname{Time New Roman}(Hz)';
% xlabel(str1);
% ylabel(str2);

%  fallwalk sitrun
% segans = [
% 0.963 	0.996	0.923 0.975	;%
% 0.997 	1	0.995 0.982	]';
% bar(segans);
% ylim([0.5 1.1]) 
% xticklabels({'跌倒','行走','坐下 ','跑动' });
% ylabel('\fontname{宋体}准确率') 
% % for i = 1:4
% %     text(i-0.15,segans(i,1)+0.015,num2str(segans(i,1),'%.2f'),'VerticalAlignment','middle','HorizontalAlignment','center','fontname','Times New Roman')
% %      text(i+0.15,segans(i,2)+0.015,num2str(segans(i,2),'%.2f'),'VerticalAlignment','middle','HorizontalAlignment','center','fontname','Times New Roman')
% % end
% legend('展览室 ','实验室 ');

% % derta 0.05	0.07	0.09	0.1 	0.15	0.2 	0.3 	0.5
% segcon = [0.622731614	0.695319962	0.730659026	0.685768863	0.61282256	0.556829035	0.415472779	0.191977077;
%     0.822291504	0.822291504	0.822291504	0.822291504	0.822291504	0.822291504	0.822291504	0.822291504	;
% 0.70537802 0.70537802 0.70537802 0.70537802 0.70537802 0.70537802 0.70537802 0.70537802;
% 0.9785 0.9785 0.9785 0.9785 0.9785 0.9785 0.9785 0.9785 ];
% x=1:1:8;
% plot(x,segcon(1,:),'-*b',x,segcon(2,:),'-or',x,segcon(3,:),x,segcon(4,:)); %线性，颜色，标记
% axis([0,9,0,1.2])  %确定x轴与y轴框图大小
% set(gca,'XTick',[0:1:9]) %x轴范围1-6，间隔1
% set(gca,'YTick',[0:0.1:1.2]) %y轴范围0-700，间隔100
% legend('TW-see','WiAG','Wi-Multi','Ours');   %右上角标注
% xlabel('\fontname{times new roman}Treshold')  %x轴坐标描述
% xticklabels({'','0.05','0.07','0.06 ','0.1','0.15','0.2','0.3','0.5' });
% ylabel('\fontname{times new roman}Accuracy') %y轴坐标描述
%%
% figure(100)
% a2=[0.751 0.943;
%     0.710 0.924];
% bar(a2);
% xticklabels({'展览室','实验室'});
%  legend('\fontsize{12}\fontname{宋体}自相关矩阵法','\fontsize{12}\fontname{宋体}频谱能量变化法','location','SouthEast');
% set(gca,'FontSize',12);
%  str1='\fontsize{16}\fontname{宋体}实验场景';
% str2='\fontsize{16}\fontname{宋体}准确率';
% xlabel(str1);
% ylabel(str2)


 % figure(26)
% % 
% ACC316 = [ 0.841 0.927 0.874 0.897 0.915 0.867 0.869 0.943 ];
% ACC501 = [0.80 0.859 0.815 0.807 0.839 0.802 0.844 0.924 ];
% AAA=[ACC316
%     ACC501];
% bar(AAA');
% xticklabels({'原始特征','频谱重置','加噪','降采样','上采样','频谱衰减','频谱增强','全部'});
% ylabel('\fontname{宋体}准确率') 
% legend('展览室 ','实验室 ');

% 501 316
% figure(28)
% ACCcomp=[ 0.756 0.872 0.843 0.805 0.942;
%     0.723 0.882 0.865  0.793  0.924;]
%     
% bar(ACCcomp')
% xticklabels({'Random Forest','SVM','KNN','BP-net','Proposed'});
% ylabel('\fontname{宋体}准确率') 
% legend('展览室 ','实验室 ');

%%
%多系统识别对比
% W-SEE TW-SEE OUR
%01234 静止 跑 跌倒 坐 走
% figure(29)

% %501
% acccompare1=[0.96 0.98 0.84 0.82 0.85;
%     0.999 0.99 0.71 0.88 0.80;
% 0.999 0.94 0.90 0.97 0.88];
% bar(acccompare1')
% xticklabels({'静止','跑动','跌倒','坐下','行走'});
% ylabel('\fontname{宋体}准确率') 
% legend('Wi-Chase ','TW-see','本文所出的系统');
% xlabel('\fontname{宋体}活动类别') 
% %316
% acccompare2=[0.99 0.94 0.79 0.83 0.86;
%     0.99 0.95 0.86 0.85 0.86;
% 0.99 0.97 0.94 0.89 0.89];
% figure(30)
% bar(acccompare2')
% xticklabels({'静止','跑动','跌倒','坐下','行走'});
% ylabel('\fontname{宋体}准确率') 
% legend('Wi-Chase ','TW-see','本文所出的系统');
% xlabel('\fontname{宋体}活动类别') 

%%
figure(30)
% %训练数据集大小的影响
% % 0.1 0.3 0.5 0.7 0.9
% % 501 316
% ac=[0.330450267107606,0.590582079790713,0.754008245533669,0.793287566742944,0.919863013698630;
%     0.318812773628638,0.617904667328699,0.746524559777572,0.838610038610039,0.932193995381062];
% % 
% % % str1='\fontsize{12}\fontname{宋体}时间\fontname{Time New Roman}(s)';
% % % str2='\fontsize{12}\fontname{宋体}频率\fontname{Time New Roman}(Hz)';
% % % xlabel(str1);
% % % ylabel(str2);
% % 
% bar(ac')
% set(gca,'FontSize',12);
% xticklabels({'10%','30%','50%','70%','90%'});
% ylabel('\fontsize{14}\fontname{宋体}准确率') 
% legend('\fontsize{12}\fontname{宋体}展览室','\fontsize{12}\fontname{宋体}实验室','location','SouthEast');
% xlabel('\fontsize{14}\fontname{宋体}训练集所占百分比') 

%%
% figure(31)
% a=[0.973333333333333,0.696613995485327,0.352718078381795,0.459944751381216,0.692840646651270;
%     0.984761904761905,0.701973001038422,0.489388264669164,0.47737478411054,0.648925281473900]
% bar(a')
% xticklabels({'静止','跑动','跌倒','坐下','行走'});
% set(gca,'FontSize',12);
% ylabel('\fontsize{14}\fontname{宋体}准确率') 
% legend('\fontsize{12}\fontname{宋体}展览室','\fontsize{12}\fontname{宋体}实验室','location','SouthEast');
% xlabel('\fontsize{14}\fontname{宋体}活动类别') 

%  for i = 1:5
%      text(i-0.15,segans(i,1)+0.02,num2str(segans(i,1),'%.2f'),'VerticalAlignment','middle','HorizontalAlignment','center','fontname','Times New Roman')
%      text(i+0.15,segans(i,2)+0.02,num2str(segans(i,2),'%.2f'),'VerticalAlignment','middle','HorizontalAlignment','center','fontname','Times New Roman')
% end

% legend('Exhibition Room ','Laboratory ');