function [Matching,Cost] = Hung_Al(Matrix)
  Matching = zeros(size(Matrix));
  % 找出每行和每列相邻的点数
    num_y = sum(~isinf(Matrix),1);
    num_x = sum(~isinf(Matrix),2);
  % 找出每行和每列的孤立点数
    x_con = find(num_x~=0);
    y_con = find(num_y~=0);
  %将矩阵压缩、重组    
P_size = max(length(x_con),length(y_con));
    P_cond = zeros(P_size);
    P_cond(1:length(x_con),1:length(y_con)) = Matrix(x_con,y_con);
    if isempty(P_cond)
      Cost = 0;
      return
    end
% 确保存在完美匹配，计算矩阵边集
      Edge = P_cond;
      Edge(P_cond~=Inf) = 0;
      cnum = min_line_cover(Edge);
    Pmax = max(max(P_cond(P_cond~=Inf)));
      P_size = length(P_cond)+cnum;
      P_cond = ones(P_size)*Pmax;
      P_cond(1:length(x_con),1:length(y_con)) = Matrix(x_con,y_con);
%主函数程序,此处将每个步骤用switch命令进行控制调用步骤函数 
exit_flag = 1;
  stepnum = 1;
  while exit_flag
    switch stepnum
      case 1
        [P_cond,stepnum] = step1(P_cond);
      case 2
        [r_cov,c_cov,M,stepnum] = step2(P_cond);
      case 3
        [c_cov,stepnum] = step3(M,P_size);
      case 4
        [M,r_cov,c_cov,Z_r,Z_c,stepnum] = step4(P_cond,r_cov,c_cov,M);
      case 5
        [M,r_cov,c_cov,stepnum] = step5(M,Z_r,Z_c,r_cov,c_cov);
      case 6
        [P_cond,stepnum] = step6(P_cond,r_cov,c_cov);
      case 7
        exit_flag = 0;
    end
  end
Matching(x_con,y_con) = M(1:length(x_con),1:length(y_con));
Cost = sum(sum(Matrix(Matching==1)));
%下面是6个步骤函数step1~step6
%步骤1：找到包含0最多的行，从该行减去最小值
function [P_cond,stepnum] = step1(P_cond)
  P_size = length(P_cond);
    for ii = 1:P_size
    rmin = min(P_cond(ii,:));
    P_cond(ii,:) = P_cond(ii,:)-rmin;
  end
  stepnum = 2;
%步骤2：在P-cond中找一个0，并找出一个以该数0为星型的覆盖
function [r_cov,c_cov,M,stepnum] = step2(P_cond)
%定义变量 r-cov，c-cov分别表示行或列是否被覆盖
  P_size = length(P_cond);
  r_cov = zeros(P_size,1);  
  c_cov = zeros(P_size,1);  
  M = zeros(P_size);        
    for ii = 1:P_size
    for jj = 1:P_size
      if P_cond(ii,jj) == 0 && r_cov(ii) == 0 && c_cov(jj) == 0
        M(ii,jj) = 1;
        r_cov(ii) = 1;
        c_cov(jj) = 1;
      end
    end
  end
  % 重初始化变量
  r_cov = zeros(P_size,1);  
  c_cov = zeros(P_size,1); 
  stepnum = 3;
%步骤3：每列都用一个0构成的星型覆盖，如果每列都存在这样的覆盖，则M为最大匹配
function [c_cov,stepnum] = step3(M,P_size)
  c_cov = sum(M,1);
  if sum(c_cov) == P_size
    stepnum = 7;
  else
    stepnum = 4;
  end
%步骤4：找一个未被覆盖的0且从这出发点搜寻星型0覆盖。如果不存在，转步骤5，否%则转步骤6
function [M,r_cov,c_cov,Z_r,Z_c,stepnum] = step4(P_cond,r_cov,c_cov,M)
P_size = length(P_cond);
zflag = 1;
while zflag  
      row = 0; col = 0; exit_flag = 1;
      ii = 1; jj = 1;
      while exit_flag
          if P_cond(ii,jj) == 0 && r_cov(ii) == 0 && c_cov(jj) == 0
            row = ii;
            col = jj;
            exit_flag = 0;
          end      
          jj = jj + 1;      
          if jj > P_size; jj = 1; ii = ii+1; end      
          if ii > P_size; exit_flag = 0; end      
      end
     if row == 0
        stepnum = 6;
        zflag = 0;
        Z_r = 0;
        Z_c = 0;
      else
        M(row,col) = 2;
        if sum(find(M(row,:)==1)) ~= 0
            r_cov(row) = 1;
            zcol = find(M(row,:)==1);
            c_cov(zcol) = 0;
          else
            stepnum = 5;
            zflag = 0;
            Z_r = row;
            Z_c = col;
          end            
      end
end
%步骤5：
function [M,r_cov,c_cov,stepnum] = step5(M,Z_r,Z_c,r_cov,c_cov)
  zflag = 1;
  ii = 1;
  while zflag 
    rindex = find(M(:,Z_c(ii))==1);
    if rindex > 0
      ii = ii+1;
      Z_r(ii,1) = rindex;
      Z_c(ii,1) = Z_c(ii-1);
    else
      zflag = 0;
    end
      if zflag == 1;
      cindex = find(M(Z_r(ii),:)==2);
      ii = ii+1;
      Z_r(ii,1) = Z_r(ii-1);
      Z_c(ii,1) = cindex;    
    end    
  end
  for ii = 1:length(Z_r)
    if M(Z_r(ii),Z_c(ii)) == 1
      M(Z_r(ii),Z_c(ii)) = 0;
    else
      M(Z_r(ii),Z_c(ii)) = 1;
    end
  end
  r_cov = r_cov.*0;
  c_cov = c_cov.*0;
  M(M==2) = 0;
stepnum = 3;
% 步骤6：
function [P_cond,stepnum] = step6(P_cond,r_cov,c_cov)
a = find(r_cov == 0);
b = find(c_cov == 0);
minval = min(min(P_cond(a,b)));
P_cond(find(r_cov == 1),:) = P_cond(find(r_cov == 1),:) + minval;
P_cond(:,find(c_cov == 0)) = P_cond(:,find(c_cov == 0)) - minval;
stepnum = 4;
function cnum = min_line_cover(Edge)
    [r_cov,c_cov,M,stepnum] = step2(Edge);
    [c_cov,stepnum] = step3(M,length(Edge));
    [M,r_cov,c_cov,Z_r,Z_c,stepnum] = step4(Edge,r_cov,c_cov,M);
cnum = length(Edge)-sum(r_cov)-sum(c_cov);
