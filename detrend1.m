function [CCC]=detrend1(O_data)
N=100;
% HH12=DataTransformation_TT(H12');
H=O_data;
k=length(H)/N;

AA=reshape(H,N,k);
BB=[];
for i=1:k-1
    
    TT=[AA(:,i)' AA(:,i+1)'];
    tt=1:length(TT);
    
    p=polyfit(tt,TT,2);
    BB(:,i)=polyval(p,tt)';  
    
end

CC=[];
for ii=1:k-1
    if ii==1
        CC(:,ii)=BB(1:N,ii);
    else
        CC(:,ii)=(BB((N+1):2*N,(ii-1))+BB(1:N,ii))/2;
    end
end

CC(:,k)=BB((N+1):2*N,k-1);
CCC=reshape(CC,1,numel(CC));


end