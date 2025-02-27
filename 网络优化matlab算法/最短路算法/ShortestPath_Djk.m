%输入：权重矩阵Cost,总的节点数CrossPointNo，起点StartPoint，终点EndPoint
%输出：起点到其他每个顶点的最小距离，路径矩阵，并打印一条起点到终点的线路
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
   	MinPathDist=inf;        % MinPathDist暂时存最小量
    %%每次循环之前找出未加入S集的节点中与StartPoint 之间最小的点开始用来更新路径
    	for temp_w=1:CrossPointNo		
			if (IsFinal(StartPoint,temp_w)==0) & (Min_Dist(StartPoint,temp_w)< MinPathDist)
                temp_v=temp_w;%temp_v为未加入s集的与起始点sp距离最短的点
                MinPathDist=Min_Dist(StartPoint,temp_v);
            end              
         end
         IsFinal(StartPoint,temp_v)=1;
         %%更新路径
         for temp_z=1:CrossPointNo
         	if (IsFinal(StartPoint,temp_z)==0) &( (MinPathDist+Cost(temp_v,temp_z))<(Cost(StartPoint,temp_z)))
            	Cost(StartPoint,temp_z)=(MinPathDist+Cost(temp_v,temp_z));
                Min_Dist(StartPoint,temp_z)=Cost(StartPoint,temp_z);
                Muti_Path(StartPoint,temp_z)=temp_v;        %记下谁更改了temp_z
             end
         end
     end
     Min_Distance= Min_Dist(StartPoint,:);%对应的最小距离
     Path=Muti_Path(StartPoint,:);   %起点到其他所有顶点的线路矩阵
     PrintPath(Min_Distance,Path,StartPoint,EndPoint);%打印给定起点和终点的线路
end
     
function y=PrintPath(Min_Distance,Path,StartPointNo,EndPointNo)
	i=EndPointNo;
	if (Path(i)==StartPointNo) & (Min_Distance(i)<Inf)
        fprintf('起始点(%d)到终止点(%d)的路径为:',StartPointNo,i)
        fprintf('%d<-',i)
        fprintf('%d',StartPointNo)
        fprintf('对应的最小距离为:%d',Min_Distance(EndPointNo));
        fprintf('\n')
	elseif  (Min_Distance(i)==Inf)
        fprintf('起始点(%d)到终止点(%d)的路径为:空\n',StartPointNo,i)
    else 
        fprintf('起始点(%d)到终止点(%d)点的路径为:',StartPointNo,i)
        fprintf('%d',i)
        while(Path(i)~=StartPointNo)
            fprintf('<-%d', Path(i))
            i=Path(i);
        end
        fprintf('<-%d',StartPointNo)
        fprintf('对应的最小距离为:%d',Min_Distance(EndPointNo));
        fprintf('\n')
    end 
end
     
     
         
                   
    
    
   











