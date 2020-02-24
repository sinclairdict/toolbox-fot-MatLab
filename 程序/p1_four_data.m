clear all;
clc;
load 100.mat;%正常数据
load 108.mat;%内圈故障
load 121.mat;%滚动体数据
load 133.mat;%外圈故障
fs=12000;%采样率
N=3000;%采样点数（100倍）
M=0;%采样数据段的起始位置
n1=M:N-1;
t=n1/fs;%信号时间序列
f=(0:N-1)*fs/N;

%% 四种信号时域波形
%正常数据
X01=X100_DE_time(1:3000);%装载 驱动计数端的内圈故障数据
%内圈故障6组
X02=X108_DE_time(3001:6000);%装载 驱动计数端的内圈故障数据
%滚动体故障6组
X03=X121_DE_time(1:3000);%装载 驱动计数端的内圈故障数据
%外圈故障6组
X04=X133_DE_time(3001:6000);%装载 驱动计数端的内圈故障数据

figure('name','正常及三种故障信号波形图');
subplot(4,1,1)   %画图
plot(t,X01,'LineWidth',1);axis([0 0.25 -0.32 0.32]);xlabel('时间/s');ylabel('振幅/mm');
%title('(a)轴承正常信号');
subplot(4,1,2)   %画图
plot(t,X02,'LineWidth',1);axis([0 0.25 -1.82 1.82]);xlabel('时间/s');ylabel('振幅/mm');
%title('(b)轴承内圈故障');
subplot(4,1,3)   %画图
plot(t,X03,'LineWidth',1);axis([0 0.25 -0.62 0.62]);xlabel('时间/s');ylabel('振幅/mm');
%title('(c)轴承滚动体故障');
subplot(4,1,4)   %画图
plot(t,X04,'LineWidth',1);axis([0 0.25 -2.52 2.52]);xlabel('时间/s');ylabel('振幅/mm');
%title('(d)轴承外圈故障');

%% 四种信号频域波形
figure('name','正常及三种故障信号频谱图');
subplot(4,1,1)
y1=abs(fft(X01));
plot(f,y1);axis([0 5000 0 60]);xlabel('频率/Hz');ylabel('幅度/mm');
%title('(a)轴承正常信号');
subplot(4,1,2)
y2=abs(fft(X02));
plot(f,y2);axis([0 5000 0 180]);xlabel('频率/Hz');ylabel('幅度/mm');
%title('(b)轴承内圈故障');
subplot(4,1,3) 
y3=abs(fft(X03));
plot(f,y3);axis([0 5000 0 160]);xlabel('频率/Hz');ylabel('幅度/mm');
%title('(b)轴承滚动体故障');
subplot(4,1,4)
y4=abs(fft(X04));
plot(f,y4);axis([0 5000 0 310]);xlabel('频率/Hz');ylabel('幅度/mm');
%title('(d)轴承外圈故障');

%% 变分模态分解参数K
K1=8;K2=8;K3=11;K4=10;

%% 正常信号最佳分量时域和频域
[u, ~, ~] = VMD(X01, 3000, 0.1, K1, 0, 1, 1e-6);
k01=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k01(end+1)=kurt;
end
[ma,I]=max(k01);
bestimf1=u(I,:);

figure('name','正常信号最佳分量时域和频域');
subplot(2,1,1)   %画图
plot(t,bestimf1,'LineWidth',1);axis([0 0.25 -0.015 0.015]);xlabel('时间/s');ylabel('振幅/mm');
subplot(2,1,2)
y1=abs(fft(bestimf1));
plot(f,y1);axis([0 5000 0 1.5]);xlabel('频率/Hz');ylabel('幅度/mm');

%% 内圈故障信号最佳分量时域和频域
[u, ~, ~] = VMD(X02, 3000, 0.1, K2, 0, 1, 1e-6);
k02=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k02(end+1)=kurt;
end
[ma,I]=max(k02);
bestimf2=u(I,:);

figure('name','内圈故障信号最佳分量时域和频域');
subplot(2,1,1)   %画图
plot(t,bestimf2,'LineWidth',1);axis([0 0.25 -0.8 0.8]);xlabel('时间/s');ylabel('振幅/mm');
subplot(2,1,2)
y2=abs(fft(bestimf2));
plot(f,y2);axis([0 5000 0 100]);xlabel('频率/Hz');ylabel('幅度/mm');

%% 滚动体故障信号最佳分量时域和频域
[u, ~, ~] = VMD(X03, 3000, 0.1, K3, 0, 1, 1e-6);
k03=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k03(end+1)=kurt;
end
[ma,I]=max(k03);
bestimf3=u(I,:);

figure('name','滚动体故障信号最佳分量时域和频域');
subplot(2,1,1)   %画图
plot(t,bestimf3,'LineWidth',1);axis([0 0.25 -0.15 0.15]);xlabel('时间/s');ylabel('振幅/mm');
subplot(2,1,2)
y1=abs(fft(bestimf3));
plot(f,y3);axis([0 5000 0 160]);xlabel('频率/Hz');ylabel('幅度/mm');

%% 外圈故障信号最佳分量时域和频域
[u, ~, ~] = VMD(X04, 3000, 0.1, K4, 0, 1, 1e-6);
k04=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k04(end+1)=kurt;
end
[ma,I]=max(k04);
bestimf4=u(I,:);

figure('name','外圈故障信号最佳分量时域和频域');
subplot(2,1,1)   %画图
plot(t,bestimf4,'LineWidth',1);axis([0 0.25 -0.32 0.32]);xlabel('时间/s');ylabel('振幅/mm');
subplot(2,1,2)
y4=abs(fft(bestimf4));
plot(f,y4);axis([0 5000 0 2]);xlabel('频率/Hz');ylabel('幅度/mm');
