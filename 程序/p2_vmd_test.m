% test-script for VMD
% authors: Dominique Zosso and Konstantin Dragomiretskiy
% zosso@math.ucla.edu --- http://www.math.ucla.edu/~zosso
% Initial release 2013-12-12 (c) 2013
%
% When using this code, please do cite our paper:
% -----------------------------------------------
% K. Dragomiretskiy, D. Zosso, Variational Mode Decomposition, IEEE Trans.
% on Signal Processing (in press)
% please check here for update reference: 
%          http://dx.doi.org/10.1109/TSP.2013.2288675

%--------------- Preparation
clear all;
close all;
clc;

% Time Domain 0 to T
T = 1000;
fs = 1/T;
t = (1:T)/T;
freqs = 2*pi*(t-0.5-1/T)/(fs);

% center frequencies of components
f_1 = 2;
f_2 = 24;
f_3 = 288;

% modes
v_1 = (cos(2*pi*f_1*t));
v_2 = 1/4*(cos(2*pi*f_2*t));
v_3 = 1/16*(cos(2*pi*f_3*t));

% for visualization purposes
fsub = {};
wsub = {};
fsub{1} = v_1;
fsub{2} = v_2;
fsub{3} = v_3;
wsub{1} = 2*pi*f_1;
wsub{2} = 2*pi*f_2;
wsub{3} = 2*pi*f_3;

% composite signal, including noise
f = v_1 + v_2 + v_3 + 0.1*randn(size(v_1));
f_hat = fftshift((fft(f)));

% some sample parameters for VMD
alpha = 1000;        % moderate bandwidth constraint
tau = 0;            % noise-tolerance (no strict fidelity enforcement)
K = 4;              % 3 modes
DC = 0;             % no DC part imposed
init = 1;           % initialize omegas uniformly
tol = 1e-7;






%--------------- Run actual VMD code

[u, u_hat, omega] = VMD(f, alpha, tau, K, DC, init, tol);










%--------------- Visualization

% For convenience here: Order omegas increasingly and reindex u/u_hat
[~, sortIndex] = sort(omega(end,:));
omega = omega(:,sortIndex);
u_hat = u_hat(:,sortIndex);
u = u(sortIndex,:);
linestyles = {'b', 'g', 'm', 'c', 'c', 'r', 'k'};

figure('Name', 'Composite input signal' );
plot(t,f, 'k');;axis([0 1 -2 2]);xlabel('时间/s');ylabel('振幅/mm')
set(gca, 'XLim', [0 1]);

for sub = 1:length(fsub)
    figure('Name', ['Input signal component ' num2str(sub)] );
    plot(t,fsub{sub}, 'k');xlabel('时间/s');ylabel('振幅/mm');
    set(gca, 'XLim', [0 1]);
end

figure('Name', 'Input signal spectrum' );
subplot(2,1,1)
loglog(freqs(T/2+1:end), abs(f_hat(T/2+1:end)), 'k');xlabel('频率/Hz');ylabel('幅度/mm');
set(gca, 'XLim', [1 T/2]*pi*2, 'XGrid', 'on', 'YGrid', 'on', 'XMinorGrid', 'off', 'YMinorGrid', 'off');
set(gca,'XTickLabel',{'1','10','100'}, 'XGrid', 'on', 'YGrid', 'on', 'XMinorGrid', 'off', 'YMinorGrid', 'off');
ylims = get(gca, 'YLim');
hold on;
for sub = 1:length(wsub)
    loglog([wsub{sub} wsub{sub}], ylims, 'k--');
end
set(gca, 'YLim', ylims);
set(gca,'YTickLabel',{'0.1','1','10','100'});

figure('Name', 'Evolution of center frequencies omega');
subplot(2,1,1);
for k=1:K
    %semilogx(2*pi/fs*omega(:,k), 1:size(omega,1), linestyles{k});xlabel('中心频率/Hz');
    plot(1:size(omega,1), 2*pi/fs*omega(:,k), linestyles{k});xlabel('迭代次数');ylabel('中心频率/Hz');
    hold on;
end
%set(gca, 'YLim', [1,size(omega,1)]);
%set(gca, 'XLim', [2*pi,0.5*2*pi/fs], 'XGrid', 'on', 'XMinorGrid', 'on');
set(gca, 'XLim', [1,size(omega,1)]);
set(gca, 'YLim', [-300,2300], 'YGrid', 'on', 'YMinorGrid', 'on');
set(gca,'YTickLabel',{'0','80','160','240','320'});

figure('Name', 'Spectral decomposition');
subplot(2,1,1)
loglog(freqs(T/2+1:end), abs(f_hat(T/2+1:end)), 'k:');
set(gca, 'XLim', [1 T/2]*pi*2, 'XGrid', 'on', 'YGrid', 'on', 'XMinorGrid', 'off', 'YMinorGrid', 'off');
set(gca,'XTickLabel',{'1','10','100'}, 'XGrid', 'on', 'YGrid', 'on', 'XMinorGrid', 'off', 'YMinorGrid', 'off');
hold on;
for k = 1:K
    loglog(freqs(T/2+1:end), abs(u_hat(T/2+1:end,k)), linestyles{k});xlabel('频率/Hz');ylabel('幅度/mm');
end
set(gca, 'YLim', ylims);
set(gca,'YTickLabel',{'0.1','1','10','100'});


for k = 1:K
    figure('Name', ['Reconstructed mode ' num2str(k)]);
    plot(t,u(k,:), linestyles{k});   hold on;
    if ~isempty(fsub)
        plot(t, fsub{min(k,length(fsub))}, 'k:');xlabel('时间/s');ylabel('振幅/mm');
    end
    set(gca, 'XLim', [0 1]);
end

figure('name','VMD分解参数选择');
YXE=[];
NE=[];
E=sum(f.^2);
for st=1:9
    Es=0;
    K=st+1;
    [u, u_hat, omega] = VMD(f, alpha, tau, K, DC, init, tol);
    nf=f;
    u=flipud(u);
    resf=zeros(1,K);
    for i=1:K
        testdata=u(i,:);
        nf=nf-testdata;
        Ei=sum(testdata.^2);
        Es=Es+Ei;
    end
    yxE=sum(nf.^2);
    YXE(end+1)=yxE;
    nE=Es;%+yxE;
    NE(end+1)=nE/E;
end
subplot(2,1,1);plot([2:10],YXE,'k','LineWidth',1);xlabel('分解个数k');ylabel('余项能量');hold on;
subplot(2,1,2);plot([2:10],NE,'k','LineWidth',1);xlabel('分解个数k');ylabel('能量相似度');hold on;