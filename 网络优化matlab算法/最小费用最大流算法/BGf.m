%最小费用最大流算法,C表示弧上的容量,b表示弧上单位流量的费用,f表示最小费用最大流矩阵, wf表示最大流量, zwf表示最小费用
function [f wf zwf]=BGf(C,b)
n=size(C,2);
wf=0;wf0=inf;
f=zeros(n,n);
while 1
    a=ones(n,n)*inf;
    for i=1:n
        a(i,i)=0;
    end
    for i=1:n
        for j=1:n
            if C(i,j)>0 & f(i,j)==0
                a(i,j)=b(i,j);
            elseif C(i,j)>0 & f(i,j)==C(i,j)
                a(j,i)=-b(i,j);
            elseif C(i,j)>0
                a(i,j)=b(i,j);
                a(j,i)=-b(i,j);
            end
        end
    end
    for i=2:n
        p(i)=inf; s(i)=i;
    end
    for k=1:n
        pd=1;
        for i=2:n
            for j=1:n
                if (p(i)>p(j)+a(j,i))
                    p(i)=p(j)+a(j,i); s(i)=j; pd=0;
                end
            end
        end
        if pd
            break;
        end
    end
    if p(n)==inf
        break;
    end 
    dvt=inf; t=n;
    while 1
        if (a(s(t),t)>0)
            dvtt=C(s(t),t)-f(s(t),t);
        elseif a(s(t),t)<0
            dvtt=f(t,s(t));
        end
        if dvt>dvtt
            dvt=dvtt;
        end
        if s(t)==1
            break;
        end
        t=s(t);
    end
    pd=0;
    if wf+dvt>=wf0
        dvt=wf0-wf; pd=1;
    end
    t=n;
    while 1
        if a(s(t),t)>0
            f(s(t),t)=f(s(t),t)+dvt;
        elseif a(s(t),t)<0
            f(t,s(t))=f(t,s(t))-dvt;
        end
        if s(t)==1
            break;
        end
        t=s(t);
    end
    if pd
        break; 
    end
    wf=0;
    for j=1:n
        wf=wf+f(1,j);
    end
end
zwf=0;
for i=1:n
    for j=1:n
        zwf=zwf+b(i,j)*f(i,j);
    end
end
f;
        