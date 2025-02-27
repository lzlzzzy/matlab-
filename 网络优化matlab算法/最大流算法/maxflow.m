% ���ű�

% �ռ��ʱ�䷶Χ
xspan = linspace(0, 10, 100);
tspan = linspace(0, 5, 100);
C0 = @(x) 0.5; % ��ʼ����

% PDE ���
m = 0;
sol = pdepe(m, @pde_eqn, C0, @bc_eqn, xspan, tspan);

% �����ȡ
C = sol(:,:,1); % ��ȡŨ�Ƚ�

% ���ƽ��
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
% �������岿��
% -------------------

% PDE ���̺���
function [c,f,s] = pde_eqn(x,t,C,DC_Dx)
    c = 1; % ʱ�䵼����ϵ��
    f = 0.38 * DC_Dx; % �ռ䵼����
    s = -5.01 * DC_Dx - 3.1732 * (0.747592 * C + 12.19402120 * C ./ (1 + 3.1732 * C)); % Դ��
end

% �߽���������
function [pl,ql,pr,qr] = bc_eqn(xl,Cl,xr,Cr,t)
    pl = Cl; 
    ql = 0;
    pr = Cr;
    qr = 0;
end
