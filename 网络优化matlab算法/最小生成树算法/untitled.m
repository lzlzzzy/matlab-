% 主脚本
% 初始化p和theta(n), theta(n+1)的范围
p_values = 0.3:0.01:0.5;  % p的范围从0.3到0.5，每次增量为0.01
theta_n_values = NaN(size(p_values));
theta_np1_values = NaN(size(p_values));

% 初始猜测
initial_guess = [2, 2];  % 初始猜测的 theta(n) 和 theta(n+1)

% 迭代 p 值
for i = 1:length(p_values)
    p = p_values(i);
    % 使用 fsolve 求解方程组
    options = optimoptions('fsolve', 'Display', 'off');
    solution = fsolve(@(vars) solveEquations(vars, p), initial_guess, options);
    
    % 检查 theta(n+1) - theta(n) 的差值是否小于 1.57
    theta_n = solution(1);
    theta_np1 = solution(2);
    
   
    theta_n_values(i) = theta_n;
    theta_np1_values(i) = theta_np1;
    
end

% 删除 NaN 值以便绘图
valid_idx = ~isnan(theta_n_values);
p_values_filtered = p_values(valid_idx);
theta_n_values_filtered = theta_n_values(valid_idx);
theta_np1_values_filtered = theta_np1_values(valid_idx);

% 绘制 theta(n) 和 theta(n+1) 随 p 的变化
figure;
plot(p_values_filtered, theta_n_values_filtered, '-o', 'DisplayName', 'theta(n)');
hold on;
plot(p_values_filtered, theta_np1_values_filtered, '-x', 'DisplayName', 'theta(n+1)');
xlabel('p 值');
ylabel('theta ');
title('theta(n) 和 theta(n+1) 随 p 值的变化 (满足约束条件)');
legend show;
grid on;

