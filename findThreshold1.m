function [threshold]=findThreshold1(varDev)


A=[];
N=length(varDev)/25;
Data = reshape(varDev,25,N);
Aa=mean(Data);
Ab=var(Data);
[r,c,v] = find(varDev<0.1);


A(c)=1;
B=[];
for i1=1:length(A)
    if i1==1
        B(i1)=A(i1);
    else
        B(i1)=A(i1)-A(i1-1);
    end
end

[r1,c1,v1] = find(B==1);
[r2,c2,v2] = find(B==-1);


D=c2-c1(1:length(c2));
[maxvalue,idx_max]=max(D);
indexle=c1(idx_max)*25;
indexri=c2(idx_max)*25;
val=varDev(indexle:indexri);
% test=mean(val);
b=sort(abs(val));
threshold = prctile(b,98);

% for i=1:length(varDev)
%     if varDev(i)>(1+1.8)*test&&varDev(i)<(1+3)*test;
%         threshold=varDev(i);
%         break;
%     end
% end
%  threshold=(1+1.8)*test;
end