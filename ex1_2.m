%% 数据处理 
clc,clear;
data = readtable("data_1_2.csv");
%time代表从6.29的8点，每过12h作为一个单位时间的值
time = table2array(data(:,"Var1"));
% 水流量
water_stream=table2array(data(:,"Var2"));
% 沙含量
sand_content = table2array(data(:,"Var3"));
%% 
% 绘图
% 用原始数据作图
plot(time,water_stream,"r-",LineWidth=3);
figure
plot(time,sand_content,"b-",LineWidth=3);

%% （1）给出估计任意时刻的排沙量及总排沙量的方法；
% xx用于预测从6.29的8点之后的每一小时的沙流量yy，用三次样条插值（我觉得拉格朗日不行）
xx = (1:0.125:24)';
% 沙流量等于水流量乘含水量
sand_stream = sand_content.*water_stream;
yy = spline(time,sand_stream,xx);
plot(xx,yy,"b-",LineWidth=3)
legend("排沙量 kg/s");
xlabel("单位时间 h");
ylabel("排沙量 kg/s");
% 而显然总排沙量等于每小时排沙量乘3600，然后累加
total_sand_stream = zeros(size(xx));
total_sand_stream(1) = sand_stream(1)*3600;
for i = 2:size(total_sand_stream)
    total_sand_stream(i) = total_sand_stream(i-1)+yy(i)*3600;
end
figure
plot(xx,total_sand_stream,"r-",LineWidth=3);
legend("总排沙量 kg");
xlabel("单位时间 h");
ylabel("总排沙量 kg");
%% （2）确定排沙量与水流量的关系。
sand_stream = water_stream.*sand_content;
plot(water_stream,sand_stream);
% 排沙量等于水流量乘含沙量
