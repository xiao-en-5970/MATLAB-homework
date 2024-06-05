%% 对数据的假设
% 假设最开始只有1龄鱼
clc,clear;
% 初始鱼数量->这个不重要，总会收敛的（确信）
S=[1000000000;1000000000;1000000000;1000000000];
% 捕捞强度系数
power_3 = 0.42;
power_4 = 1;
% 死亡率
death_rate = 0.8;
% 鱼的重量
kg = [5.07,11,55,17.86,22.99];
% 繁殖数量
breed_4 = 1.109*10^5;
breed_3 = breed_4/2;
% 卵的存活率
survive_rate = 1.22*10^11;
% 设置精度
format long
% 迭代次数
N=1000;
% P显然是收益，也就是鱼重量
P = zeros(100,1);
%% 计算
% 设4龄捕鱼强度为x
clc;
for x = 1:100
    A = [0,0,breed_3,breed_4;
         1-death_rate,0,0,0;
         0,1-death_rate,0,0;
         0,0,(1-death_rate)*(1-power_3*x/100),0];
    for i = 1:N
        S = A*S;
        S(1) = survive_rate*S(1)/(S(1)+survive_rate);
        P(x) = P(x) + S(3)*kg(3)*power_3*x/100+S(4)*kg(4)*power_4*x/100;
    end
    
    
end
fprintf("为了保持鱼数量不变，鱼的初始投入数量应该分别为：");
S
fprintf("最大收益为：");
max(P)

