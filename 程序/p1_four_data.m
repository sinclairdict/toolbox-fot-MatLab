clear all;
clc;
load 100.mat;%��������
load 108.mat;%��Ȧ����
load 121.mat;%����������
load 133.mat;%��Ȧ����
fs=12000;%������
N=3000;%����������100����
M=0;%�������ݶε���ʼλ��
n1=M:N-1;
t=n1/fs;%�ź�ʱ������
f=(0:N-1)*fs/N;

%% �����ź�ʱ����
%��������
X01=X100_DE_time(1:3000);%װ�� ���������˵���Ȧ��������
%��Ȧ����6��
X02=X108_DE_time(3001:6000);%װ�� ���������˵���Ȧ��������
%���������6��
X03=X121_DE_time(1:3000);%װ�� ���������˵���Ȧ��������
%��Ȧ����6��
X04=X133_DE_time(3001:6000);%װ�� ���������˵���Ȧ��������

figure('name','���������ֹ����źŲ���ͼ');
subplot(4,1,1)   %��ͼ
plot(t,X01,'LineWidth',1);axis([0 0.25 -0.32 0.32]);xlabel('ʱ��/s');ylabel('���/mm');
%title('(a)��������ź�');
subplot(4,1,2)   %��ͼ
plot(t,X02,'LineWidth',1);axis([0 0.25 -1.82 1.82]);xlabel('ʱ��/s');ylabel('���/mm');
%title('(b)�����Ȧ����');
subplot(4,1,3)   %��ͼ
plot(t,X03,'LineWidth',1);axis([0 0.25 -0.62 0.62]);xlabel('ʱ��/s');ylabel('���/mm');
%title('(c)��й��������');
subplot(4,1,4)   %��ͼ
plot(t,X04,'LineWidth',1);axis([0 0.25 -2.52 2.52]);xlabel('ʱ��/s');ylabel('���/mm');
%title('(d)�����Ȧ����');

%% �����ź�Ƶ����
figure('name','���������ֹ����ź�Ƶ��ͼ');
subplot(4,1,1)
y1=abs(fft(X01));
plot(f,y1);axis([0 5000 0 60]);xlabel('Ƶ��/Hz');ylabel('����/mm');
%title('(a)��������ź�');
subplot(4,1,2)
y2=abs(fft(X02));
plot(f,y2);axis([0 5000 0 180]);xlabel('Ƶ��/Hz');ylabel('����/mm');
%title('(b)�����Ȧ����');
subplot(4,1,3) 
y3=abs(fft(X03));
plot(f,y3);axis([0 5000 0 160]);xlabel('Ƶ��/Hz');ylabel('����/mm');
%title('(b)��й��������');
subplot(4,1,4)
y4=abs(fft(X04));
plot(f,y4);axis([0 5000 0 310]);xlabel('Ƶ��/Hz');ylabel('����/mm');
%title('(d)�����Ȧ����');

%% ���ģ̬�ֽ����K
K1=8;K2=8;K3=11;K4=10;

%% �����ź���ѷ���ʱ���Ƶ��
[u, ~, ~] = VMD(X01, 3000, 0.1, K1, 0, 1, 1e-6);
k01=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k01(end+1)=kurt;
end
[ma,I]=max(k01);
bestimf1=u(I,:);

figure('name','�����ź���ѷ���ʱ���Ƶ��');
subplot(2,1,1)   %��ͼ
plot(t,bestimf1,'LineWidth',1);axis([0 0.25 -0.015 0.015]);xlabel('ʱ��/s');ylabel('���/mm');
subplot(2,1,2)
y1=abs(fft(bestimf1));
plot(f,y1);axis([0 5000 0 1.5]);xlabel('Ƶ��/Hz');ylabel('����/mm');

%% ��Ȧ�����ź���ѷ���ʱ���Ƶ��
[u, ~, ~] = VMD(X02, 3000, 0.1, K2, 0, 1, 1e-6);
k02=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k02(end+1)=kurt;
end
[ma,I]=max(k02);
bestimf2=u(I,:);

figure('name','��Ȧ�����ź���ѷ���ʱ���Ƶ��');
subplot(2,1,1)   %��ͼ
plot(t,bestimf2,'LineWidth',1);axis([0 0.25 -0.8 0.8]);xlabel('ʱ��/s');ylabel('���/mm');
subplot(2,1,2)
y2=abs(fft(bestimf2));
plot(f,y2);axis([0 5000 0 100]);xlabel('Ƶ��/Hz');ylabel('����/mm');

%% ����������ź���ѷ���ʱ���Ƶ��
[u, ~, ~] = VMD(X03, 3000, 0.1, K3, 0, 1, 1e-6);
k03=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k03(end+1)=kurt;
end
[ma,I]=max(k03);
bestimf3=u(I,:);

figure('name','����������ź���ѷ���ʱ���Ƶ��');
subplot(2,1,1)   %��ͼ
plot(t,bestimf3,'LineWidth',1);axis([0 0.25 -0.15 0.15]);xlabel('ʱ��/s');ylabel('���/mm');
subplot(2,1,2)
y1=abs(fft(bestimf3));
plot(f,y3);axis([0 5000 0 160]);xlabel('Ƶ��/Hz');ylabel('����/mm');

%% ��Ȧ�����ź���ѷ���ʱ���Ƶ��
[u, ~, ~] = VMD(X04, 3000, 0.1, K4, 0, 1, 1e-6);
k04=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k04(end+1)=kurt;
end
[ma,I]=max(k04);
bestimf4=u(I,:);

figure('name','��Ȧ�����ź���ѷ���ʱ���Ƶ��');
subplot(2,1,1)   %��ͼ
plot(t,bestimf4,'LineWidth',1);axis([0 0.25 -0.32 0.32]);xlabel('ʱ��/s');ylabel('���/mm');
subplot(2,1,2)
y4=abs(fft(bestimf4));
plot(f,y4);axis([0 5000 0 2]);xlabel('Ƶ��/Hz');ylabel('����/mm');
