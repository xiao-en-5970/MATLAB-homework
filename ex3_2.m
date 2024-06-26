%% 数据预处理
clc;clear;
data = readtable("data_3_2.csv");
buy_price = data.purchase_price;
fix_price = data.fix_price;
%设Vij为第i年购入机器到第j年的花费
v = zeros(6);
for i = 1:5
    for j = 1:6
        if i<j
            v(i,j) = buy_price(i)+sum(fix_price(1:j-i));
        elseif i>j
            v(i,j) = inf;
        end
    end
end

%% 计算v16的最短路
clc;
[price,pass]=dijkstra(v,1,6);
pass = fliplr(pass);
fprintf("最小花费为:%f\n最小路径为:",price);
pass
fprintf("表示从第一年用到第三年换新，然后一直用到第六年初，为最优解\n");