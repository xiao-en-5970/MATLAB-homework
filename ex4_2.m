%% 计算(数值）
clc,clear;

% 解方程
syms x(t) y(t) u lam r1 r2
u = 1/82.45;
lam = 1 - u;
x = y(1);
dx = y(2);
y_pos = y(3);
dy = y(4);

r1 = sqrt((x + u)^2 + y_pos^2);
r2 = sqrt((x + lam)^2 + y_pos^2);

d2x = 2 * dy + x - lam * (x + u) / r1^3 - u * (x - lam) / r2^3;
d2y = -2 * dx + y_pos - lam * y_pos / r1^3 - u * y_pos / r2^3;
[t, sol] = ode45(@(t, y) odefun(t, y, u, lam),[0 50],[1.2; 0; 0; -1.0494]);
x_sol = sol(:, 1);
y_sol = sol(:, 3);

% 可视化结果
figure;
plot(y_sol, x_sol, 'r',LineWidth=2);
title('轨迹');
% 定义ODE函数
function dydt = odefun(t, y, u, lam)
    x = y(1);
    dx = y(2);
    y_pos = y(3);
    dy = y(4);
    
    r1 = sqrt((x + u)^2 + y_pos^2);
    r2 = sqrt((x + lam)^2 + y_pos^2);
    
    d2x = 2 * dy + x - lam * (x + u) / r1^3 - u * (x - lam) / r2^3;
    d2y = -2 * dx + y_pos - lam * y_pos / r1^3 - u * y_pos / r2^3;
    
    dydt = [dx; d2x; dy; d2y];
end


