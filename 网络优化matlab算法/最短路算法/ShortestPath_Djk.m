%���룺Ȩ�ؾ���Cost,�ܵĽڵ���CrossPointNo�����StartPoint���յ�EndPoint
%�������㵽����ÿ���������С���룬·�����󣬲���ӡһ����㵽�յ����·
function [Min_Distance,Path]=ShortestPath_Djk(Cost,StartPoint,EndPoint)
    [CrossPointNo,y] = size(Cost);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:CrossPointNo
        for j=1:CrossPointNo
            Min_Dist(i,j)=Cost(i,j);
            Muti_Path(i,j)=StartPoint;
            IsFinal(i,j)=0;
        end
    end
    IsFinal(StartPoint,StartPoint)=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j=1:(CrossPointNo-1)    %%%%%%%pure CrossPointNo-1        
   	MinPathDist=inf;        % MinPathDist��ʱ����С��
    %%ÿ��ѭ��֮ǰ�ҳ�δ����S���Ľڵ�����StartPoint ֮����С�ĵ㿪ʼ��������·��
    	for temp_w=1:CrossPointNo		
			if (IsFinal(StartPoint,temp_w)==0) & (Min_Dist(StartPoint,temp_w)< MinPathDist)
                temp_v=temp_w;%temp_vΪδ����s��������ʼ��sp������̵ĵ�
                MinPathDist=Min_Dist(StartPoint,temp_v);
            end              
         end
         IsFinal(StartPoint,temp_v)=1;
         %%����·��
         for temp_z=1:CrossPointNo
         	if (IsFinal(StartPoint,temp_z)==0) &( (MinPathDist+Cost(temp_v,temp_z))<(Cost(StartPoint,temp_z)))
            	Cost(StartPoint,temp_z)=(MinPathDist+Cost(temp_v,temp_z));
                Min_Dist(StartPoint,temp_z)=Cost(StartPoint,temp_z);
                Muti_Path(StartPoint,temp_z)=temp_v;        %����˭������temp_z
             end
         end
     end
     Min_Distance= Min_Dist(StartPoint,:);%��Ӧ����С����
     Path=Muti_Path(StartPoint,:);   %��㵽�������ж������·����
     PrintPath(Min_Distance,Path,StartPoint,EndPoint);%��ӡ���������յ����·
end
     
function y=PrintPath(Min_Distance,Path,StartPointNo,EndPointNo)
	i=EndPointNo;
	if (Path(i)==StartPointNo) & (Min_Distance(i)<Inf)
        fprintf('��ʼ��(%d)����ֹ��(%d)��·��Ϊ:',StartPointNo,i)
        fprintf('%d<-',i)
        fprintf('%d',StartPointNo)
        fprintf('��Ӧ����С����Ϊ:%d',Min_Distance(EndPointNo));
        fprintf('\n')
	elseif  (Min_Distance(i)==Inf)
        fprintf('��ʼ��(%d)����ֹ��(%d)��·��Ϊ:��\n',StartPointNo,i)
    else 
        fprintf('��ʼ��(%d)����ֹ��(%d)���·��Ϊ:',StartPointNo,i)
        fprintf('%d',i)
        while(Path(i)~=StartPointNo)
            fprintf('<-%d', Path(i))
            i=Path(i);
        end
        fprintf('<-%d',StartPointNo)
        fprintf('��Ӧ����С����Ϊ:%d',Min_Distance(EndPointNo));
        fprintf('\n')
    end 
end
     
     
         
                   
    
    
   











