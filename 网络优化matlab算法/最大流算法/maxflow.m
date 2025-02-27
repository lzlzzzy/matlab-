% 主脚本

% 空间和时间范围
xspan = linspace(0, 10, 100);
tspan = linspace(0, 5, 100);
C0 = @(x) 0.5; % 初始条件

% PDE 求解
m = 0;
sol = pdepe(m, @pde_eqn, C0, @bc_eqn, xspan, tspan);

% 结果提取
C = sol(:,:,1); % 提取浓度解

% 绘制结果
figure;
hold on;
for i = 1:length(tspan)
    plot(xspan, C(i,:));
end
hold off;
title('PDE Solution Over Time');
xlabel('Space x');
ylabel('Concentration C');
legend(arrayfun(@(t) sprintf('t = %.2f', t), tspan, 'UniformOutput', false));

% -------------------
% 函数定义部分
% -------------------

% PDE 方程函数
function [c,f,s] = pde_eqn(x,t,C,DC_Dx)
    c = 1; % 时间导数的系数
    f = 0.38 * DC_Dx; % 空间导数项
    s = -5.01 * DC_Dx - 3.1732 * (0.747592 * C + 12.19402120 * C ./ (1 + 3.1732 * C)); % 源项
end

% 边界条件函数
function [pl,ql,pr,qr] = bc_eqn(xl,Cl,xr,Cr,t)
    pl = Cl; 
    ql = 0;
    pr = Cr;
    qr = 0;
end
