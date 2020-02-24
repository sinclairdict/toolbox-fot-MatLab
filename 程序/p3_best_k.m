clear all;
clc;
n=1730;   %电机转速
%d=7.9400;   %滚动体直径
%Z=9;    %滚动体个数
%D=39.0398;    %轴承节圆直径
%a=0;    %接触角

load 100.mat;%正常数据
load 108.mat;%内圈故障
load 121.mat;%滚动体数据
load 133.mat;%外圈故障

fs=12000;%采样率
N=3000;%采样点数（100倍）
M=0;%采样数据段的起始位置
n1=M:N-1;
t=n1/fs;%信号时间序列
f=(0:N-1)*fs/N;    %没啥好说的，信号频域横轴向量，不过待会要减半处理一下

%正常数据6组
X02=X100_DE_time(3001:6000)';%装载 驱动计数端的内圈故障数据
%内圈故障6组
X12=X108_DE_time(3001:6000)';%装载 驱动计数端的内圈故障数据
%滚动体故障6组
X22=X121_DE_time(3001:6000)';%装载 驱动计数端的内圈故障数据
%外圈故障6组
X32=X133_DE_time(3001:6000)';%装载 驱动计数端的内圈故障数据
alpha = 3000;        % moderate bandwidth constraint
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
K = 3;              % 3 modes
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-7;

%% 正常信号参数
figure('name','正常参数选择');
YXE1=[];
NE1=[];
E=sum(X02.^2);
for st=1:14
    Es=0;
    K=st+1;
    u = VMD(X02, alpha, tau, K, DC, init, tol);
    nf=X02;
    u=flipud(u);
    resf=zeros(1,K);
    for i=1:K
        testdata=u(i,:);
        nf=nf-testdata;
        Ei=sum(testdata.^2);
        Es=Es+Ei;
    end
    yxE=sum(nf.^2);
    YXE1(end+1)=yxE;
    nE=Es;%+yxE;
    NE1(end+1)=nE/E;
end
subplot(2,1,1);plot([2:15],YXE1,'k','LineWidth',1);xlabel('分解个数k');ylabel('余项能量');hold on;
subplot(2,1,2);plot([2:15],NE1,'k','LineWidth',1);xlabel('分解个数k');ylabel('分量能量和');hold on;

%% 内圈故障
figure('name','内圈故障参数选择');
YXE2=[];
NE2=[];
E=sum(X12.^2);
for st=1:14
    Es=0;
    K=st+1;
    u = VMD(X12, alpha, tau, K, DC, init, tol);
    nf=X12;
    u=flipud(u);
    resf=zeros(1,K);
    for i=1:K
        testdata=u(i,:);
        nf=nf-testdata;
        Ei=sum(testdata.^2);
        Es=Es+Ei;
    end
    yxE=sum(nf.^2);
    YXE2(end+1)=yxE;
    nE=Es;%+yxE;
    NE2(end+1)=nE/E;
end
subplot(2,1,1);plot([2:15],YXE2,'k','LineWidth',1);xlabel('分解个数k');ylabel('余项能量');hold on;
subplot(2,1,2);plot([2:15],NE2,'k','LineWidth',1);xlabel('分解个数k');ylabel('分量能量和');hold on;

%% 滚动体故障
figure('name','滚动体故障参数选择');
YXE3=[];
NE3=[];
E=sum(X22.^2);
for st=1:14
    Es=0;
    K=st+1;
    u = VMD(X22, alpha, tau, K, DC, init, tol);
    nf=X22;
    u=flipud(u);
    resf=zeros(1,K);
    for i=1:K
        testdata=u(i,:);
        nf=nf-testdata;
        Ei=sum(testdata.^2);
        Es=Es+Ei;
    end
    yxE=sum(nf.^2);
    YXE3(end+1)=yxE;
    nE=Es;%+yxE;
    NE3(end+1)=nE/E;
end
subplot(2,1,1);plot([2:15],YXE3,'k','LineWidth',1);xlabel('分解个数k');ylabel('余项能量');hold on;
subplot(2,1,2);plot([2:15],NE3,'k','LineWidth',1);xlabel('分解个数k');ylabel('分量能量和');hold on;

%% 外圈故障
figure('name','外圈故障参数选择');
YXE4=[];
NE4=[];
E=sum(X32.^2);
for st=1:14
    Es=0;
    K=st+1;
    u = VMD(X32, alpha, tau, K, DC, init, tol);
    nf=X32;
    u=flipud(u);
    resf=zeros(1,K);
    for i=1:K
        testdata=u(i,:);
        nf=nf-testdata;
        Ei=sum(testdata.^2);
        Es=Es+Ei;
    end
    yxE=sum(nf.^2);
    YXE4(end+1)=yxE;
    nE=Es;%+yxE;
    NE4(end+1)=nE/E;
end
subplot(2,1,1);plot([2:15],YXE4,'k','LineWidth',1);xlabel('分解个数k');ylabel('余项能量');hold on;
subplot(2,1,2);plot([2:15],NE4,'k','LineWidth',1);xlabel('分解个数k');ylabel('分量能量和');hold on;