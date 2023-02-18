function [Times]=Copy_of_Segmentaion(dataVar,threshold)

Times=[];
[mm,n]=size(dataVar);
i=0;
k=1;
M=threshold;
N=300;

if (max(dataVar)> M)
    
    lefFlag=1;
    RigFlag=1;
    i=i+1;
    [maxVal,index]=max(dataVar);
    indexLeft=index;
    indexRight=index;
    
    while  lefFlag==1
        if indexLeft-N<0
            Nlef=1;
            dataLeft=dataVar(Nlef:indexLeft-1);
            [rLef,cLef,vLef] = find(dataLeft>M);
            if isempty(cLef)
             lefFlag=0;
            else
             lefIndChg=min(cLef);
             indexLeft=1;
            end
        else
            Nlef=indexLeft-N;
        end
        dataLeft=dataVar(Nlef:indexLeft-1);
        [rLef,cLef,vLef] = find(dataLeft>M);
        if isempty(cLef)
            lefFlag=0;
        else
            lefIndChg=min(cLef);
            indexLeft=indexLeft-(N-lefIndChg+1);
        end
    end
    
    while  RigFlag==1
        if indexRight+N>n
            Nrig=n;
        else
            Nrig=indexRight+N;
        end
        dataRight=dataVar(indexRight+1:Nrig);
        [rRig,cRig,vRig] = find(dataRight>M);
        if isempty(cRig)
            RigFlag=0;
        else
            rigIndChg=max(cRig);
            indexRight=indexRight+rigIndChg;
        end
    end
    
    if indexRight-indexLeft<300
        Times=[];
    else
    Times(i,1)=indexLeft;Times(i,2)=indexRight;
    end
      dataVar(indexLeft:indexRight)=0;
      if max(dataVar)>M
          [Times1]=Copy_of_Segmentaion(dataVar,M);
          Times=[Times,
                 Times1];
        end
end
    
end

