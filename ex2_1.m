%% 数据处理
clc,clear;
% 读取csv表
data = readtable("data_2_1.csv");
% 间隔时间，例如15-24，这边我取均值20
between_time = data.betweenTime;
% 1200艘经验数据中的对应间隔时间的数量
between_num = data.betweenNum;
% 总共数量为1200
total_num = data.totalNum(1);
% 装箱时间，在45-49中取平均为47
unloading_time = data.unloadingTime(1:9);
%对应经验数据中的数量
unloading_num = data.unloadingNum(1:9);
% 对0——1200的每一个数进行数值对时间的映射，方便随机值取值对应
hash_between = zeros(total_num,1);
hash_unloading = zeros(total_num,1);
p =1;
for i = 1:13
    for j = 1:between_num(i)
        hash_between(p) = between_time(i);
        p = p +1;
    end
end
p =1;
for i = 1:9
    for j = 1:unloading_num(i)
        hash_unloading(p) = unloading_time(i);
        p = p +1;
    end
end
% 先随机出1000条船进港口
N=1000;
% 做出一个随机的间隔时间和装载时间表
between_rand_time = hash_between(round((1200-1)*rand(N,1),0)+1);
% 第一艘船不需要等待
between_rand_time(1) = 0;
unloading_rand_time = hash_unloading(round((1200-1)*rand(N,1),0)+1);

% 船到达时间
arrive_time = zeros(N,1);
for i = 2:N
    arrive_time(i) = arrive_time(i-1)+between_rand_time(i);
end
% 等待时间
waiting_time = zeros(N,1);
% 在港时间
living_time = zeros(N,1);
% 最新来的船序号
new_ship = 1;
% 正在服务的船序号
cur_ship = 1;
% 正在服务的船的进度
cur_proc = 0;
% 标准时间
cur_time = 0;
%平均等待时间
avg_wait_time = 0;
%平均等待在港时间
avg_live_time = 0;

%% 平均等待时间
% 等待时间
waiting_time = zeros(N,1);
% 最新来的船序号
new_ship = 1;
% 正在服务的船序号
cur_ship = 1;
% 正在服务的船的进度
cur_proc = 0;
% 标准时间
cur_time = 0;
%将时间离散化以每分钟为单位
% 当装载还没结束的时候
clc;
while cur_ship<=N
    %如果现在正在装载的船还没完
    if cur_ship ~= 0
        if cur_proc<unloading_rand_time(cur_ship)
            %则继续装
            cur_proc = cur_proc+1;
        else
            % 如果不空闲,下一艘船继续
            if cur_time<new_ship
                cur_ship = cur_ship+1;
            else
                cur_ship = 0;
            end
            cur_proc = 0;
        end
    end
    % 如果有排队发生，则排队时间+1
    if cur_ship~=0 && cur_ship<new_ship
        waiting_time(cur_ship+1:new_ship) = waiting_time(cur_ship+1:new_ship)+1;
    end
    % 如果空闲且最新的船为最后一个，则表明接完了，break掉
    if cur_ship == 0 && new_ship == N
        break;
    end
    % 检测是否该时刻有新船来
    if new_ship<N && cur_time>=arrive_time(new_ship+1)
        if cur_ship == 0
            cur_ship = new_ship;
        end
        new_ship = new_ship+1;
    end
    %无论如何，时间都将继续流逝
    cur_time = cur_time+1;
end
% 平均等待时间
avg_wait_time = sum(waiting_time)/N
% 平均在港口时间（其实就是等待时间加上装载时间）
avg_live_time = sum(waiting_time+unloading_rand_time)/N
fprintf("平均等待时间为：%f\n",avg_wait_time);
fprintf("平均在港时间为：%f\n",avg_live_time);


