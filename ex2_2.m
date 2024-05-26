%% 数据预处理
clc,clear;
data = readtable("data_2_2.csv");
width = data.width;
kilo = data.kilo;
num = data.num;
% 建立变量cij表示i车上cj的数量
% 则有c11,c12,c13,c14,c15,c16,c17,c21,c22,c23,c24,c25,c26,c27
% 以上十四个变量
% 对567的约束
C567 = 302.7;
% 车总质量
TOTAL_KILO = 40000;
% 车总厚度
TOTAL_WIDTH = 1020;
% 对变量的各种约束，包括质量超载，厚度超出，物品件数，C567的单独约束
A=[kilo',0,0,0,0,0,0,0;
   0,0,0,0,0,0,0,kilo';
   width',0,0,0,0,0,0,0;
   0,0,0,0,0,0,0,width';
   1,zeros(1,6),1,zeros(1,6);
   0,1,zeros(1,5),0,1,zeros(1,5);
   0,0,1,zeros(1,4),0,0,1,zeros(1,4);
   zeros(1,3),1,zeros(1,3),zeros(1,3),1,zeros(1,3);
   zeros(1,4),1,zeros(1,2),zeros(1,4),1,zeros(1,2);
   zeros(1,5),1,zeros(1,1),zeros(1,5),1,zeros(1,1);
   zeros(1,6),1,zeros(1,6),1;
   zeros(1,4),1,1,1,zeros(1,7);
   zeros(1,11),1,1,1];
% 约束的最大值
b = [TOTAL_KILO;
     TOTAL_KILO;
     TOTAL_WIDTH;
     TOTAL_WIDTH;
     num;
     C567;
     C567;
     ];
% 期望求出物品的总厚度最大，则-width最小
f = [-width',-width'];
% 物品数量最小值为0
lb = [zeros(14,1)];
% 最大值不超过件数
ub = [num;num];
% intlinprog函数需要知道哪些变量只能为整数，以下是需要为整数的索引
intcon = 1:14;
%% 计算
% 核心，调用intlinprog函数求出约束条件下的f最小值2*TOTAL_WIDTH+value
[x,value,ef,op] = intlinprog(f,intcon,A,b,[],[],lb,ub);
smallest_space = round(2*TOTAL_WIDTH+value,2);
%最喜欢的fprintf，沿用C语言优美的格式化输出
fprintf("最小浪费空间为%f\n",smallest_space);
% 14个维度的线性规划确实难蚌