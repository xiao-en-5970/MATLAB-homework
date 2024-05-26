%% 数据处理
clc,clear;
data = readtable("data_1_3.csv");
x = table2array(data(:,"x"));
y1= table2array(data(:,"y1"));
y2= table2array(data(:,"y2"));
rate=40/18;
real_square = 41288;
%% 初始数据绘图
plot(x,y1,"r-",LineWidth=2);
hold on
plot(x,y2,"r-",LineWidth=2);

%% 对数据进行三次样条插值
clc;
xx = 7:0.1:158;
yy1=spline(x,y1,xx);
yy2=spline(x,y2,xx);
% 插值之后的数值绘图
plot(xx,yy1,"r-",LineWidth=2);
hold on
plot(xx,yy2,"b-",LineWidth=2);
legend("y1","y2");
xlabel("x/mm");
ylabel("y/mm");
total_square = sum((yy2-yy1)*0.1*rate*rate);
fprintf("计算面积为：%.6f\n",round(total_square,6));
diff = (total_square-real_square)/real_square*100;
fprintf("与真实面积的误差为：百分之%.3f\n",round(diff,3));