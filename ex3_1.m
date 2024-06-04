%% 数据预处理
clc,clear;
data = readtable("data_3_1.csv");
r = data.r;
q = data.q;
p = data.p;
u = data.u;
n = data.n;
r0 = data.r0;
N=15;

%% 计算​​​​
a=0; 
hold on;
while a<0.2   
    c=[-0.05,-(data.r-data.p)'/100];     
    A=[zeros(N,1),diag((data.q/100)')];     
    b=a*ones(N,1);     
    Aeq=[1,(data.p/100+1)'];     
    beq=1;     
    LB=zeros(N+1,1);     
    [x,Q]=linprog(c,A,b,Aeq,beq,LB);     
    Q=-Q;     
    plot(a,Q,'*r');     
    a=a+0.001; 
end 
xlabel('a(风险)'),ylabel('Q(收益)') 
fprintf("风险越高，收益越大，但是在图中，风险a接近0.05的时候，风险增加，收益提高不明显\n")