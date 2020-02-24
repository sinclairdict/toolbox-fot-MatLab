clear all;
clc;
n=1730;   %���ת��
%d=7.9400;   %������ֱ��
%Z=9;    %���������
%D=39.0398;    %��н�Բֱ��
%a=0;    %�Ӵ���

load 100.mat;%��������
load 108.mat;%��Ȧ����
load 121.mat;%����������
load 133.mat;%��Ȧ����

fs=12000;%������
N=3000;%����������100����
M=0;%�������ݶε���ʼλ��
n1=M:N-1;
t=n1/fs;%�ź�ʱ������
f=(0:N-1)*fs/N;    %ûɶ��˵�ģ��ź�Ƶ�������������������Ҫ���봦��һ��

%��������6��
X02=X100_DE_time(3001:6000)';%װ�� ���������˵���Ȧ��������
%��Ȧ����6��
X12=X108_DE_time(3001:6000)';%װ�� ���������˵���Ȧ��������
%���������6��
X22=X121_DE_time(3001:6000)';%װ�� ���������˵���Ȧ��������
%��Ȧ����6��
X32=X133_DE_time(3001:6000)';%װ�� ���������˵���Ȧ��������
alpha = 3000;        % moderate bandwidth constraint
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
K = 3;              % 3 modes
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-7;

%% �����źŲ���
figure('name','��������ѡ��');
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
subplot(2,1,1);plot([2:15],YXE1,'k','LineWidth',1);xlabel('�ֽ����k');ylabel('��������');hold on;
subplot(2,1,2);plot([2:15],NE1,'k','LineWidth',1);xlabel('�ֽ����k');ylabel('����������');hold on;

%% ��Ȧ����
figure('name','��Ȧ���ϲ���ѡ��');
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
subplot(2,1,1);plot([2:15],YXE2,'k','LineWidth',1);xlabel('�ֽ����k');ylabel('��������');hold on;
subplot(2,1,2);plot([2:15],NE2,'k','LineWidth',1);xlabel('�ֽ����k');ylabel('����������');hold on;

%% ���������
figure('name','��������ϲ���ѡ��');
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
subplot(2,1,1);plot([2:15],YXE3,'k','LineWidth',1);xlabel('�ֽ����k');ylabel('��������');hold on;
subplot(2,1,2);plot([2:15],NE3,'k','LineWidth',1);xlabel('�ֽ����k');ylabel('����������');hold on;

%% ��Ȧ����
figure('name','��Ȧ���ϲ���ѡ��');
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
subplot(2,1,1);plot([2:15],YXE4,'k','LineWidth',1);xlabel('�ֽ����k');ylabel('��������');hold on;
subplot(2,1,2);plot([2:15],NE4,'k','LineWidth',1);xlabel('�ֽ����k');ylabel('����������');hold on;