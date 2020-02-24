%% 特征组(均方根、波形因子、裕度因子、样本熵、条件熵、排列熵)FCM聚类


%% 均方根-波形因子—FCM聚类

%x01=[tezheng1(11:30,1),tezheng1(11:30,2);
%     tezheng2(1:20,1),tezheng2(1:20,2);
%     tezheng3(11:30,1),tezheng3(11:30,2);
%     tezheng4(1:20,1),tezheng4(1:20,2)];
[n,n1]=size(x01);%x为样本数，n1为样本维数
m=2;
c_max=4;%round(sqrt(n));分的类数
%**x为n*m的矩阵，行为样本的个数，列为样本的维数***
%**z为c*m的矩阵，行为类的个数，列为每个类的代表中心***
%**u为c*n的矩阵，行为类的个数，列为样本数，表示某样本对类的隶属度***
z=x01(1:c_max,:);%z初始化，x的前c_max个样本为中心。
u=zeros(c_max,n);%u初始化
sumn=0;sum0=zeros(1,n1);sum1=0;num=0;
e=1;%精度初始化
while e>1e-6%隶属度值不再发生变化时终止
    u0=u;%记录前一个的u
    num=num+1;%记录循环次数
    for i=1:c_max %列更新u
        for k=1:n %行更新u 
       %*************计算每个隶属度**********
            t0=norm(x01(k,:)-z(i,:))^2;
            if t0==0%意味着某的数据就是类中心
               u(:,k)=0;%其他隶属度为0，自身为1.
               u(i,k)=1;   
            else
                for j=1:c_max
                    t1=norm(x01(k,:)-z(j,:))^2;
                    t2=(t0/t1)^(2/(m-1));
                    sumn=sumn+t2;
                end
                u(i,k)=1/(sumn+0.00001);%得到第k的数据在第k类的隶属度
                sumn=0;
            end
        end
    end
%********************更新每类的代表中心z**********
    for i=1:c_max
        for k=1:n
            r1=u(i,k)^m;
            sum1=sum1+r1;
            sum0=sum0+x01(k,:).*r1;    
        end
        z(i,:)=sum0/(sum1+0.000001);
        sum0=0;sum1=0;
    end  
%********************终止条件部分***********
    e=norm(u-u0)^2;
    if num>500%防止陷入死循环
        break;
    end
end
%*******************画出其中的二维图********************
figure('name','均方根-波形因子-FCM聚类');
xlabel('均方根RM');ylabel('波形因子S');
plot(x01(1:20,1),x01(1:20,2),'b+');hold on;
plot(x01(21:40,1),x01(21:40,2),'mx');hold on;
plot(x01(41:60,1),x01(41:60,2),'g*');hold on;
plot(x01(61:80,1),x01(61:80,2),'kd');hold on;
xlabel('均方根RM');ylabel('波形因子S');
%plot(z(:,1),z(:,2),'ro');disp(z);
legend('为正常状态','为内圈故障','为滚动体故障','为外圈故障')

%% 均方根-样本熵—FCM聚类

%x03=[tezheng1(1:20,1),tezheng1(1:20,4);
%     tezheng2(21:40,1),tezheng2(21:40,4);
%     tezheng3(31:50,1),tezheng3(31:50,4);
%     tezheng4(21:40,1),tezheng4(21:40,4)];
[n,n1]=size(x03);%x为样本数，n1为样本维数
m=2;
c_max=4;%round(sqrt(n));分的类数
%**x为n*m的矩阵，行为样本的个数，列为样本的维数***
%**z为c*m的矩阵，行为类的个数，列为每个类的代表中心***
%**u为c*n的矩阵，行为类的个数，列为样本数，表示某样本对类的隶属度***
z=x03(1:c_max,:);%z初始化，x的前c_max个样本为中心。
u=zeros(c_max,n);%u初始化
sumn=0;sum0=zeros(1,n1);sum1=0;num=0;
e=1;%精度初始化
while e>1e-6%隶属度值不再发生变化时终止
    u0=u;%记录前一个的u
    num=num+1;%记录循环次数
    for i=1:c_max %列更新u
        for k=1:n %行更新u 
       %*************计算每个隶属度**********
            t0=norm(x03(k,:)-z(i,:))^2;
            if t0==0%意味着某的数据就是类中心
               u(:,k)=0;%其他隶属度为0，自身为1.
               u(i,k)=1;   
            else
                for j=1:c_max
                    t1=norm(x03(k,:)-z(j,:))^2;
                    t2=(t0/t1)^(2/(m-1));
                    sumn=sumn+t2;
                end
                u(i,k)=1/(sumn+0.00001);%得到第k的数据在第k类的隶属度
                sumn=0;
            end
        end
    end
%********************更新每类的代表中心z**********
    for i=1:c_max
        for k=1:n
            r1=u(i,k)^m;
            sum1=sum1+r1;
            sum0=sum0+x03(k,:).*r1;    
        end
        z(i,:)=sum0/(sum1+0.000001);
        sum0=0;sum1=0;
    end  
%********************终止条件部分***********
    e=norm(u-u0)^2;
    if num>500%防止陷入死循环
        break;
    end
end
%*******************画出其中的二维图********************
figure('name','均方根-样本熵-FCM聚类');
plot(x03(1:20,1),x03(1:20,2),'b+');hold on;
plot(x03(21:40,1),x03(21:40,2),'mx');hold on;
plot(x03(41:60,1),x03(41:60,2),'g*');hold on;
plot(x03(61:80,1),x03(61:80,2),'kd');hold on;
xlabel('均方根RM');ylabel('样本熵SE');
%plot(z(:,1),z(:,2),'ro');disp(z);
legend('为正常状态','为内圈故障','为滚动体故障','为外圈故障')

