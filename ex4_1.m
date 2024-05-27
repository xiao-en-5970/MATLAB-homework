%% 数据预处理
% 邻接矩阵A
clc,clear;
A = [
    0,20,Inf,Inf,15,Inf;
    20,0,20,60,25,Inf;
    0,20,0,30,18,Inf;
    Inf,60,30,0,Inf,Inf;
    15,25,18,Inf,0,15;
    Inf,Inf,Inf,Inf,15,0;
    ];
% 创建i到j的最短距离的矩阵F
F = zeros(6);
%% 计算
clc;
% 对每两个点跑一遍dijkstra求个最短路
for i = 1:6
    for j = 1:6
        if i==j
            continue;
        end
        F(i,j)=dijkstra(A,i,j);
    end
end

% 跑出最短距离矩阵之后，对每个点向周围的点找出最远距离的点
for i = 1:6
    fprintf("V%f对其他点的最远距离为%f\n",i,max(F(i,:)));
end
fprintf("综上，V3到其他点的最远距离最小，V3建立销售点\n");

