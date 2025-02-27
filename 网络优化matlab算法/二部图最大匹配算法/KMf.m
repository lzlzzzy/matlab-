%二部图最大匹配算法 Kuhn-Munkres算法
function [M MaxZjpp]=KMf(A)
%A表示权值矩阵,M表示图的匹配矩阵,MaxZjpp表示最大匹配的权
n=size(A,2);
L=zeros(n,2);
M=zeros(n,n);
L(:,1)=max(A,[],2);
for (i=1:n)
    for (j=1:n)
        if (L(i,1)+L(j,2)==A(i,j))
            Gl(i,j)=1;
        else
            Gl(i,j)=0;
        end
    end
end
ii=1;jj=min(find(Gl(1,:)==1));
M(ii,jj)=1;
S=zeros(1,n);
T=S;
NlS=S;%
while 1
    for (i=1:n)
        k=1;
        for (j=1:n)
            if (M(i,j))
                k=0;
                break;
            end
        end
        if(k)
            break;
        end
    end
    if (k==0)
        break;
    end
    S(1)=i;jss=1;jst=0;
    while (1)
        jsn=0;
        for (i=1:jss)
            for (j=1:n)
                if (Gl(S(i),j))
                    jsn=jsn+1; NlS(jsn)=j;
                    for (k=1:jsn-1)
                        if (NlS(k)==j)
                            jsn=jsn-1;
                        end
                    end
                end
            end
        end
        if (jsn==jst)
            pd=1;
            for (j=1:jsn)
                if (NlS(j)~=T(j))
                    pd=0;break;
                end
            end
        end
        if (jsn==jst & pd)
            al=inf;
            for (i=1:jss)
                for (j=1:n)
                    pd=1;
                    for (k=1:jst)
                        if(T(k)==j)
                            pd=0;break;
                        end
                    end
                    if (pd&al>L(S(i),1)+L(j,2)-A(S(i),j))
                        al=L(S(i),1)+L(j,2)-A(S(i),j);
                    end
                end
            end
            for (i=1:jss)
                L(S(i),1)=L(S(i),1)-al;
            end
            for (j=1:jst)
                L(T(j),2)=L(T(j),2)+al;
            end
            for (i=1:n)
                for (j=1:n)
                    if (L(i,1)+L(j,2)==A(i,j))
                        Gl(i,j)=1;
                    else
                        Gl(i,j)=0;
                    end
                    M(i,j)=0;k=0;
                end
            end
            ii=0;jj=0;
            for (i=1:n)
                for (j=1:n)
                    if (Gl(i,j))
                        ii=i;jj=j;break;
                    end
                end
                if(ii)
                    break;
                end
            end
       M(ii,jj)=1;break;
        else
            for (j=1:jsn)
                pd=1;
                for (k=1:jst)
                    if(T(k)==NlS(j))
                        pd=0; break;
                    end
                end
                if (pd)
                    jj=j; break;
                end
            end
            pd=0;
            for (i=1:n)
                if (M(i,NlS(jj)))
                    pd=1;ii=i; break;
                end
            end
            if (pd)
                jss=jss+1;S(jss)=ii;jst=jst+1;T(jst)=NlS(jj);
            else
                for (k=1:jst)
                    M(S(k),T(k))=1;M(S(k+1),T(k))=0;
                end
                if (jst==0)
                    k=0;
                end
                M(S(k+1),NlS(jj))=1;
                break;
            end
        end
    end
end
MaxZjpp=sum(sum(M.*A));
M;
MaxZjpp;
        