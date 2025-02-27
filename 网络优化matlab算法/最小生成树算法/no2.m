% 定义 theta 的范围（弧度制）
theta = linspace(1.68*pi, 5.29*pi, 1000); % 1000个点用于绘图

% 预分配数组用于存储 a, b, x, y
a_vals = zeros(size(theta));
b_vals = zeros(size(theta));
x_vals = zeros(size(theta));
y_vals = zeros(size(theta));

% 遍历每个 theta，计算 a 和 b，解方程一二得到 x 和 y
for i = 1:length(theta)
    % 计算 a 和 b
    a = (1.7 / (2*pi)) * theta(i) * cos(theta(i));
    b = (1.7 / (2*pi)) * theta(i) * sin(theta(i));
    
    % 存储 a 和 b
    a_vals(i) = a;
    b_vals(i) = b;
    
    % 解方程一和二
    % 设定初始猜测值 [x0, y0]
    x0 = 0; y0 = 0;
    
    % 定义方程一和二
    eqns = @(xy) [
        (sin(theta(i)) + theta(i) * cos(theta(i))) / (cos(theta(i)) - theta(i) * sin(theta(i))) - (xy(1) - a) / (b - xy(2));
        a^2 + b^2 - 3*a*xy(1) - 3*b*xy(2)
    ];
    
    % 使用 fsolve 来解方程组
    options = optimset('Display','off'); % 关闭输出显示
    sol = fsolve(eqns, [x0, y0], options);
    
    % 存储 x 和 y
    x_vals(i) = sol(1);
    y_vals(i) = sol(2);
end

% 删除不符合条件的数据点：
% 条件1: x 和 y 不能取0
valid_indices = (x_vals ~= 0) & (y_vals ~= 0);

% 条件2: b/a 不能等于 y/x
valid_indices = valid_indices & (b_vals ./ a_vals ~= y_vals ./ x_vals);

% 只保留符合条件的值
theta_valid = theta(valid_indices);
a_valid = a_vals(valid_indices);
b_valid = b_vals(valid_indices);
x_valid = x_vals(valid_indices);
y_valid = y_vals(valid_indices);

% 绘制 a 和 b 随 theta 的变化图
figure;
subplot(2, 2, 1);
plot(theta_valid, a_valid);
xlabel('\theta (radians)');
ylabel('a');
title('a vs \theta');

subplot(2, 2, 2);
plot(theta_valid, b_valid);
xlabel('\theta (radians)');
ylabel('b');
title('b vs \theta');

% 绘制 x 和 y 随 theta 的变化图
subplot(2, 2, 3);
plot(theta_valid, x_valid);
xlabel('\theta (radians)');
ylabel('x');
title('x vs \theta');

subplot(2, 2, 4);
plot(theta_valid, y_valid);
xlabel('\theta (radians)');
ylabel('y');
title('y vs \theta');