%% 波形因子-排列熵—FCM聚类

%x09=[tezheng1(21:40,2),tezheng1(21:40,6);
%     tezheng2(21:40,2),tezheng2(21:40,6);
%     tezheng3(21:40,2),tezheng3(21:40,6);
%     tezheng4(21:40,2),tezheng4(21:40,6)];
[n,n1]=size(x09);%x为样本数，n1为样本维数
m=2;
c_max=4;%round(sqrt(n));分的类数
%**x为n*m的矩阵，行为样本的个数，列为样本的维数***
%**z为c*m的矩阵，行为类的个数，列为每个类的代表中心***
%**u为c*n的矩阵，行为类的个数，列为样本数，表示某样本对类的隶属度***
z=x09(1:c_max,:);%z初始化，x的前c_max个样本为中心。
u=zeros(c_max,n);%u初始化
sumn=0;sum0=zeros(1,n1);sum1=0;num=0;
e=1;%精度初始化
while e>1e-6%隶属度值不再发生变化时终止
    u0=u;%记录前一个的u
    num=num+1;%记录循环次数
    for i=1:c_max %列更新u
        for k=1:n %行更新u 
       %*************计算每个隶属度**********
            t0=norm(x09(k,:)-z(i,:))^2;
            if t0==0%意味着某的数据就是类中心
               u(:,k)=0;%其他隶属度为0，自身为1.
               u(i,k)=1;   
            else
                for j=1:c_max
                    t1=norm(x09(k,:)-z(j,:))^2;
                    t2=(t0/t1)^(2/(m-1));
                    sumn=sumn+t2;
                end
                u(i,k)=1/(sumn+0.00001);%得到第k的数据在第k类的隶属度
                sumn=0;
            end
        end
    end
%********************更新每类的代表中心z**********
    for i=1:c_max
        for k=1:n
            r1=u(i,k)^m;
            sum1=sum1+r1;
            sum0=sum0+x09(k,:).*r1;    
        end
        z(i,:)=sum0/(sum1+0.000001);
        sum0=0;sum1=0;
    end  
%********************终止条件部分***********
    e=norm(u-u0)^2;
    if num>500%防止陷入死循环
        break;
    end
end
%*******************画出其中的二维图********************
figure('name','波形因子-排列熵-FCM聚类');
plot(x09(1:20,1),x09(1:20,2),'b+');hold on;
plot(x09(21:40,1),x09(21:40,2),'mx');hold on;
plot(x09(41:60,1),x09(41:60,2),'g*');hold on;
plot(x09(61:80,1),x09(61:80,2),'kd');hold on;
xlabel('波形因子S');ylabel('排列熵PE');
%plot(z(:,1),z(:,2),'ro');disp(z);
legend('为正常状态','为内圈故障','为滚动体故障','为外圈故障')

%% 裕度因子-条件熵—FCM聚类

%x11=[tezheng1(21:40,3),tezheng1(21:40,5);
%     tezheng2(21:40,3),tezheng2(21:40,5);
%     tezheng3(21:40,3),tezheng3(21:40,5);
%     tezheng4(21:40,3),tezheng4(21:40,5)];
[n,n1]=size(x11);%x为样本数，n1为样本维数
m=2;
c_max=4;%round(sqrt(n));分的类数
%**x为n*m的矩阵，行为样本的个数，列为样本的维数***
%**z为c*m的矩阵，行为类的个数，列为每个类的代表中心***
%**u为c*n的矩阵，行为类的个数，列为样本数，表示某样本对类的隶属度***
z=x11(1:c_max,:);%z初始化，x的前c_max个样本为中心。
u=zeros(c_max,n);%u初始化
sumn=0;sum0=zeros(1,n1);sum1=0;num=0;
e=1;%精度初始化
while e>1e-6%隶属度值不再发生变化时终止
    u0=u;%记录前一个的u
    num=num+1;%记录循环次数
    for i=1:c_max %列更新u
        for k=1:n %行更新u 
       %*************计算每个隶属度**********
            t0=norm(x11(k,:)-z(i,:))^2;
            if t0==0%意味着某的数据就是类中心
               u(:,k)=0;%其他隶属度为0，自身为1.
               u(i,k)=1;   
            else
                for j=1:c_max
                    t1=norm(x11(k,:)-z(j,:))^2;
                    t2=(t0/t1)^(2/(m-1));
                    sumn=sumn+t2;
                end
                u(i,k)=1/(sumn+0.00001);%得到第k的数据在第k类的隶属度
                sumn=0;
            end
        end
    end
%********************更新每类的代表中心z**********
    for i=1:c_max
        for k=1:n
            r1=u(i,k)^m;
            sum1=sum1+r1;
            sum0=sum0+x11(k,:).*r1;    
        end
        z(i,:)=sum0/(sum1+0.000001);
        sum0=0;sum1=0;
    end  
%********************终止条件部分***********
    e=norm(u-u0)^2;
    if num>500%防止陷入死循环
        break;
    end
end
%*******************画出其中的二维图********************
figure('name','裕度因子-条件熵-FCM聚类');
plot(x11(1:20,1),x11(1:20,2),'b+');hold on;
plot(x11(21:40,1),x11(21:40,2),'mx');hold on;
plot(x11(41:60,1),x11(41:60,2),'g*');hold on;
plot(x11(61:80,1),x11(61:80,2),'kd');hold on;
xlabel('裕度因子L');ylabel('条件熵CE');
%plot(z(:,1),z(:,2),'ro');disp(z);
legend('为正常状态','为内圈故障','为滚动体故障','为外圈故障')
