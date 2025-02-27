
% 定义求解方程的函数
function F = solveEquations(vars, p)
    theta_n = vars(1);       % theta(n)
    theta_np1 = vars(2);     % theta(n+1)
    r_n = p / (2*pi) * theta_n;        % r(n)
    r_np1 = p / (2*pi) * theta_np1;    % r(n+1)
    h = (r_n * r_np1 * sin(theta_np1 - theta_n)) / 1.65;

    % 方程一
    eq1 = 1.65 - sqrt(r_n^2 - h^2) - h * tan(theta_n + theta_np1 - 2 * (9*pi/p) - acos(h/r_n));

    % 方程二
    eq2 = (p/(2*pi)*theta_n)^2 + (p/(2*pi)*theta_np1)^2 - 2 * (p/(2*pi))^2 * cos(theta_np1 - theta_n) - 1.65^2;

    F = [eq1; eq2];
end