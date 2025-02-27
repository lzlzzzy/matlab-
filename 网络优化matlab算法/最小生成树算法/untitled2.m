function solve_system()
    % 已知参数
    p = 1.7;
    theta1 = 1.68 * pi;

    % 设置初始猜测值 (根据具体问题调整)
    theta_i_initial = 1.7 * pi;
    theta_ip1_initial = 1.8 * pi;

    % 使用 fsolve 解方程
    initial_guess = [theta_i_initial, theta_ip1_initial];
    options = optimoptions('fsolve', 'Display', 'iter', 'TolFun', 1e-8, 'TolX', 1e-8);
    
    [theta_solutions, fval, exitflag] = fsolve(@(theta) equations(theta, p, theta1), initial_guess, options);

    if exitflag > 0
        fprintf('解找到：\n');
        fprintf('theta_i = %.8f\n', theta_solutions(1));
        fprintf('theta_i+1 = %.8f\n', theta_solutions(2));
    else
        fprintf('无法找到解，请检查初始条件或方程组。\n');
    end
end

% 定义方程组
function F = equations(theta, p, theta1)
    theta_i = theta(1);
    theta_ip1 = theta(2);
    
    % 计算 r_i 和 r_i+1
    r_i = (p / (2 * pi)) * theta_i;
    r_ip1 = (p / (2 * pi)) * theta_ip1;
    
    % 计算 h
    h = (r_i * r_ip1 * sin(theta_ip1 - theta_i)) / 1.65;
    
    % 方程1
    eq1 = 1.65 - sqrt(r_i^2 - h^2) - h * tan(theta_i + theta_ip1 - 2 * theta1 - acos(h / r_i));
    
    % 方程2
    eq2 = (p / (2 * pi) * theta_i)^2 + (p / (2 * pi) * theta_ip1)^2 - 2 * (p / (2 * pi))^2 * cos(theta_ip1 - theta_i) - 1.65^2;

    % 返回方程组的值
    F = [eq1; eq2];
end
