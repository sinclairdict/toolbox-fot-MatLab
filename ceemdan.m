function [modes its]=ceemdan(x,Nstd,NR,MaxIter)

% WARNING: for this code works it is necessary to include in the same
%directoy the file emd.m developed by Rilling and Flandrin.
%This file is available at %http://perso.ens-lyon.fr/patrick.flandrin/emd.html
%We use the default stopping criterion.
%We use the last modification: 3.2007
% 
% This version was run on Matlab 7.10.0 (R2010a)
%----------------------------------------------------------------------
%   INPUTs
%   x: signal to decompose  //待分解信号
%   Nstd: noise standard deviation噪声标准偏差
%   NR: number of realizations数量的实现
%   MaxIter: maximum number of sifting iterations allowed.允许的筛选迭代的最大数目。
%
%  OUTPUTs
%  modes: contain the obtained modes in a matrix with the rows being the modes        
%   its: contain the sifting iterations needed for each mode for each realization (one row for each realization)
% -------------------------------------------------------------------------
%  Syntax
%
%  modes=ceemdan(x,Nstd,NR,MaxIter)
%  [modes its]=ceemdan(x,Nstd,NR,MaxIter)
%
%--------------------------------------------------------------------------
% This algorithm was presented at ICASSP 2011, Prague, Czech Republic
% Plese, if you use this code in your work, please cite the paper where the
% algorithm was first presented. 
% If you use this code, please cite:
%
% M.E.TORRES, M.A. COLOMINAS, G. SCHLOTTHAUER, P. FLANDRIN,
%  "A complete Ensemble Empirical Mode decomposition with adaptive noise," 
%  IEEE Int. Conf. on Acoust., Speech and Signal Proc. ICASSP-11, pp. 4144-4147, Prague (CZ)
%
% -------------------------------------------------------------------------
% Date: June 06,2011
% Authors:  Torres ME, Colominas MA, Schlotthauer G, Flandrin P.
% For problems with the code, please contact the authors:   
% To:  macolominas(AT)bioingenieria.edu.ar 
% CC:  metorres(AT)santafe-conicet.gov.ar
% -------------------------------------------------------------------------

x=x(:)';转置
desvio_x=std(x);标准差
x=x/desvio_x;

modes=zeros(size(x));生成size(x)Xsize(x)的零矩阵
temp=zeros(size(x));
aux=zeros(size(x));
acum=zeros(size(x));
iter=zeros(NR,round(log2(length(x))+5));生成NR X log2(length(x))+5取整的零矩阵

for i=1:NR
    white_noise{i}=randn(size(x));%创建随机噪声
end;

for i=1:NR
    modes_white_noise{i}=emd(white_noise{i});%计算高斯白噪声的模式
end;

for i=1:NR %计算第一模式
    temp=x+Nstd*white_noise{i};
    [temp, o, it]=emd(temp,'MAXMODES',1,'MAXITERATIONS',MaxIter);
    temp=temp(1,:);
    aux=aux+temp/NR;
    iter(i,1)=it;
end;

modes=aux; %保存第一模式
k=1;
aux=zeros(size(x));生成size(x)Xsize(x)的零矩阵
acum=sum(modes,1);求和

while  nnz(diff(sign(diff(x-acum))))>2 %计算其余的模式
    for i=1:NR
        tamanio=size(modes_white_noise{i});
        if tamanio(1)>=k+1
            noise=modes_white_noise{i}(k,:);
            noise=noise/std(noise);
            noise=Nstd*noise;
            try
                [temp, o, it]=emd(x-acum+std(x-acum)*noise,'MAXMODES',1,'MAXITERATIONS',MaxIter);
                temp=temp(1,:);
            catch
                it=0;
                temp=x-acum;
            end;
        else
            [temp, o, it]=emd(x-acum,'MAXMODES',1,'MAXITERATIONS',MaxIter);
            temp=temp(1,:);
        end;
        aux=aux+temp/NR;
    iter(i,k+1)=it;    
    end;
    modes=[modes;aux];
    aux=zeros(size(x));
    acum=zeros(size(x));
    acum=sum(modes,1);
    k=k+1;
end;
modes=[modes;(x-acum)];
[a b]=size(modes);
iter=iter(:,1:a);
modes=modes*desvio_x;
its=iter;


   