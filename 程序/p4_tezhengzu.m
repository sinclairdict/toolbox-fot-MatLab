%通过变分模态分解分解轴承故障信号，并由峭度值，选取最佳模态分量。
%提取：均方根、波形因子、裕度因子、样本熵、条件熵、排列熵。
clear all;
clc;

%% 设定VMD分解个数
K1=8;K2=8;K3=11;K4=10;

%% 设定特征提取参数（se样本熵；ce条件熵；pe排列熵）
se11=2;se12=2; ce11=2;ce12=2; pe1=2; 
se21=2;se22=2; ce21=2;ce22=2; pe2=2; 
se31=2;se32=2; ce31=2;ce32=2; pe3=2; 
se41=2;se42=2; ce41=2;ce42=2; pe4=2; 

%% 导入数据
load 100.mat;%正常数据
load 108.mat;%内圈故障
load 121.mat;%滚动体数据
load 133.mat;%外圈故障

%% 数据分组
%正常数据50组
X101=X100_DE_time(1:3000);
X102=X100_DE_time(3001:6000);
X103=X100_DE_time(6001:9000);
X104=X100_DE_time(9001:12000);
X105=X100_DE_time(12001:15000);
X106=X100_DE_time(15001:18000);
X107=X100_DE_time(18001:21000);
X108=X100_DE_time(21001:24000);
X109=X100_DE_time(24001:27000);
X110=X100_DE_time(27001:30000);
X111=X100_DE_time(30001:33000);
X112=X100_DE_time(33001:36000);
X113=X100_DE_time(36001:39000);
X114=X100_DE_time(39001:42000);
X115=X100_DE_time(42001:45000);
X116=X100_DE_time(45001:48000);
X117=X100_DE_time(48001:51000);
X118=X100_DE_time(51001:54000);
X119=X100_DE_time(54001:57000);
X120=X100_DE_time(57001:60000);
X121=X100_DE_time(60001:63000);
X122=X100_DE_time(63001:66000);
X123=X100_DE_time(66001:69000);
X124=X100_DE_time(69001:72000);
X125=X100_DE_time(72001:75000);
X126=X100_DE_time(75001:78000);
X127=X100_DE_time(78001:81000);
X128=X100_DE_time(81001:84000);
X129=X100_DE_time(84001:87000);
X130=X100_DE_time(87001:90000);
X131=X100_DE_time(90001:93000);
X132=X100_DE_time(93001:96000);
X133=X100_DE_time(96001:99000);
X134=X100_DE_time(99001:102000);
X135=X100_DE_time(102001:105000);
X136=X100_DE_time(105001:108000);
X137=X100_DE_time(108001:111000);
X138=X100_DE_time(111001:114000);
X139=X100_DE_time(114001:117000);
X140=X100_DE_time(117001:120000);
X141=X100_DE_time(120001:123000);
X142=X100_DE_time(123001:126000);
X143=X100_DE_time(126001:129000);
X144=X100_DE_time(129001:132000);
X145=X100_DE_time(132001:135000);
X146=X100_DE_time(135001:138000);
X147=X100_DE_time(138001:141000);
X148=X100_DE_time(141001:144000);
X149=X100_DE_time(144001:147000);
X150=X100_DE_time(147001:150000);

%内圈故障50组
X201=X108_DE_time(1:3000);
X202=X108_DE_time(3001:6000);
X203=X108_DE_time(6001:9000);
X204=X108_DE_time(9001:12000);
X205=X108_DE_time(12001:15000);
X206=X108_DE_time(15001:18000);
X207=X108_DE_time(18001:21000);
X208=X108_DE_time(21001:24000);
X209=X108_DE_time(24001:27000);
X210=X108_DE_time(27001:30000);
X211=X108_DE_time(30001:33000);
X212=X108_DE_time(33001:36000);
X213=X108_DE_time(36001:39000);
X214=X108_DE_time(39001:42000);
X215=X108_DE_time(42001:45000);
X216=X108_DE_time(45001:48000);
X217=X108_DE_time(48001:51000);
X218=X108_DE_time(51001:54000);
X219=X108_DE_time(54001:57000);
X220=X108_DE_time(57001:60000);
X221=X108_DE_time(60001:63000);
X222=X108_DE_time(63001:66000);
X223=X108_DE_time(66001:69000);
X224=X108_DE_time(69001:72000);
X225=X108_DE_time(72001:75000);
X226=X108_DE_time(75001:78000);
X227=X108_DE_time(78001:81000);
X228=X108_DE_time(81001:84000);
X229=X108_DE_time(84001:87000);
X230=X108_DE_time(87001:90000);
X231=X108_DE_time(90001:93000);
X232=X108_DE_time(93001:96000);
X233=X108_DE_time(96001:99000);
X234=X108_DE_time(99001:102000);
X235=X108_DE_time(102001:105000);
X236=X108_DE_time(105001:108000);
X237=X108_DE_time(108001:111000);
X238=X108_DE_time(111001:114000);
X239=X108_DE_time(114001:117000);
X240=X108_DE_time(117001:120000);
X241=X108_DE_time(80001:83000);
X242=X108_DE_time(83001:86000);
X243=X108_DE_time(86001:89000);
X244=X108_DE_time(89001:92000);
X245=X108_DE_time(92001:95000);
X246=X108_DE_time(95001:98000);
X247=X108_DE_time(98001:101000);
X248=X108_DE_time(101001:104000);
X249=X108_DE_time(104001:107000);
X250=X108_DE_time(107001:110000);

%滚动体故障50组
X301=X121_DE_time(1:3000);
X302=X121_DE_time(3001:6000);
X303=X121_DE_time(6001:9000);
X304=X121_DE_time(9001:12000);
X305=X121_DE_time(12001:15000);
X306=X121_DE_time(15001:18000);
X307=X121_DE_time(18001:21000);
X308=X121_DE_time(21001:24000);
X309=X121_DE_time(24001:27000);
X310=X121_DE_time(27001:30000);
X311=X121_DE_time(30001:33000);
X312=X121_DE_time(33001:36000);
X313=X121_DE_time(36001:39000);
X314=X121_DE_time(39001:42000);
X315=X121_DE_time(42001:45000);
X316=X121_DE_time(45001:48000);
X317=X121_DE_time(48001:51000);
X318=X121_DE_time(51001:54000);
X319=X121_DE_time(54001:57000);
X320=X121_DE_time(57001:60000);
X321=X121_DE_time(60001:63000);
X322=X121_DE_time(63001:66000);
X323=X121_DE_time(66001:69000);
X324=X121_DE_time(69001:72000);
X325=X121_DE_time(72001:75000);
X326=X121_DE_time(75001:78000);
X327=X121_DE_time(78001:81000);
X328=X121_DE_time(81001:84000);
X329=X121_DE_time(84001:87000);
X330=X121_DE_time(87001:90000);
X331=X121_DE_time(90001:93000);
X332=X121_DE_time(93001:96000);
X333=X121_DE_time(96001:99000);
X334=X121_DE_time(99001:102000);
X335=X121_DE_time(102001:105000);
X336=X121_DE_time(105001:108000);
X337=X121_DE_time(108001:111000);
X338=X121_DE_time(111001:114000);
X339=X121_DE_time(114001:117000);
X340=X121_DE_time(117001:120000);
X341=X121_DE_time(80001:83000);
X342=X121_DE_time(83001:86000);
X343=X121_DE_time(86001:89000);
X344=X121_DE_time(89001:92000);
X345=X121_DE_time(92001:95000);
X346=X121_DE_time(95001:98000);
X347=X121_DE_time(98001:101000);
X348=X121_DE_time(101001:104000);
X349=X121_DE_time(104001:107000);
X350=X121_DE_time(107001:110000);

%外圈故障50组
X401=X133_DE_time(1:3000);
X402=X133_DE_time(3001:6000);
X403=X133_DE_time(6001:9000);
X404=X133_DE_time(9001:12000);
X405=X133_DE_time(12001:15000);
X406=X133_DE_time(15001:18000);
X407=X133_DE_time(18001:21000);
X408=X133_DE_time(21001:24000);
X409=X133_DE_time(24001:27000);
X410=X133_DE_time(27001:30000);
X411=X133_DE_time(30001:33000);
X412=X133_DE_time(33001:36000);
X413=X133_DE_time(36001:39000);
X414=X133_DE_time(39001:42000);
X415=X133_DE_time(42001:45000);
X416=X133_DE_time(45001:48000);
X417=X133_DE_time(48001:51000);
X418=X133_DE_time(51001:54000);
X419=X133_DE_time(54001:57000);
X420=X133_DE_time(57001:60000);
X421=X133_DE_time(60001:63000);
X422=X133_DE_time(63001:66000);
X423=X133_DE_time(66001:69000);
X424=X133_DE_time(69001:72000);
X425=X133_DE_time(72001:75000);
X426=X133_DE_time(75001:78000);
X427=X133_DE_time(78001:81000);
X428=X133_DE_time(81001:84000);
X429=X133_DE_time(84001:87000);
X430=X133_DE_time(87001:90000);
X431=X133_DE_time(90001:93000);
X432=X133_DE_time(93001:96000);
X433=X133_DE_time(96001:99000);
X434=X133_DE_time(99001:102000);
X435=X133_DE_time(102001:105000);
X436=X133_DE_time(105001:108000);
X437=X133_DE_time(108001:111000);
X438=X133_DE_time(111001:114000);
X439=X133_DE_time(114001:117000);
X440=X133_DE_time(117001:120000);
X441=X133_DE_time(80001:83000);
X442=X133_DE_time(83001:86000);
X443=X133_DE_time(86001:89000);
X444=X133_DE_time(89001:92000);
X445=X133_DE_time(92001:95000);
X446=X133_DE_time(95001:98000);
X447=X133_DE_time(98001:101000);
X448=X133_DE_time(101001:104000);
X449=X133_DE_time(104001:107000);
X450=X133_DE_time(107001:110000);

%% 正常信号VMD分解，并提取最佳模态的特征组
[u, ~, ~] = VMD(X101, 3000, 0.1, K1, 0, 1, 1e-6);
k101=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k101(end+1)=kurt;
end
[~,I]=max(k101);
testdata101=u(I,:);
[u, ~, ~] = VMD(X102, 3000, 0.1, K1, 0, 1, 1e-6);
k102=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k102(end+1)=kurt;
end
[~,I]=max(k102);
testdata102=u(I,:);
[u, ~, ~] = VMD(X103, 3000, 0.1, K1, 0, 1, 1e-6);
k103=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k103(end+1)=kurt;
end
[~,I]=max(k103);
testdata103=u(I,:);
[u, ~, ~] = VMD(X104, 3000, 0.1, K1, 0, 1, 1e-6);
k104=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k104(end+1)=kurt;
end
[~,I]=max(k104);
testdata104=u(I,:);
[u, ~, ~] = VMD(X105, 3000, 0.1, K1, 0, 1, 1e-6);
k105=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k105(end+1)=kurt;
end
[~,I]=max(k105);
testdata105=u(I,:);
[u, ~, ~] = VMD(X106, 3000, 0.1, K1, 0, 1, 1e-6);
k106=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k106(end+1)=kurt;
end
[~,I]=max(k106);
testdata106=u(I,:);
[u, ~, ~] = VMD(X107, 3000, 0.1, K1, 0, 1, 1e-6);
k107=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k107(end+1)=kurt;
end
[~,I]=max(k107);
testdata107=u(I,:);
[u, ~, ~] = VMD(X108, 3000, 0.1, K1, 0, 1, 1e-6);
k108=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k108(end+1)=kurt;
end
[~,I]=max(k108);
testdata108=u(I,:);
[u, ~, ~] = VMD(X109, 3000, 0.1, K1, 0, 1, 1e-6);
k109=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k109(end+1)=kurt;
end
[~,I]=max(k109);
testdata109=u(I,:);
[u, ~, ~] = VMD(X110, 3000, 0.1, K1, 0, 1, 1e-6);
k110=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k110(end+1)=kurt;
end
[~,I]=max(k110);
testdata110=u(I,:);
[u, ~, ~] = VMD(X111, 3000, 0.1, K1, 0, 1, 1e-6);
k111=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k111(end+1)=kurt;
end
[~,I]=max(k111);
testdata111=u(I,:);
[u, ~, ~] = VMD(X112, 3000, 0.1, K1, 0, 1, 1e-6);
k112=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k112(end+1)=kurt;
end
[~,I]=max(k112);
testdata112=u(I,:);
[u, ~, ~] = VMD(X113, 3000, 0.1, K1, 0, 1, 1e-6);
k113=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k113(end+1)=kurt;
end
[~,I]=max(k113);
testdata113=u(I,:);
[u, ~, ~] = VMD(X114, 3000, 0.1, K1, 0, 1, 1e-6);
k114=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k114(end+1)=kurt;
end
[~,I]=max(k114);
testdata114=u(I,:);
[u, ~, ~] = VMD(X115, 3000, 0.1, K1, 0, 1, 1e-6);
k115=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k115(end+1)=kurt;
end
[~,I]=max(k115);
testdata115=u(I,:);
[u, ~, ~] = VMD(X116, 3000, 0.1, K1, 0, 1, 1e-6);
k116=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k116(end+1)=kurt;
end
[~,I]=max(k116);
testdata116=u(I,:);
[u, ~, ~] = VMD(X117, 3000, 0.1, K1, 0, 1, 1e-6);
k117=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k117(end+1)=kurt;
end
[~,I]=max(k117);
testdata117=u(I,:);
[u, ~, ~] = VMD(X118, 3000, 0.1, K1, 0, 1, 1e-6);
k118=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k118(end+1)=kurt;
end
[~,I]=max(k118);
testdata118=u(I,:);
[u, ~, ~] = VMD(X119, 3000, 0.1, K1, 0, 1, 1e-6);
k119=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k119(end+1)=kurt;
end
[~,I]=max(k119);
testdata119=u(I,:);
[u, ~, ~] = VMD(X120, 3000, 0.1, K1, 0, 1, 1e-6);
k120=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k120(end+1)=kurt;
end
[~,I]=max(k120);
testdata120=u(I,:);
[u, ~, ~] = VMD(X121, 3000, 0.1, K1, 0, 1, 1e-6);
k121=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k121(end+1)=kurt;
end
[~,I]=max(k121);
testdata121=u(I,:);
[u, ~, ~] = VMD(X122, 3000, 0.1, K1, 0, 1, 1e-6);
k122=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k122(end+1)=kurt;
end
[~,I]=max(k122);
testdata122=u(I,:);
[u, ~, ~] = VMD(X123, 3000, 0.1, K1, 0, 1, 1e-6);
k123=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k123(end+1)=kurt;
end
[~,I]=max(k123);
testdata123=u(I,:);
[u, ~, ~] = VMD(X124, 3000, 0.1, K1, 0, 1, 1e-6);
k124=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k124(end+1)=kurt;
end
[~,I]=max(k124);
testdata124=u(I,:);
[u, ~, ~] = VMD(X125, 3000, 0.1, K1, 0, 1, 1e-6);
k125=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k125(end+1)=kurt;
end
[~,I]=max(k125);
testdata125=u(I,:);
[u, ~, ~] = VMD(X126, 3000, 0.1, K1, 0, 1, 1e-6);
k126=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k126(end+1)=kurt;
end
[~,I]=max(k126);
testdata126=u(I,:);
[u, ~, ~] = VMD(X127, 3000, 0.1, K1, 0, 1, 1e-6);
k127=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k127(end+1)=kurt;
end
[~,I]=max(k127);
testdata127=u(I,:);
[u, ~, ~] = VMD(X128, 3000, 0.1, K1, 0, 1, 1e-6);
k128=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k128(end+1)=kurt;
end
[~,I]=max(k128);
testdata128=u(I,:);
[u, ~, ~] = VMD(X129, 3000, 0.1, K1, 0, 1, 1e-6);
k129=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k129(end+1)=kurt;
end
[~,I]=max(k129);
testdata129=u(I,:);
[u, ~, ~] = VMD(X130, 3000, 0.1, K1, 0, 1, 1e-6);
k130=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k130(end+1)=kurt;
end
[~,I]=max(k130);
testdata130=u(I,:);
[u, ~, ~] = VMD(X131, 3000, 0.1, K1, 0, 1, 1e-6);
k131=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k131(end+1)=kurt;
end
[~,I]=max(k131);
testdata131=u(I,:);
[u, ~, ~] = VMD(X132, 3000, 0.1, K1, 0, 1, 1e-6);
k132=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k132(end+1)=kurt;
end
[~,I]=max(k132);
testdata132=u(I,:);
[u, ~, ~] = VMD(X133, 3000, 0.1, K1, 0, 1, 1e-6);
k133=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k133(end+1)=kurt;
end
[~,I]=max(k133);
testdata133=u(I,:);
[u, ~, ~] = VMD(X134, 3000, 0.1, K1, 0, 1, 1e-6);
k134=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k134(end+1)=kurt;
end
[~,I]=max(k134);
testdata134=u(I,:);
[u, ~, ~] = VMD(X135, 3000, 0.1, K1, 0, 1, 1e-6);
k135=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k135(end+1)=kurt;
end
[~,I]=max(k135);
testdata135=u(I,:);
[u, ~, ~] = VMD(X136, 3000, 0.1, K1, 0, 1, 1e-6);
k136=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k136(end+1)=kurt;
end
[~,I]=max(k136);
testdata136=u(I,:);
[u, ~, ~] = VMD(X137, 3000, 0.1, K1, 0, 1, 1e-6);
k137=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k137(end+1)=kurt;
end
[~,I]=max(k137);
testdata137=u(I,:);
[u, ~, ~] = VMD(X138, 3000, 0.1, K1, 0, 1, 1e-6);
k138=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k138(end+1)=kurt;
end
[~,I]=max(k138);
testdata138=u(I,:);
[u, ~, ~] = VMD(X139, 3000, 0.1, K1, 0, 1, 1e-6);
k139=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k139(end+1)=kurt;
end
[~,I]=max(k139);
testdata139=u(I,:);
[u, ~, ~] = VMD(X140, 3000, 0.1, K1, 0, 1, 1e-6);
k140=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k140(end+1)=kurt;
end
[~,I]=max(k140);
testdata140=u(I,:);
[u, ~, ~] = VMD(X141, 3000, 0.1, K1, 0, 1, 1e-6);
k141=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k141(end+1)=kurt;
end
[~,I]=max(k141);
testdata141=u(I,:);
[u, ~, ~] = VMD(X142, 3000, 0.1, K1, 0, 1, 1e-6);
k142=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k142(end+1)=kurt;
end
[~,I]=max(k142);
testdata142=u(I,:);
[u, ~, ~] = VMD(X143, 3000, 0.1, K1, 0, 1, 1e-6);
k143=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k143(end+1)=kurt;
end
[~,I]=max(k143);
testdata143=u(I,:);
[u, ~, ~] = VMD(X144, 3000, 0.1, K1, 0, 1, 1e-6);
k144=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k144(end+1)=kurt;
end
[~,I]=max(k144);
testdata144=u(I,:);
[u, ~, ~] = VMD(X145, 3000, 0.1, K1, 0, 1, 1e-6);
k145=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k145(end+1)=kurt;
end
[~,I]=max(k145);
testdata145=u(I,:);
[u, ~, ~] = VMD(X146, 3000, 0.1, K1, 0, 1, 1e-6);
k146=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k146(end+1)=kurt;
end
[~,I]=max(k146);
testdata146=u(I,:);
[u, ~, ~] = VMD(X147, 3000, 0.1, K1, 0, 1, 1e-6);
k147=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k147(end+1)=kurt;
end
[~,I]=max(k147);
testdata147=u(I,:);
[u, ~, ~] = VMD(X148, 3000, 0.1, K1, 0, 1, 1e-6);
k148=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k148(end+1)=kurt;
end
[~,I]=max(k148);
testdata148=u(I,:);
[u, ~, ~] = VMD(X149, 3000, 0.1, K1, 0, 1, 1e-6);
k149=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k149(end+1)=kurt;
end
[~,I]=max(k149);
testdata149=u(I,:);
[u, ~, ~] = VMD(X150, 3000, 0.1, K1, 0, 1, 1e-6);
k150=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k150(end+1)=kurt;
end
[~,I]=max(k150);
testdata150=u(I,:);

RM101=rms(testdata101); S101 = rms(testdata101)/mean(abs(testdata101)); L101=(max(testdata101)-min(testdata101))/mean(sqrt(abs(testdata101)))^2; SE101=SampEn(testdata101,se11,se12); CE101=CondEn(testdata101,ce11,ce12); PE101=PermEn(testdata101,pe1);
RM102=rms(testdata102); S102 = rms(testdata102)/mean(abs(testdata102)); L102=(max(testdata102)-min(testdata102))/mean(sqrt(abs(testdata102)))^2; SE102=SampEn(testdata102,se11,se12); CE102=CondEn(testdata102,ce11,ce12); PE102=PermEn(testdata102,pe1);
RM103=rms(testdata103); S103 = rms(testdata103)/mean(abs(testdata103)); L103=(max(testdata103)-min(testdata103))/mean(sqrt(abs(testdata103)))^2; SE103=SampEn(testdata103,se11,se12); CE103=CondEn(testdata103,ce11,ce12); PE103=PermEn(testdata103,pe1);
RM104=rms(testdata104); S104 = rms(testdata104)/mean(abs(testdata104)); L104=(max(testdata104)-min(testdata104))/mean(sqrt(abs(testdata104)))^2; SE104=SampEn(testdata104,se11,se12); CE104=CondEn(testdata104,ce11,ce12); PE104=PermEn(testdata104,pe1);
RM105=rms(testdata105); S105 = rms(testdata105)/mean(abs(testdata105)); L105=(max(testdata105)-min(testdata105))/mean(sqrt(abs(testdata105)))^2; SE105=SampEn(testdata105,se11,se12); CE105=CondEn(testdata105,ce11,ce12); PE105=PermEn(testdata105,pe1);
RM106=rms(testdata106); S106 = rms(testdata106)/mean(abs(testdata106)); L106=(max(testdata106)-min(testdata106))/mean(sqrt(abs(testdata106)))^2; SE106=SampEn(testdata106,se11,se12); CE106=CondEn(testdata106,ce11,ce12); PE106=PermEn(testdata106,pe1);
RM107=rms(testdata107); S107 = rms(testdata107)/mean(abs(testdata107)); L107=(max(testdata107)-min(testdata107))/mean(sqrt(abs(testdata107)))^2; SE107=SampEn(testdata107,se11,se12); CE107=CondEn(testdata107,ce11,ce12); PE107=PermEn(testdata107,pe1);
RM108=rms(testdata108); S108 = rms(testdata108)/mean(abs(testdata108)); L108=(max(testdata108)-min(testdata108))/mean(sqrt(abs(testdata108)))^2; SE108=SampEn(testdata108,se11,se12); CE108=CondEn(testdata108,ce11,ce12); PE108=PermEn(testdata108,pe1);
RM109=rms(testdata109); S109 = rms(testdata109)/mean(abs(testdata109)); L109=(max(testdata109)-min(testdata109))/mean(sqrt(abs(testdata109)))^2; SE109=SampEn(testdata109,se11,se12); CE109=CondEn(testdata109,ce11,ce12); PE109=PermEn(testdata109,pe1);
RM110=rms(testdata110); S110 = rms(testdata110)/mean(abs(testdata110)); L110=(max(testdata110)-min(testdata110))/mean(sqrt(abs(testdata110)))^2; SE110=SampEn(testdata110,se11,se12); CE110=CondEn(testdata110,ce11,ce12); PE110=PermEn(testdata110,pe1);
RM111=rms(testdata111); S111 = rms(testdata111)/mean(abs(testdata111)); L111=(max(testdata111)-min(testdata111))/mean(sqrt(abs(testdata111)))^2; SE111=SampEn(testdata111,se11,se12); CE111=CondEn(testdata111,ce11,ce12); PE111=PermEn(testdata111,pe1);
RM112=rms(testdata112); S112 = rms(testdata112)/mean(abs(testdata112)); L112=(max(testdata112)-min(testdata112))/mean(sqrt(abs(testdata112)))^2; SE112=SampEn(testdata112,se11,se12); CE112=CondEn(testdata112,ce11,ce12); PE112=PermEn(testdata112,pe1);
RM113=rms(testdata113); S113 = rms(testdata113)/mean(abs(testdata113)); L113=(max(testdata113)-min(testdata113))/mean(sqrt(abs(testdata113)))^2; SE113=SampEn(testdata113,se11,se12); CE113=CondEn(testdata113,ce11,ce12); PE113=PermEn(testdata113,pe1);
RM114=rms(testdata114); S114 = rms(testdata114)/mean(abs(testdata114)); L114=(max(testdata114)-min(testdata114))/mean(sqrt(abs(testdata114)))^2; SE114=SampEn(testdata114,se11,se12); CE114=CondEn(testdata114,ce11,ce12); PE114=PermEn(testdata114,pe1);
RM115=rms(testdata115); S115 = rms(testdata115)/mean(abs(testdata115)); L115=(max(testdata115)-min(testdata115))/mean(sqrt(abs(testdata115)))^2; SE115=SampEn(testdata115,se11,se12); CE115=CondEn(testdata115,ce11,ce12); PE115=PermEn(testdata115,pe1);
RM116=rms(testdata116); S116 = rms(testdata116)/mean(abs(testdata116)); L116=(max(testdata116)-min(testdata116))/mean(sqrt(abs(testdata116)))^2; SE116=SampEn(testdata116,se11,se12); CE116=CondEn(testdata116,ce11,ce12); PE116=PermEn(testdata116,pe1);
RM117=rms(testdata117); S117 = rms(testdata117)/mean(abs(testdata117)); L117=(max(testdata117)-min(testdata117))/mean(sqrt(abs(testdata117)))^2; SE117=SampEn(testdata117,se11,se12); CE117=CondEn(testdata117,ce11,ce12); PE117=PermEn(testdata117,pe1);
RM118=rms(testdata118); S118 = rms(testdata118)/mean(abs(testdata118)); L118=(max(testdata118)-min(testdata118))/mean(sqrt(abs(testdata118)))^2; SE118=SampEn(testdata118,se11,se12); CE118=CondEn(testdata118,ce11,ce12); PE118=PermEn(testdata118,pe1);
RM119=rms(testdata119); S119 = rms(testdata119)/mean(abs(testdata119)); L119=(max(testdata119)-min(testdata119))/mean(sqrt(abs(testdata119)))^2; SE119=SampEn(testdata119,se11,se12); CE119=CondEn(testdata119,ce11,ce12); PE119=PermEn(testdata119,pe1);
RM120=rms(testdata120); S120 = rms(testdata120)/mean(abs(testdata120)); L120=(max(testdata120)-min(testdata120))/mean(sqrt(abs(testdata120)))^2; SE120=SampEn(testdata120,se11,se12); CE120=CondEn(testdata120,ce11,ce12); PE120=PermEn(testdata120,pe1);
RM121=rms(testdata121); S121 = rms(testdata121)/mean(abs(testdata121)); L121=(max(testdata121)-min(testdata121))/mean(sqrt(abs(testdata121)))^2; SE121=SampEn(testdata121,se11,se12); CE121=CondEn(testdata121,ce11,ce12); PE121=PermEn(testdata121,pe1);
RM122=rms(testdata122); S122 = rms(testdata122)/mean(abs(testdata122)); L122=(max(testdata122)-min(testdata122))/mean(sqrt(abs(testdata122)))^2; SE122=SampEn(testdata122,se11,se12); CE122=CondEn(testdata122,ce11,ce12); PE122=PermEn(testdata122,pe1);
RM123=rms(testdata123); S123 = rms(testdata123)/mean(abs(testdata123)); L123=(max(testdata123)-min(testdata123))/mean(sqrt(abs(testdata123)))^2; SE123=SampEn(testdata123,se11,se12); CE123=CondEn(testdata123,ce11,ce12); PE123=PermEn(testdata123,pe1);
RM124=rms(testdata124); S124 = rms(testdata124)/mean(abs(testdata124)); L124=(max(testdata124)-min(testdata124))/mean(sqrt(abs(testdata124)))^2; SE124=SampEn(testdata124,se11,se12); CE124=CondEn(testdata124,ce11,ce12); PE124=PermEn(testdata124,pe1);
RM125=rms(testdata125); S125 = rms(testdata125)/mean(abs(testdata125)); L125=(max(testdata125)-min(testdata125))/mean(sqrt(abs(testdata125)))^2; SE125=SampEn(testdata125,se11,se12); CE125=CondEn(testdata125,ce11,ce12); PE125=PermEn(testdata125,pe1);
RM126=rms(testdata126); S126 = rms(testdata126)/mean(abs(testdata126)); L126=(max(testdata126)-min(testdata126))/mean(sqrt(abs(testdata126)))^2; SE126=SampEn(testdata126,se11,se12); CE126=CondEn(testdata126,ce11,ce12); PE126=PermEn(testdata126,pe1);
RM127=rms(testdata127); S127 = rms(testdata127)/mean(abs(testdata127)); L127=(max(testdata127)-min(testdata127))/mean(sqrt(abs(testdata127)))^2; SE127=SampEn(testdata127,se11,se12); CE127=CondEn(testdata127,ce11,ce12); PE127=PermEn(testdata127,pe1);
RM128=rms(testdata128); S128 = rms(testdata128)/mean(abs(testdata128)); L128=(max(testdata128)-min(testdata128))/mean(sqrt(abs(testdata128)))^2; SE128=SampEn(testdata128,se11,se12); CE128=CondEn(testdata128,ce11,ce12); PE128=PermEn(testdata128,pe1);
RM129=rms(testdata129); S129 = rms(testdata129)/mean(abs(testdata129)); L129=(max(testdata129)-min(testdata129))/mean(sqrt(abs(testdata129)))^2; SE129=SampEn(testdata129,se11,se12); CE129=CondEn(testdata129,ce11,ce12); PE129=PermEn(testdata129,pe1);
RM130=rms(testdata130); S130 = rms(testdata130)/mean(abs(testdata130)); L130=(max(testdata130)-min(testdata130))/mean(sqrt(abs(testdata130)))^2; SE130=SampEn(testdata130,se11,se12); CE130=CondEn(testdata130,ce11,ce12); PE130=PermEn(testdata130,pe1);
RM131=rms(testdata131); S131 = rms(testdata131)/mean(abs(testdata131)); L131=(max(testdata131)-min(testdata131))/mean(sqrt(abs(testdata131)))^2; SE131=SampEn(testdata131,se11,se12); CE131=CondEn(testdata131,ce11,ce12); PE131=PermEn(testdata131,pe1);
RM132=rms(testdata132); S132 = rms(testdata132)/mean(abs(testdata132)); L132=(max(testdata132)-min(testdata132))/mean(sqrt(abs(testdata132)))^2; SE132=SampEn(testdata132,se11,se12); CE132=CondEn(testdata132,ce11,ce12); PE132=PermEn(testdata132,pe1);
RM133=rms(testdata133); S133 = rms(testdata133)/mean(abs(testdata133)); L133=(max(testdata133)-min(testdata133))/mean(sqrt(abs(testdata133)))^2; SE133=SampEn(testdata133,se11,se12); CE133=CondEn(testdata133,ce11,ce12); PE133=PermEn(testdata133,pe1);
RM134=rms(testdata134); S134 = rms(testdata134)/mean(abs(testdata134)); L134=(max(testdata134)-min(testdata134))/mean(sqrt(abs(testdata134)))^2; SE134=SampEn(testdata134,se11,se12); CE134=CondEn(testdata134,ce11,ce12); PE134=PermEn(testdata134,pe1);
RM135=rms(testdata135); S135 = rms(testdata135)/mean(abs(testdata135)); L135=(max(testdata135)-min(testdata135))/mean(sqrt(abs(testdata135)))^2; SE135=SampEn(testdata135,se11,se12); CE135=CondEn(testdata135,ce11,ce12); PE135=PermEn(testdata135,pe1);
RM136=rms(testdata136); S136 = rms(testdata136)/mean(abs(testdata136)); L136=(max(testdata136)-min(testdata136))/mean(sqrt(abs(testdata136)))^2; SE136=SampEn(testdata136,se11,se12); CE136=CondEn(testdata136,ce11,ce12); PE136=PermEn(testdata136,pe1);
RM137=rms(testdata137); S137 = rms(testdata137)/mean(abs(testdata137)); L137=(max(testdata137)-min(testdata137))/mean(sqrt(abs(testdata137)))^2; SE137=SampEn(testdata137,se11,se12); CE137=CondEn(testdata137,ce11,ce12); PE137=PermEn(testdata137,pe1);
RM138=rms(testdata138); S138 = rms(testdata138)/mean(abs(testdata138)); L138=(max(testdata138)-min(testdata138))/mean(sqrt(abs(testdata138)))^2; SE138=SampEn(testdata138,se11,se12); CE138=CondEn(testdata138,ce11,ce12); PE138=PermEn(testdata138,pe1);
RM139=rms(testdata139); S139 = rms(testdata139)/mean(abs(testdata139)); L139=(max(testdata139)-min(testdata139))/mean(sqrt(abs(testdata139)))^2; SE139=SampEn(testdata139,se11,se12); CE139=CondEn(testdata139,ce11,ce12); PE139=PermEn(testdata139,pe1);
RM140=rms(testdata140); S140 = rms(testdata140)/mean(abs(testdata140)); L140=(max(testdata140)-min(testdata140))/mean(sqrt(abs(testdata140)))^2; SE140=SampEn(testdata140,se11,se12); CE140=CondEn(testdata140,ce11,ce12); PE140=PermEn(testdata140,pe1);
RM141=rms(testdata141); S141 = rms(testdata141)/mean(abs(testdata141)); L141=(max(testdata141)-min(testdata141))/mean(sqrt(abs(testdata141)))^2; SE141=SampEn(testdata141,se11,se12); CE141=CondEn(testdata141,ce11,ce12); PE141=PermEn(testdata141,pe1);
RM142=rms(testdata142); S142 = rms(testdata142)/mean(abs(testdata142)); L142=(max(testdata142)-min(testdata142))/mean(sqrt(abs(testdata142)))^2; SE142=SampEn(testdata142,se11,se12); CE142=CondEn(testdata142,ce11,ce12); PE142=PermEn(testdata142,pe1);
RM143=rms(testdata143); S143 = rms(testdata143)/mean(abs(testdata143)); L143=(max(testdata143)-min(testdata143))/mean(sqrt(abs(testdata143)))^2; SE143=SampEn(testdata143,se11,se12); CE143=CondEn(testdata143,ce11,ce12); PE143=PermEn(testdata143,pe1);
RM144=rms(testdata144); S144 = rms(testdata144)/mean(abs(testdata144)); L144=(max(testdata144)-min(testdata144))/mean(sqrt(abs(testdata144)))^2; SE144=SampEn(testdata144,se11,se12); CE144=CondEn(testdata144,ce11,ce12); PE144=PermEn(testdata144,pe1);
RM145=rms(testdata145); S145 = rms(testdata145)/mean(abs(testdata145)); L145=(max(testdata145)-min(testdata145))/mean(sqrt(abs(testdata145)))^2; SE145=SampEn(testdata145,se11,se12); CE145=CondEn(testdata145,ce11,ce12); PE145=PermEn(testdata145,pe1);
RM146=rms(testdata146); S146 = rms(testdata146)/mean(abs(testdata146)); L146=(max(testdata146)-min(testdata146))/mean(sqrt(abs(testdata146)))^2; SE146=SampEn(testdata146,se11,se12); CE146=CondEn(testdata146,ce11,ce12); PE146=PermEn(testdata146,pe1);
RM147=rms(testdata147); S147 = rms(testdata147)/mean(abs(testdata147)); L147=(max(testdata147)-min(testdata147))/mean(sqrt(abs(testdata147)))^2; SE147=SampEn(testdata147,se11,se12); CE147=CondEn(testdata147,ce11,ce12); PE147=PermEn(testdata147,pe1);
RM148=rms(testdata148); S148 = rms(testdata148)/mean(abs(testdata148)); L148=(max(testdata148)-min(testdata148))/mean(sqrt(abs(testdata148)))^2; SE148=SampEn(testdata148,se11,se12); CE148=CondEn(testdata148,ce11,ce12); PE148=PermEn(testdata148,pe1);
RM149=rms(testdata149); S149 = rms(testdata149)/mean(abs(testdata149)); L149=(max(testdata149)-min(testdata149))/mean(sqrt(abs(testdata149)))^2; SE149=SampEn(testdata149,se11,se12); CE149=CondEn(testdata149,ce11,ce12); PE149=PermEn(testdata149,pe1);
RM150=rms(testdata150); S150 = rms(testdata150)/mean(abs(testdata150)); L150=(max(testdata150)-min(testdata150))/mean(sqrt(abs(testdata150)))^2; SE150=SampEn(testdata150,se11,se12); CE150=CondEn(testdata150,ce11,ce12); PE150=PermEn(testdata150,pe1);

tezheng1=[RM101,S101,L101,SE101,CE101,PE101;...
          RM102,S102,L102,SE102,CE102,PE102;...
          RM103,S103,L103,SE103,CE103,PE103;...
          RM104,S104,L104,SE104,CE104,PE104;...
          RM105,S105,L105,SE105,CE105,PE105;...
          RM106,S106,L106,SE106,CE106,PE106;...
          RM107,S107,L107,SE107,CE107,PE107;...
          RM108,S108,L108,SE108,CE108,PE108;...
          RM109,S109,L109,SE109,CE109,PE109;...
          RM110,S110,L110,SE110,CE110,PE110;...
          RM111,S111,L111,SE111,CE111,PE111;...
          RM112,S112,L112,SE112,CE112,PE112;...
          RM113,S113,L113,SE113,CE113,PE113;...
          RM114,S114,L114,SE114,CE114,PE114;...
          RM115,S115,L115,SE115,CE115,PE115;...
          RM116,S116,L116,SE116,CE116,PE116;...
          RM117,S117,L117,SE117,CE117,PE117;...
          RM118,S118,L118,SE118,CE118,PE118;...
          RM119,S119,L119,SE119,CE119,PE119;...
          RM120,S120,L120,SE120,CE120,PE120;...
          RM121,S121,L121,SE121,CE121,PE121;...
          RM122,S122,L122,SE122,CE122,PE122;...
          RM123,S123,L123,SE123,CE123,PE123;...
          RM124,S124,L124,SE124,CE124,PE124;...
          RM125,S125,L125,SE125,CE125,PE125;...
          RM126,S126,L126,SE126,CE126,PE126;...
          RM127,S127,L127,SE127,CE127,PE127;...
          RM128,S128,L128,SE128,CE128,PE128;...
          RM129,S129,L129,SE129,CE129,PE129;...
          RM130,S130,L130,SE130,CE130,PE130;...
          RM131,S131,L131,SE131,CE131,PE131;...
          RM132,S132,L132,SE132,CE132,PE132;...
          RM133,S133,L133,SE133,CE133,PE133;...
          RM134,S134,L134,SE134,CE134,PE134;...
          RM145,S135,L135,SE135,CE135,PE135;...
          RM136,S136,L136,SE136,CE136,PE136;...
          RM137,S137,L137,SE137,CE137,PE137;...
          RM138,S138,L138,SE138,CE138,PE138;...
          RM139,S139,L139,SE139,CE139,PE139;...
          RM140,S140,L140,SE140,CE140,PE140;...
          RM141,S141,L141,SE141,CE141,PE141;...
          RM142,S142,L142,SE142,CE142,PE142;...
          RM143,S143,L143,SE143,CE143,PE143;...
          RM144,S144,L144,SE144,CE144,PE144;...
          RM145,S145,L145,SE145,CE145,PE145;...
          RM146,S146,L146,SE146,CE146,PE146;...
          RM147,S147,L147,SE147,CE147,PE147;...
          RM148,S148,L148,SE148,CE148,PE148;...
          RM149,S149,L149,SE149,CE149,PE149;...
          RM150,S150,L150,SE150,CE150,PE150]
      
%% 内圈故障信号VMD分解，并提取最佳模态的特征组
[u, ~, ~] = VMD(X201, 3000, 0.1, K2, 0, 1, 1e-6);
k201=[];
for i=1:K1
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k201(end+1)=kurt;
end
[~,I]=max(k201);
testdata201=u(I,:);
[u, ~, ~] = VMD(X202, 3000, 0.1, K2, 0, 1, 1e-6);
k202=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k202(end+1)=kurt;
end
[~,I]=max(k202);
testdata202=u(I,:);
[u, ~, ~] = VMD(X203, 3000, 0.1, K2, 0, 1, 1e-6);
k203=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k203(end+1)=kurt;
end
[~,I]=max(k203);
testdata203=u(I,:);
[u, ~, ~] = VMD(X204, 3000, 0.1, K2, 0, 1, 1e-6);
k204=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k204(end+1)=kurt;
end
[~,I]=max(k204);
testdata204=u(I,:);
[u, ~, ~] = VMD(X205, 3000, 0.1, K2, 0, 1, 1e-6);
k205=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k205(end+1)=kurt;
end
[~,I]=max(k205);
testdata205=u(I,:);
[u, ~, ~] = VMD(X206, 3000, 0.1, K2, 0, 1, 1e-6);
k206=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k206(end+1)=kurt;
end
[~,I]=max(k206);
testdata206=u(I,:);
[u, ~, ~] = VMD(X207, 3000, 0.1, K2, 0, 1, 1e-6);
k207=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k207(end+1)=kurt;
end
[~,I]=max(k207);
testdata207=u(I,:);
[u, ~, ~] = VMD(X208, 3000, 0.1, K2, 0, 1, 1e-6);
k208=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k208(end+1)=kurt;
end
[~,I]=max(k208);
testdata208=u(I,:);
[u, ~, ~] = VMD(X209, 3000, 0.1, K2, 0, 1, 1e-6);
k209=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k209(end+1)=kurt;
end
[~,I]=max(k209);
testdata209=u(I,:);
[u, ~, ~] = VMD(X210, 3000, 0.1, K2, 0, 1, 1e-6);
k210=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k210(end+1)=kurt;
end
[~,I]=max(k210);
testdata210=u(I,:);
[u, ~, ~] = VMD(X211, 3000, 0.1, K2, 0, 1, 1e-6);
k211=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k211(end+1)=kurt;
end
[~,I]=max(k211);
testdata211=u(I,:);
[u, ~, ~] = VMD(X212, 3000, 0.1, K2, 0, 1, 1e-6);
k212=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k212(end+1)=kurt;
end
[~,I]=max(k212);
testdata212=u(I,:);
[u, ~, ~] = VMD(X213, 3000, 0.1, K2, 0, 1, 1e-6);
k213=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k213(end+1)=kurt;
end
[~,I]=max(k213);
testdata213=u(I,:);
[u, ~, ~] = VMD(X214, 3000, 0.1, K2, 0, 1, 1e-6);
k214=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k214(end+1)=kurt;
end
[~,I]=max(k214);
testdata214=u(I,:);
[u, ~, ~] = VMD(X215, 3000, 0.1, K2, 0, 1, 1e-6);
k215=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k215(end+1)=kurt;
end
[~,I]=max(k215);
testdata215=u(I,:);
[u, ~, ~] = VMD(X216, 3000, 0.1, K2, 0, 1, 1e-6);
k216=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k216(end+1)=kurt;
end
[~,I]=max(k216);
testdata216=u(I,:);
[u, ~, ~] = VMD(X217, 3000, 0.1, K2, 0, 1, 1e-6);
k217=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k217(end+1)=kurt;
end
[~,I]=max(k217);
testdata217=u(I,:);
[u, ~, ~] = VMD(X218, 3000, 0.1, K2, 0, 1, 1e-6);
k218=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k218(end+1)=kurt;
end
[~,I]=max(k218);
testdata218=u(I,:);
[u, ~, ~] = VMD(X219, 3000, 0.1, K2, 0, 1, 1e-6);
k219=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k219(end+1)=kurt;
end
[~,I]=max(k219);
testdata219=u(I,:);
[u, ~, ~] = VMD(X220, 3000, 0.1, K2, 0, 1, 1e-6);
k220=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k220(end+1)=kurt;
end
[~,I]=max(k220);
testdata220=u(I,:);
[u, ~, ~] = VMD(X221, 3000, 0.1, K2, 0, 1, 1e-6);
k221=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k221(end+1)=kurt;
end
[~,I]=max(k221);
testdata221=u(I,:);
[u, ~, ~] = VMD(X222, 3000, 0.1, K2, 0, 1, 1e-6);
k222=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k222(end+1)=kurt;
end
[~,I]=max(k222);
testdata222=u(I,:);
[u, ~, ~] = VMD(X223, 3000, 0.1, K2, 0, 1, 1e-6);
k223=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k223(end+1)=kurt;
end
[~,I]=max(k223);
testdata223=u(I,:);
[u, ~, ~] = VMD(X224, 3000, 0.1, K2, 0, 1, 1e-6);
k224=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k224(end+1)=kurt;
end
[~,I]=max(k224);
testdata224=u(I,:);
[u, ~, ~] = VMD(X225, 3000, 0.1, K2, 0, 1, 1e-6);
k225=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k225(end+1)=kurt;
end
[~,I]=max(k225);
testdata225=u(I,:);
[u, ~, ~] = VMD(X226, 3000, 0.1, K2, 0, 1, 1e-6);
k226=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k226(end+1)=kurt;
end
[~,I]=max(k226);
testdata226=u(I,:);
[u, ~, ~] = VMD(X227, 3000, 0.1, K2, 0, 1, 1e-6);
k227=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k227(end+1)=kurt;
end
[~,I]=max(k227);
testdata227=u(I,:);
[u, ~, ~] = VMD(X228, 3000, 0.1, K2, 0, 1, 1e-6);
k228=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k228(end+1)=kurt;
end
[~,I]=max(k228);
testdata228=u(I,:);
[u, ~, ~] = VMD(X229, 3000, 0.1, K2, 0, 1, 1e-6);
k229=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k229(end+1)=kurt;
end
[~,I]=max(k229);
testdata229=u(I,:);
[u, ~, ~] = VMD(X230, 3000, 0.1, K2, 0, 1, 1e-6);
k230=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k230(end+1)=kurt;
end
[~,I]=max(k230);
testdata230=u(I,:);
[u, ~, ~] = VMD(X231, 3000, 0.1, K2, 0, 1, 1e-6);
k231=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k231(end+1)=kurt;
end
[~,I]=max(k231);
testdata231=u(I,:);
[u, ~, ~] = VMD(X232, 3000, 0.1, K2, 0, 1, 1e-6);
k232=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k232(end+1)=kurt;
end
[~,I]=max(k232);
testdata232=u(I,:);
[u, ~, ~] = VMD(X233, 3000, 0.1, K2, 0, 1, 1e-6);
k233=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k233(end+1)=kurt;
end
[~,I]=max(k233);
testdata233=u(I,:);
[u, ~, ~] = VMD(X234, 3000, 0.1, K2, 0, 1, 1e-6);
k234=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k234(end+1)=kurt;
end
[~,I]=max(k234);
testdata234=u(I,:);
[u, ~, ~] = VMD(X235, 3000, 0.1, K2, 0, 1, 1e-6);
k235=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k235(end+1)=kurt;
end
[~,I]=max(k235);
testdata235=u(I,:);
[u, ~, ~] = VMD(X236, 3000, 0.1, K2, 0, 1, 1e-6);
k236=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k236(end+1)=kurt;
end
[~,I]=max(k236);
testdata236=u(I,:);
[u, ~, ~] = VMD(X237, 3000, 0.1, K2, 0, 1, 1e-6);
k237=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k237(end+1)=kurt;
end
[~,I]=max(k237);
testdata237=u(I,:);
[u, ~, ~] = VMD(X238, 3000, 0.1, K2, 0, 1, 1e-6);
k238=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k238(end+1)=kurt;
end
[~,I]=max(k238);
testdata238=u(I,:);
[u, ~, ~] = VMD(X239, 3000, 0.1, K2, 0, 1, 1e-6);
k239=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k239(end+1)=kurt;
end
[~,I]=max(k239);
testdata239=u(I,:);
[u, ~, ~] = VMD(X240, 3000, 0.1, K2, 0, 1, 1e-6);
k240=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k240(end+1)=kurt;
end
[~,I]=max(k240);
testdata240=u(I,:);
[u, ~, ~] = VMD(X241, 3000, 0.1, K2, 0, 1, 1e-6);
k241=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k241(end+1)=kurt;
end
[~,I]=max(k241);
testdata241=u(I,:);
[u, ~, ~] = VMD(X242, 3000, 0.1, K2, 0, 1, 1e-6);
k242=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k242(end+1)=kurt;
end
[~,I]=max(k242);
testdata242=u(I,:);
[u, ~, ~] = VMD(X243, 3000, 0.1, K2, 0, 1, 1e-6);
k243=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k243(end+1)=kurt;
end
[~,I]=max(k243);
testdata243=u(I,:);
[u, ~, ~] = VMD(X244, 3000, 0.1, K2, 0, 1, 1e-6);
k244=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k244(end+1)=kurt;
end
[~,I]=max(k244);
testdata244=u(I,:);
[u, ~, ~] = VMD(X245, 3000, 0.1, K2, 0, 1, 1e-6);
k245=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k245(end+1)=kurt;
end
[~,I]=max(k245);
testdata245=u(I,:);
[u, ~, ~] = VMD(X246, 3000, 0.1, K2, 0, 1, 1e-6);
k246=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k246(end+1)=kurt;
end
[~,I]=max(k246);
testdata246=u(I,:);
[u, ~, ~] = VMD(X247, 3000, 0.1, K2, 0, 1, 1e-6);
k247=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k247(end+1)=kurt;
end
[~,I]=max(k247);
testdata247=u(I,:);
[u, ~, ~] = VMD(X248, 3000, 0.1, K2, 0, 1, 1e-6);
k248=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k248(end+1)=kurt;
end
[~,I]=max(k248);
testdata248=u(I,:);
[u, ~, ~] = VMD(X249, 3000, 0.1, K2, 0, 1, 1e-6);
k249=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k249(end+1)=kurt;
end
[~,I]=max(k249);
testdata249=u(I,:);
[u, ~, ~] = VMD(X250, 3000, 0.1, K2, 0, 1, 1e-6);
k250=[];
for i=1:K2
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k250(end+1)=kurt;
end
[~,I]=max(k250);
testdata250=u(I,:);

RM201=rms(testdata201); S201 = rms(testdata201)/mean(abs(testdata201)); L201=(max(testdata201)-min(testdata201))/mean(sqrt(abs(testdata201)))^2; SE201=SampEn(testdata201,se21,se22); CE201=CondEn(testdata201,ce21,ce22); PE201=PermEn(testdata201,pe2);
RM202=rms(testdata202); S202 = rms(testdata202)/mean(abs(testdata202)); L202=(max(testdata202)-min(testdata202))/mean(sqrt(abs(testdata202)))^2; SE202=SampEn(testdata202,se21,se22); CE202=CondEn(testdata202,ce21,ce22); PE202=PermEn(testdata202,pe2);
RM203=rms(testdata203); S203 = rms(testdata203)/mean(abs(testdata203)); L203=(max(testdata203)-min(testdata203))/mean(sqrt(abs(testdata203)))^2; SE203=SampEn(testdata203,se21,se22); CE203=CondEn(testdata203,ce21,ce22); PE203=PermEn(testdata203,pe2);
RM204=rms(testdata204); S204 = rms(testdata204)/mean(abs(testdata204)); L204=(max(testdata204)-min(testdata204))/mean(sqrt(abs(testdata204)))^2; SE204=SampEn(testdata204,se21,se22); CE204=CondEn(testdata204,ce21,ce22); PE204=PermEn(testdata204,pe2);
RM205=rms(testdata205); S205 = rms(testdata205)/mean(abs(testdata205)); L205=(max(testdata205)-min(testdata205))/mean(sqrt(abs(testdata205)))^2; SE205=SampEn(testdata205,se21,se22); CE205=CondEn(testdata205,ce21,ce22); PE205=PermEn(testdata205,pe2);
RM206=rms(testdata206); S206 = rms(testdata206)/mean(abs(testdata206)); L206=(max(testdata206)-min(testdata206))/mean(sqrt(abs(testdata206)))^2; SE206=SampEn(testdata206,se21,se22); CE206=CondEn(testdata206,ce21,ce22); PE206=PermEn(testdata206,pe2);
RM207=rms(testdata207); S207 = rms(testdata207)/mean(abs(testdata207)); L207=(max(testdata207)-min(testdata207))/mean(sqrt(abs(testdata207)))^2; SE207=SampEn(testdata207,se21,se22); CE207=CondEn(testdata207,ce21,ce22); PE207=PermEn(testdata207,pe2);
RM208=rms(testdata208); S208 = rms(testdata208)/mean(abs(testdata208)); L208=(max(testdata208)-min(testdata208))/mean(sqrt(abs(testdata208)))^2; SE208=SampEn(testdata208,se21,se22); CE208=CondEn(testdata208,ce21,ce22); PE208=PermEn(testdata208,pe2);
RM209=rms(testdata209); S209 = rms(testdata209)/mean(abs(testdata209)); L209=(max(testdata209)-min(testdata209))/mean(sqrt(abs(testdata209)))^2; SE209=SampEn(testdata209,se21,se22); CE209=CondEn(testdata209,ce21,ce22); PE209=PermEn(testdata209,pe2);
RM210=rms(testdata210); S210 = rms(testdata210)/mean(abs(testdata210)); L210=(max(testdata210)-min(testdata210))/mean(sqrt(abs(testdata210)))^2; SE210=SampEn(testdata210,se21,se22); CE210=CondEn(testdata210,ce21,ce22); PE210=PermEn(testdata210,pe2);
RM211=rms(testdata211); S211 = rms(testdata211)/mean(abs(testdata211)); L211=(max(testdata211)-min(testdata211))/mean(sqrt(abs(testdata211)))^2; SE211=SampEn(testdata211,se21,se22); CE211=CondEn(testdata211,ce21,ce22); PE211=PermEn(testdata211,pe2);
RM212=rms(testdata212); S212 = rms(testdata212)/mean(abs(testdata212)); L212=(max(testdata212)-min(testdata212))/mean(sqrt(abs(testdata212)))^2; SE212=SampEn(testdata212,se21,se22); CE212=CondEn(testdata212,ce21,ce22); PE212=PermEn(testdata212,pe2);
RM213=rms(testdata213); S213 = rms(testdata213)/mean(abs(testdata213)); L213=(max(testdata213)-min(testdata213))/mean(sqrt(abs(testdata213)))^2; SE213=SampEn(testdata213,se21,se22); CE213=CondEn(testdata213,ce21,ce22); PE213=PermEn(testdata213,pe2);
RM214=rms(testdata214); S214 = rms(testdata214)/mean(abs(testdata214)); L214=(max(testdata214)-min(testdata214))/mean(sqrt(abs(testdata214)))^2; SE214=SampEn(testdata214,se21,se22); CE214=CondEn(testdata214,ce21,ce22); PE214=PermEn(testdata214,pe2);
RM215=rms(testdata215); S215 = rms(testdata215)/mean(abs(testdata215)); L215=(max(testdata215)-min(testdata215))/mean(sqrt(abs(testdata215)))^2; SE215=SampEn(testdata215,se21,se22); CE215=CondEn(testdata215,ce21,ce22); PE215=PermEn(testdata215,pe2);
RM216=rms(testdata216); S216 = rms(testdata216)/mean(abs(testdata216)); L216=(max(testdata216)-min(testdata216))/mean(sqrt(abs(testdata216)))^2; SE216=SampEn(testdata216,se21,se22); CE216=CondEn(testdata216,ce21,ce22); PE216=PermEn(testdata216,pe2);
RM217=rms(testdata217); S217 = rms(testdata217)/mean(abs(testdata217)); L217=(max(testdata217)-min(testdata217))/mean(sqrt(abs(testdata217)))^2; SE217=SampEn(testdata217,se21,se22); CE217=CondEn(testdata217,ce21,ce22); PE217=PermEn(testdata217,pe2);
RM218=rms(testdata218); S218 = rms(testdata218)/mean(abs(testdata218)); L218=(max(testdata218)-min(testdata218))/mean(sqrt(abs(testdata218)))^2; SE218=SampEn(testdata218,se21,se22); CE218=CondEn(testdata218,ce21,ce22); PE218=PermEn(testdata218,pe2);
RM219=rms(testdata219); S219 = rms(testdata219)/mean(abs(testdata219)); L219=(max(testdata219)-min(testdata219))/mean(sqrt(abs(testdata219)))^2; SE219=SampEn(testdata219,se21,se22); CE219=CondEn(testdata219,ce21,ce22); PE219=PermEn(testdata219,pe2);
RM220=rms(testdata220); S220 = rms(testdata220)/mean(abs(testdata220)); L220=(max(testdata220)-min(testdata220))/mean(sqrt(abs(testdata220)))^2; SE220=SampEn(testdata220,se21,se22); CE220=CondEn(testdata220,ce21,ce22); PE220=PermEn(testdata220,pe2);
RM221=rms(testdata221); S221 = rms(testdata221)/mean(abs(testdata221)); L221=(max(testdata221)-min(testdata221))/mean(sqrt(abs(testdata221)))^2; SE221=SampEn(testdata221,se21,se22); CE221=CondEn(testdata221,ce21,ce22); PE221=PermEn(testdata221,pe2);
RM222=rms(testdata222); S222 = rms(testdata222)/mean(abs(testdata222)); L222=(max(testdata222)-min(testdata222))/mean(sqrt(abs(testdata222)))^2; SE222=SampEn(testdata222,se21,se22); CE222=CondEn(testdata222,ce21,ce22); PE222=PermEn(testdata222,pe2);
RM223=rms(testdata223); S223 = rms(testdata223)/mean(abs(testdata223)); L223=(max(testdata223)-min(testdata223))/mean(sqrt(abs(testdata223)))^2; SE223=SampEn(testdata223,se21,se22); CE223=CondEn(testdata223,ce21,ce22); PE223=PermEn(testdata223,pe2);
RM224=rms(testdata224); S224 = rms(testdata224)/mean(abs(testdata224)); L224=(max(testdata224)-min(testdata224))/mean(sqrt(abs(testdata224)))^2; SE224=SampEn(testdata224,se21,se22); CE224=CondEn(testdata224,ce21,ce22); PE224=PermEn(testdata224,pe2);
RM225=rms(testdata225); S225 = rms(testdata225)/mean(abs(testdata225)); L225=(max(testdata225)-min(testdata225))/mean(sqrt(abs(testdata225)))^2; SE225=SampEn(testdata225,se21,se22); CE225=CondEn(testdata225,ce21,ce22); PE225=PermEn(testdata225,pe2);
RM226=rms(testdata226); S226 = rms(testdata226)/mean(abs(testdata226)); L226=(max(testdata226)-min(testdata226))/mean(sqrt(abs(testdata226)))^2; SE226=SampEn(testdata226,se21,se22); CE226=CondEn(testdata226,ce21,ce22); PE226=PermEn(testdata226,pe2);
RM227=rms(testdata227); S227 = rms(testdata227)/mean(abs(testdata227)); L227=(max(testdata227)-min(testdata227))/mean(sqrt(abs(testdata227)))^2; SE227=SampEn(testdata227,se21,se22); CE227=CondEn(testdata227,ce21,ce22); PE227=PermEn(testdata227,pe2);
RM228=rms(testdata228); S228 = rms(testdata228)/mean(abs(testdata228)); L228=(max(testdata228)-min(testdata228))/mean(sqrt(abs(testdata228)))^2; SE228=SampEn(testdata228,se21,se22); CE228=CondEn(testdata228,ce21,ce22); PE228=PermEn(testdata228,pe2);
RM229=rms(testdata229); S229 = rms(testdata229)/mean(abs(testdata229)); L229=(max(testdata229)-min(testdata229))/mean(sqrt(abs(testdata229)))^2; SE229=SampEn(testdata229,se21,se22); CE229=CondEn(testdata229,ce21,ce22); PE229=PermEn(testdata229,pe2);
RM230=rms(testdata230); S230 = rms(testdata230)/mean(abs(testdata230)); L230=(max(testdata230)-min(testdata230))/mean(sqrt(abs(testdata230)))^2; SE230=SampEn(testdata230,se21,se22); CE230=CondEn(testdata230,ce21,ce22); PE230=PermEn(testdata230,pe2);
RM231=rms(testdata231); S231 = rms(testdata231)/mean(abs(testdata231)); L231=(max(testdata231)-min(testdata231))/mean(sqrt(abs(testdata231)))^2; SE231=SampEn(testdata231,se21,se22); CE231=CondEn(testdata231,ce21,ce22); PE231=PermEn(testdata231,pe2);
RM232=rms(testdata232); S232 = rms(testdata232)/mean(abs(testdata232)); L232=(max(testdata232)-min(testdata232))/mean(sqrt(abs(testdata232)))^2; SE232=SampEn(testdata232,se21,se22); CE232=CondEn(testdata232,ce21,ce22); PE232=PermEn(testdata232,pe2);
RM233=rms(testdata233); S233 = rms(testdata233)/mean(abs(testdata233)); L233=(max(testdata233)-min(testdata233))/mean(sqrt(abs(testdata233)))^2; SE233=SampEn(testdata233,se21,se22); CE233=CondEn(testdata233,ce21,ce22); PE233=PermEn(testdata233,pe2);
RM234=rms(testdata234); S234 = rms(testdata234)/mean(abs(testdata234)); L234=(max(testdata234)-min(testdata234))/mean(sqrt(abs(testdata234)))^2; SE234=SampEn(testdata234,se21,se22); CE234=CondEn(testdata234,ce21,ce22); PE234=PermEn(testdata234,pe2);
RM235=rms(testdata235); S235 = rms(testdata235)/mean(abs(testdata235)); L235=(max(testdata235)-min(testdata235))/mean(sqrt(abs(testdata235)))^2; SE235=SampEn(testdata235,se21,se22); CE235=CondEn(testdata235,ce21,ce22); PE235=PermEn(testdata235,pe2);
RM236=rms(testdata236); S236 = rms(testdata236)/mean(abs(testdata236)); L236=(max(testdata236)-min(testdata236))/mean(sqrt(abs(testdata236)))^2; SE236=SampEn(testdata236,se21,se22); CE236=CondEn(testdata236,ce21,ce22); PE236=PermEn(testdata236,pe2);
RM237=rms(testdata237); S237 = rms(testdata237)/mean(abs(testdata237)); L237=(max(testdata237)-min(testdata237))/mean(sqrt(abs(testdata237)))^2; SE237=SampEn(testdata237,se21,se22); CE237=CondEn(testdata237,ce21,ce22); PE237=PermEn(testdata237,pe2);
RM238=rms(testdata238); S238 = rms(testdata238)/mean(abs(testdata238)); L238=(max(testdata238)-min(testdata238))/mean(sqrt(abs(testdata238)))^2; SE238=SampEn(testdata238,se21,se22); CE238=CondEn(testdata238,ce21,ce22); PE238=PermEn(testdata238,pe2);
RM239=rms(testdata239); S239 = rms(testdata239)/mean(abs(testdata239)); L239=(max(testdata239)-min(testdata239))/mean(sqrt(abs(testdata239)))^2; SE239=SampEn(testdata239,se21,se22); CE239=CondEn(testdata239,ce21,ce22); PE239=PermEn(testdata239,pe2);
RM240=rms(testdata240); S240 = rms(testdata240)/mean(abs(testdata240)); L240=(max(testdata240)-min(testdata240))/mean(sqrt(abs(testdata240)))^2; SE240=SampEn(testdata240,se21,se22); CE240=CondEn(testdata240,ce21,ce22); PE240=PermEn(testdata240,pe2);
RM241=rms(testdata241); S241 = rms(testdata241)/mean(abs(testdata241)); L241=(max(testdata241)-min(testdata241))/mean(sqrt(abs(testdata241)))^2; SE241=SampEn(testdata241,se21,se22); CE241=CondEn(testdata241,ce21,ce22); PE241=PermEn(testdata241,pe2);
RM242=rms(testdata242); S242 = rms(testdata242)/mean(abs(testdata242)); L242=(max(testdata242)-min(testdata242))/mean(sqrt(abs(testdata242)))^2; SE242=SampEn(testdata242,se21,se22); CE242=CondEn(testdata242,ce21,ce22); PE242=PermEn(testdata242,pe2);
RM243=rms(testdata243); S243 = rms(testdata243)/mean(abs(testdata243)); L243=(max(testdata243)-min(testdata243))/mean(sqrt(abs(testdata243)))^2; SE243=SampEn(testdata243,se21,se22); CE243=CondEn(testdata243,ce21,ce22); PE243=PermEn(testdata243,pe2);
RM244=rms(testdata244); S244 = rms(testdata244)/mean(abs(testdata244)); L244=(max(testdata244)-min(testdata244))/mean(sqrt(abs(testdata244)))^2; SE244=SampEn(testdata244,se21,se22); CE244=CondEn(testdata244,ce21,ce22); PE244=PermEn(testdata244,pe2);
RM245=rms(testdata245); S245 = rms(testdata245)/mean(abs(testdata245)); L245=(max(testdata245)-min(testdata245))/mean(sqrt(abs(testdata245)))^2; SE245=SampEn(testdata245,se21,se22); CE245=CondEn(testdata245,ce21,ce22); PE245=PermEn(testdata245,pe2);
RM246=rms(testdata246); S246 = rms(testdata246)/mean(abs(testdata246)); L246=(max(testdata246)-min(testdata246))/mean(sqrt(abs(testdata246)))^2; SE246=SampEn(testdata246,se21,se22); CE246=CondEn(testdata246,ce21,ce22); PE246=PermEn(testdata246,pe2);
RM247=rms(testdata247); S247 = rms(testdata247)/mean(abs(testdata247)); L247=(max(testdata247)-min(testdata247))/mean(sqrt(abs(testdata247)))^2; SE247=SampEn(testdata247,se21,se22); CE247=CondEn(testdata247,ce21,ce22); PE247=PermEn(testdata247,pe2);
RM248=rms(testdata248); S248 = rms(testdata248)/mean(abs(testdata248)); L248=(max(testdata248)-min(testdata248))/mean(sqrt(abs(testdata248)))^2; SE248=SampEn(testdata248,se21,se22); CE248=CondEn(testdata248,ce21,ce22); PE248=PermEn(testdata248,pe2);
RM249=rms(testdata249); S249 = rms(testdata249)/mean(abs(testdata249)); L249=(max(testdata249)-min(testdata249))/mean(sqrt(abs(testdata249)))^2; SE249=SampEn(testdata249,se21,se22); CE249=CondEn(testdata249,ce21,ce22); PE249=PermEn(testdata249,pe2);
RM250=rms(testdata250); S250 = rms(testdata250)/mean(abs(testdata250)); L250=(max(testdata250)-min(testdata250))/mean(sqrt(abs(testdata250)))^2; SE250=SampEn(testdata250,se21,se22); CE250=CondEn(testdata250,ce21,ce22); PE250=PermEn(testdata250,pe2);

tezheng2=[RM201,S201,L201,SE201,CE201,PE201;...
          RM202,S202,L202,SE202,CE202,PE202;...
          RM203,S203,L203,SE203,CE203,PE203;...
          RM204,S204,L204,SE204,CE204,PE204;...
          RM205,S205,L205,SE205,CE205,PE205;...
          RM206,S206,L206,SE206,CE206,PE206;...
          RM207,S207,L207,SE207,CE207,PE207;...
          RM208,S208,L208,SE208,CE208,PE208;...
          RM209,S209,L209,SE209,CE209,PE209;...
          RM210,S210,L210,SE210,CE210,PE210;...
          RM211,S211,L211,SE211,CE211,PE211;...
          RM212,S212,L212,SE212,CE212,PE212;...
          RM213,S213,L213,SE213,CE213,PE213;...
          RM214,S214,L214,SE214,CE214,PE214;...
          RM215,S215,L215,SE215,CE215,PE215;...
          RM216,S216,L216,SE216,CE216,PE216;...
          RM217,S217,L217,SE217,CE217,PE217;...
          RM218,S218,L218,SE218,CE218,PE218;...
          RM219,S219,L219,SE219,CE219,PE219;...
          RM220,S220,L220,SE220,CE220,PE220;...
          RM221,S221,L221,SE221,CE221,PE221;...
          RM222,S222,L222,SE222,CE222,PE222;...
          RM223,S223,L223,SE223,CE223,PE223;...
          RM224,S224,L224,SE224,CE224,PE224;...
          RM225,S225,L225,SE225,CE225,PE225;...
          RM226,S226,L226,SE226,CE226,PE226;...
          RM227,S227,L227,SE227,CE227,PE227;...
          RM228,S228,L228,SE228,CE228,PE228;...
          RM229,S229,L229,SE229,CE229,PE229;...
          RM230,S230,L230,SE230,CE230,PE230;...
          RM231,S231,L231,SE231,CE231,PE231;...
          RM232,S232,L232,SE232,CE232,PE232;...
          RM233,S233,L233,SE233,CE233,PE233;...
          RM234,S234,L234,SE234,CE234,PE234;...
          RM245,S235,L235,SE235,CE235,PE235;...
          RM236,S236,L236,SE236,CE236,PE236;...
          RM237,S237,L237,SE237,CE237,PE237;...
          RM238,S238,L238,SE238,CE238,PE238;...
          RM239,S239,L239,SE239,CE239,PE239;...
          RM240,S240,L240,SE240,CE240,PE240;...
          RM241,S241,L241,SE241,CE241,PE241;...
          RM242,S242,L242,SE242,CE242,PE242;...
          RM243,S243,L243,SE243,CE243,PE243;...
          RM244,S244,L244,SE244,CE244,PE244;...
          RM245,S245,L245,SE245,CE245,PE245;...
          RM246,S246,L246,SE246,CE246,PE246;...
          RM247,S247,L247,SE247,CE247,PE247;...
          RM248,S248,L248,SE248,CE248,PE248;...
          RM249,S249,L249,SE249,CE249,PE249;...
          RM250,S250,L250,SE250,CE250,PE250]
    
%% 滚动体故障信号VMD分解，并提取最佳模态的特征组
[u, ~, ~] = VMD(X301, 3000, 0.1, K3, 0, 1, 1e-6);
k301=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k301(end+1)=kurt;
end
[~,I]=max(k301);
testdata301=u(I,:);
[u, ~, ~] = VMD(X302, 3000, 0.1, K3, 0, 1, 1e-6);
k302=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k302(end+1)=kurt;
end
[~,I]=max(k302);
testdata302=u(I,:);
[u, ~, ~] = VMD(X303, 3000, 0.1, K3, 0, 1, 1e-6);
k303=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k303(end+1)=kurt;
end
[~,I]=max(k303);
testdata303=u(I,:);
[u, ~, ~] = VMD(X304, 3000, 0.1, K3, 0, 1, 1e-6);
k304=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k304(end+1)=kurt;
end
[~,I]=max(k304);
testdata304=u(I,:);
[u, ~, ~] = VMD(X305, 3000, 0.1, K3, 0, 1, 1e-6);
k305=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k305(end+1)=kurt;
end
[~,I]=max(k305);
testdata305=u(I,:);
[u, ~, ~] = VMD(X306, 3000, 0.1, K3, 0, 1, 1e-6);
k306=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k306(end+1)=kurt;
end
[~,I]=max(k306);
testdata306=u(I,:);
[u, ~, ~] = VMD(X307, 3000, 0.1, K3, 0, 1, 1e-6);
k307=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k307(end+1)=kurt;
end
[~,I]=max(k307);
testdata307=u(I,:);
[u, ~, ~] = VMD(X308, 3000, 0.1, K3, 0, 1, 1e-6);
k308=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k308(end+1)=kurt;
end
[~,I]=max(k308);
testdata308=u(I,:);
[u, ~, ~] = VMD(X309, 3000, 0.1, K3, 0, 1, 1e-6);
k309=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k309(end+1)=kurt;
end
[~,I]=max(k309);
testdata309=u(I,:);
[u, ~, ~] = VMD(X310, 3000, 0.1, K3, 0, 1, 1e-6);
k310=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k310(end+1)=kurt;
end
[~,I]=max(k310);
testdata310=u(I,:);
[u, ~, ~] = VMD(X311, 3000, 0.1, K3, 0, 1, 1e-6);
k311=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k311(end+1)=kurt;
end
[~,I]=max(k311);
testdata311=u(I,:);
[u, ~, ~] = VMD(X312, 3000, 0.1, K3, 0, 1, 1e-6);
k312=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k312(end+1)=kurt;
end
[~,I]=max(k312);
testdata312=u(I,:);
[u, ~, ~] = VMD(X313, 3000, 0.1, K3, 0, 1, 1e-6);
k313=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k313(end+1)=kurt;
end
[~,I]=max(k313);
testdata313=u(I,:);
[u, ~, ~] = VMD(X314, 3000, 0.1, K3, 0, 1, 1e-6);
k314=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k314(end+1)=kurt;
end
[~,I]=max(k314);
testdata314=u(I,:);
[u, ~, ~] = VMD(X315, 3000, 0.1, K3, 0, 1, 1e-6);
k315=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k315(end+1)=kurt;
end
[~,I]=max(k315);
testdata315=u(I,:);
[u, ~, ~] = VMD(X316, 3000, 0.1, K3, 0, 1, 1e-6);
k316=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k316(end+1)=kurt;
end
[~,I]=max(k316);
testdata316=u(I,:);
[u, ~, ~] = VMD(X317, 3000, 0.1, K3, 0, 1, 1e-6);
k317=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k317(end+1)=kurt;
end
[~,I]=max(k317);
testdata317=u(I,:);
[u, ~, ~] = VMD(X318, 3000, 0.1, K3, 0, 1, 1e-6);
k318=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k318(end+1)=kurt;
end
[~,I]=max(k318);
testdata318=u(I,:);
[u, ~, ~] = VMD(X319, 3000, 0.1, K3, 0, 1, 1e-6);
k319=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k319(end+1)=kurt;
end
[~,I]=max(k319);
testdata319=u(I,:);
[u, ~, ~] = VMD(X320, 3000, 0.1, K3, 0, 1, 1e-6);
k320=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k320(end+1)=kurt;
end
[~,I]=max(k320);
testdata320=u(I,:);
[u, ~, ~] = VMD(X321, 3000, 0.1, K3, 0, 1, 1e-6);
k321=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k321(end+1)=kurt;
end
[~,I]=max(k321);
testdata321=u(I,:);
[u, ~, ~] = VMD(X322, 3000, 0.1, K3, 0, 1, 1e-6);
k322=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k322(end+1)=kurt;
end
[~,I]=max(k322);
testdata322=u(I,:);
[u, ~, ~] = VMD(X323, 3000, 0.1, K3, 0, 1, 1e-6);
k323=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k323(end+1)=kurt;
end
[~,I]=max(k323);
testdata323=u(I,:);
[u, ~, ~] = VMD(X324, 3000, 0.1, K3, 0, 1, 1e-6);
k324=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k324(end+1)=kurt;
end
[~,I]=max(k324);
testdata324=u(I,:);
[u, ~, ~] = VMD(X325, 3000, 0.1, K3, 0, 1, 1e-6);
k325=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k325(end+1)=kurt;
end
[~,I]=max(k325);
testdata325=u(I,:);
[u, ~, ~] = VMD(X326, 3000, 0.1, K3, 0, 1, 1e-6);
k326=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k326(end+1)=kurt;
end
[~,I]=max(k326);
testdata326=u(I,:);
[u, ~, ~] = VMD(X327, 3000, 0.1, K3, 0, 1, 1e-6);
k327=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k327(end+1)=kurt;
end
[~,I]=max(k327);
testdata327=u(I,:);
[u, ~, ~] = VMD(X328, 3000, 0.1, K3, 0, 1, 1e-6);
k328=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k328(end+1)=kurt;
end
[~,I]=max(k328);
testdata328=u(I,:);
[u, ~, ~] = VMD(X329, 3000, 0.1, K3, 0, 1, 1e-6);
k329=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k329(end+1)=kurt;
end
[~,I]=max(k329);
testdata329=u(I,:);
[u, ~, ~] = VMD(X330, 3000, 0.1, K3, 0, 1, 1e-6);
k330=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k330(end+1)=kurt;
end
[~,I]=max(k330);
testdata330=u(I,:);
[u, ~, ~] = VMD(X331, 3000, 0.1, K3, 0, 1, 1e-6);
k331=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k331(end+1)=kurt;
end
[~,I]=max(k331);
testdata331=u(I,:);
[u, ~, ~] = VMD(X332, 3000, 0.1, K3, 0, 1, 1e-6);
k332=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k332(end+1)=kurt;
end
[~,I]=max(k332);
testdata332=u(I,:);
[u, ~, ~] = VMD(X333, 3000, 0.1, K3, 0, 1, 1e-6);
k333=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k333(end+1)=kurt;
end
[~,I]=max(k333);
testdata333=u(I,:);
[u, ~, ~] = VMD(X334, 3000, 0.1, K3, 0, 1, 1e-6);
k334=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k334(end+1)=kurt;
end
[~,I]=max(k334);
testdata334=u(I,:);
[u, ~, ~] = VMD(X335, 3000, 0.1, K3, 0, 1, 1e-6);
k335=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k335(end+1)=kurt;
end
[~,I]=max(k335);
testdata335=u(I,:);
[u, ~, ~] = VMD(X336, 3000, 0.1, K3, 0, 1, 1e-6);
k336=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k336(end+1)=kurt;
end
[~,I]=max(k336);
testdata336=u(I,:);
[u, ~, ~] = VMD(X337, 3000, 0.1, K3, 0, 1, 1e-6);
k337=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k337(end+1)=kurt;
end
[~,I]=max(k337);
testdata337=u(I,:);
[u, ~, ~] = VMD(X338, 3000, 0.1, K3, 0, 1, 1e-6);
k338=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k338(end+1)=kurt;
end
[~,I]=max(k338);
testdata338=u(I,:);
[u, ~, ~] = VMD(X339, 3000, 0.1, K3, 0, 1, 1e-6);
k339=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k339(end+1)=kurt;
end
[~,I]=max(k339);
testdata339=u(I,:);
[u, ~, ~] = VMD(X340, 3000, 0.1, K3, 0, 1, 1e-6);
k340=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k340(end+1)=kurt;
end
[~,I]=max(k340);
testdata340=u(I,:);
[u, ~, ~] = VMD(X341, 3000, 0.1, K3, 0, 1, 1e-6);
k341=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k341(end+1)=kurt;
end
[~,I]=max(k341);
testdata341=u(I,:);
[u, ~, ~] = VMD(X342, 3000, 0.1, K3, 0, 1, 1e-6);
k342=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k342(end+1)=kurt;
end
[~,I]=max(k342);
testdata342=u(I,:);
[u, ~, ~] = VMD(X343, 3000, 0.1, K3, 0, 1, 1e-6);
k343=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k343(end+1)=kurt;
end
[~,I]=max(k343);
testdata343=u(I,:);
[u, ~, ~] = VMD(X344, 3000, 0.1, K3, 0, 1, 1e-6);
k344=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k344(end+1)=kurt;
end
[~,I]=max(k344);
testdata344=u(I,:);
[u, ~, ~] = VMD(X345, 3000, 0.1, K3, 0, 1, 1e-6);
k345=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k345(end+1)=kurt;
end
[~,I]=max(k345);
testdata345=u(I,:);
[u, ~, ~] = VMD(X346, 3000, 0.1, K3, 0, 1, 1e-6);
k346=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k346(end+1)=kurt;
end
[~,I]=max(k346);
testdata346=u(I,:);
[u, ~, ~] = VMD(X347, 3000, 0.1, K3, 0, 1, 1e-6);
k347=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k347(end+1)=kurt;
end
[~,I]=max(k347);
testdata347=u(I,:);
[u, ~, ~] = VMD(X348, 3000, 0.1, K3, 0, 1, 1e-6);
k348=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k348(end+1)=kurt;
end
[~,I]=max(k348);
testdata348=u(I,:);
[u, ~, ~] = VMD(X349, 3000, 0.1, K3, 0, 1, 1e-6);
k349=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k349(end+1)=kurt;
end
[~,I]=max(k349);
testdata349=u(I,:);
[u, ~, ~] = VMD(X350, 3000, 0.1, K3, 0, 1, 1e-6);
k350=[];
for i=1:K3
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k350(end+1)=kurt;
end
[~,I]=max(k350);
testdata350=u(I,:);
RM301=rms(testdata301); S301 = rms(testdata301)/mean(abs(testdata301)); L301=(max(testdata301)-min(testdata301))/mean(sqrt(abs(testdata301)))^2; SE301=SampEn(testdata301,se31,se32); CE301=CondEn(testdata301,ce31,ce32); PE301=PermEn(testdata301,pe3);
RM302=rms(testdata302); S302 = rms(testdata302)/mean(abs(testdata302)); L302=(max(testdata302)-min(testdata302))/mean(sqrt(abs(testdata302)))^2; SE302=SampEn(testdata302,se31,se32); CE302=CondEn(testdata302,ce31,ce32); PE302=PermEn(testdata302,pe3);
RM303=rms(testdata303); S303 = rms(testdata303)/mean(abs(testdata303)); L303=(max(testdata303)-min(testdata303))/mean(sqrt(abs(testdata303)))^2; SE303=SampEn(testdata303,se31,se32); CE303=CondEn(testdata303,ce31,ce32); PE303=PermEn(testdata303,pe3);
RM304=rms(testdata304); S304 = rms(testdata304)/mean(abs(testdata304)); L304=(max(testdata304)-min(testdata304))/mean(sqrt(abs(testdata304)))^2; SE304=SampEn(testdata304,se31,se32); CE304=CondEn(testdata304,ce31,ce32); PE304=PermEn(testdata304,pe3);
RM305=rms(testdata305); S305 = rms(testdata305)/mean(abs(testdata305)); L305=(max(testdata305)-min(testdata305))/mean(sqrt(abs(testdata305)))^2; SE305=SampEn(testdata305,se31,se32); CE305=CondEn(testdata305,ce31,ce32); PE305=PermEn(testdata305,pe3);
RM306=rms(testdata306); S306 = rms(testdata306)/mean(abs(testdata306)); L306=(max(testdata306)-min(testdata306))/mean(sqrt(abs(testdata306)))^2; SE306=SampEn(testdata306,se31,se32); CE306=CondEn(testdata306,ce31,ce32); PE306=PermEn(testdata306,pe3);
RM307=rms(testdata307); S307 = rms(testdata307)/mean(abs(testdata307)); L307=(max(testdata307)-min(testdata307))/mean(sqrt(abs(testdata307)))^2; SE307=SampEn(testdata307,se31,se32); CE307=CondEn(testdata307,ce31,ce32); PE307=PermEn(testdata307,pe3);
RM308=rms(testdata308); S308 = rms(testdata308)/mean(abs(testdata308)); L308=(max(testdata308)-min(testdata308))/mean(sqrt(abs(testdata308)))^2; SE308=SampEn(testdata308,se31,se32); CE308=CondEn(testdata308,ce31,ce32); PE308=PermEn(testdata308,pe3);
RM309=rms(testdata309); S309 = rms(testdata309)/mean(abs(testdata309)); L309=(max(testdata309)-min(testdata309))/mean(sqrt(abs(testdata309)))^2; SE309=SampEn(testdata309,se31,se32); CE309=CondEn(testdata309,ce31,ce32); PE309=PermEn(testdata309,pe3);
RM310=rms(testdata310); S310 = rms(testdata310)/mean(abs(testdata310)); L310=(max(testdata310)-min(testdata310))/mean(sqrt(abs(testdata310)))^2; SE310=SampEn(testdata310,se31,se32); CE310=CondEn(testdata310,ce31,ce32); PE310=PermEn(testdata310,pe3);
RM311=rms(testdata311); S311 = rms(testdata311)/mean(abs(testdata311)); L311=(max(testdata311)-min(testdata311))/mean(sqrt(abs(testdata311)))^2; SE311=SampEn(testdata311,se31,se32); CE311=CondEn(testdata311,ce31,ce32); PE311=PermEn(testdata311,pe3);
RM312=rms(testdata312); S312 = rms(testdata312)/mean(abs(testdata312)); L312=(max(testdata312)-min(testdata312))/mean(sqrt(abs(testdata312)))^2; SE312=SampEn(testdata312,se31,se32); CE312=CondEn(testdata312,ce31,ce32); PE312=PermEn(testdata312,pe3);
RM313=rms(testdata313); S313 = rms(testdata313)/mean(abs(testdata313)); L313=(max(testdata313)-min(testdata313))/mean(sqrt(abs(testdata313)))^2; SE313=SampEn(testdata313,se31,se32); CE313=CondEn(testdata313,ce31,ce32); PE313=PermEn(testdata313,pe3);
RM314=rms(testdata314); S314 = rms(testdata314)/mean(abs(testdata314)); L314=(max(testdata314)-min(testdata314))/mean(sqrt(abs(testdata314)))^2; SE314=SampEn(testdata314,se31,se32); CE314=CondEn(testdata314,ce31,ce32); PE314=PermEn(testdata314,pe3);
RM315=rms(testdata315); S315 = rms(testdata315)/mean(abs(testdata315)); L315=(max(testdata315)-min(testdata315))/mean(sqrt(abs(testdata315)))^2; SE315=SampEn(testdata315,se31,se32); CE315=CondEn(testdata315,ce31,ce32); PE315=PermEn(testdata315,pe3);
RM316=rms(testdata316); S316 = rms(testdata316)/mean(abs(testdata316)); L316=(max(testdata316)-min(testdata316))/mean(sqrt(abs(testdata316)))^2; SE316=SampEn(testdata316,se31,se32); CE316=CondEn(testdata316,ce31,ce32); PE316=PermEn(testdata316,pe3);
RM317=rms(testdata317); S317 = rms(testdata317)/mean(abs(testdata317)); L317=(max(testdata317)-min(testdata317))/mean(sqrt(abs(testdata317)))^2; SE317=SampEn(testdata317,se31,se32); CE317=CondEn(testdata317,ce31,ce32); PE317=PermEn(testdata317,pe3);
RM318=rms(testdata318); S318 = rms(testdata318)/mean(abs(testdata318)); L318=(max(testdata318)-min(testdata318))/mean(sqrt(abs(testdata318)))^2; SE318=SampEn(testdata318,se31,se32); CE318=CondEn(testdata318,ce31,ce32); PE318=PermEn(testdata318,pe3);
RM319=rms(testdata319); S319 = rms(testdata319)/mean(abs(testdata319)); L319=(max(testdata319)-min(testdata319))/mean(sqrt(abs(testdata319)))^2; SE319=SampEn(testdata319,se31,se32); CE319=CondEn(testdata319,ce31,ce32); PE319=PermEn(testdata319,pe3);
RM320=rms(testdata320); S320 = rms(testdata320)/mean(abs(testdata320)); L320=(max(testdata320)-min(testdata320))/mean(sqrt(abs(testdata320)))^2; SE320=SampEn(testdata320,se31,se32); CE320=CondEn(testdata320,ce31,ce32); PE320=PermEn(testdata320,pe3);
RM321=rms(testdata321); S321 = rms(testdata321)/mean(abs(testdata321)); L321=(max(testdata321)-min(testdata321))/mean(sqrt(abs(testdata321)))^2; SE321=SampEn(testdata321,se31,se32); CE321=CondEn(testdata321,ce31,ce32); PE321=PermEn(testdata321,pe3);
RM322=rms(testdata322); S322 = rms(testdata322)/mean(abs(testdata322)); L322=(max(testdata322)-min(testdata322))/mean(sqrt(abs(testdata322)))^2; SE322=SampEn(testdata322,se31,se32); CE322=CondEn(testdata322,ce31,ce32); PE322=PermEn(testdata322,pe3);
RM323=rms(testdata323); S323 = rms(testdata323)/mean(abs(testdata323)); L323=(max(testdata323)-min(testdata323))/mean(sqrt(abs(testdata323)))^2; SE323=SampEn(testdata323,se31,se32); CE323=CondEn(testdata323,ce31,ce32); PE323=PermEn(testdata323,pe3);
RM324=rms(testdata324); S324 = rms(testdata324)/mean(abs(testdata324)); L324=(max(testdata324)-min(testdata324))/mean(sqrt(abs(testdata324)))^2; SE324=SampEn(testdata324,se31,se32); CE324=CondEn(testdata324,ce31,ce32); PE324=PermEn(testdata324,pe3);
RM325=rms(testdata325); S325 = rms(testdata325)/mean(abs(testdata325)); L325=(max(testdata325)-min(testdata325))/mean(sqrt(abs(testdata325)))^2; SE325=SampEn(testdata325,se31,se32); CE325=CondEn(testdata325,ce31,ce32); PE325=PermEn(testdata325,pe3);
RM326=rms(testdata326); S326 = rms(testdata326)/mean(abs(testdata326)); L326=(max(testdata326)-min(testdata326))/mean(sqrt(abs(testdata326)))^2; SE326=SampEn(testdata326,se31,se32); CE326=CondEn(testdata326,ce31,ce32); PE326=PermEn(testdata326,pe3);
RM327=rms(testdata327); S327 = rms(testdata327)/mean(abs(testdata327)); L327=(max(testdata327)-min(testdata327))/mean(sqrt(abs(testdata327)))^2; SE327=SampEn(testdata327,se31,se32); CE327=CondEn(testdata327,ce31,ce32); PE327=PermEn(testdata327,pe3);
RM328=rms(testdata328); S328 = rms(testdata328)/mean(abs(testdata328)); L328=(max(testdata328)-min(testdata328))/mean(sqrt(abs(testdata328)))^2; SE328=SampEn(testdata328,se31,se32); CE328=CondEn(testdata328,ce31,ce32); PE328=PermEn(testdata328,pe3);
RM329=rms(testdata329); S329 = rms(testdata329)/mean(abs(testdata329)); L329=(max(testdata329)-min(testdata329))/mean(sqrt(abs(testdata329)))^2; SE329=SampEn(testdata329,se31,se32); CE329=CondEn(testdata329,ce31,ce32); PE329=PermEn(testdata329,pe3);
RM330=rms(testdata330); S330 = rms(testdata330)/mean(abs(testdata330)); L330=(max(testdata330)-min(testdata330))/mean(sqrt(abs(testdata330)))^2; SE330=SampEn(testdata330,se31,se32); CE330=CondEn(testdata330,ce31,ce32); PE330=PermEn(testdata330,pe3);
RM331=rms(testdata331); S331 = rms(testdata331)/mean(abs(testdata331)); L331=(max(testdata331)-min(testdata331))/mean(sqrt(abs(testdata331)))^2; SE331=SampEn(testdata331,se31,se32); CE331=CondEn(testdata331,ce31,ce32); PE331=PermEn(testdata331,pe3);
RM332=rms(testdata332); S332 = rms(testdata332)/mean(abs(testdata332)); L332=(max(testdata332)-min(testdata332))/mean(sqrt(abs(testdata332)))^2; SE332=SampEn(testdata332,se31,se32); CE332=CondEn(testdata332,ce31,ce32); PE332=PermEn(testdata332,pe3);
RM333=rms(testdata333); S333 = rms(testdata333)/mean(abs(testdata333)); L333=(max(testdata333)-min(testdata333))/mean(sqrt(abs(testdata333)))^2; SE333=SampEn(testdata333,se31,se32); CE333=CondEn(testdata333,ce31,ce32); PE333=PermEn(testdata333,pe3);
RM334=rms(testdata334); S334 = rms(testdata334)/mean(abs(testdata334)); L334=(max(testdata334)-min(testdata334))/mean(sqrt(abs(testdata334)))^2; SE334=SampEn(testdata334,se31,se32); CE334=CondEn(testdata334,ce31,ce32); PE334=PermEn(testdata334,pe3);
RM335=rms(testdata335); S335 = rms(testdata335)/mean(abs(testdata335)); L335=(max(testdata335)-min(testdata335))/mean(sqrt(abs(testdata335)))^2; SE335=SampEn(testdata335,se31,se32); CE335=CondEn(testdata335,ce31,ce32); PE335=PermEn(testdata335,pe3);
RM336=rms(testdata336); S336 = rms(testdata336)/mean(abs(testdata336)); L336=(max(testdata336)-min(testdata336))/mean(sqrt(abs(testdata336)))^2; SE336=SampEn(testdata336,se31,se32); CE336=CondEn(testdata336,ce31,ce32); PE336=PermEn(testdata336,pe3);
RM337=rms(testdata337); S337 = rms(testdata337)/mean(abs(testdata337)); L337=(max(testdata337)-min(testdata337))/mean(sqrt(abs(testdata337)))^2; SE337=SampEn(testdata337,se31,se32); CE337=CondEn(testdata337,ce31,ce32); PE337=PermEn(testdata337,pe3);
RM338=rms(testdata338); S338 = rms(testdata338)/mean(abs(testdata338)); L338=(max(testdata338)-min(testdata338))/mean(sqrt(abs(testdata338)))^2; SE338=SampEn(testdata338,se31,se32); CE338=CondEn(testdata338,ce31,ce32); PE338=PermEn(testdata338,pe3);
RM339=rms(testdata339); S339 = rms(testdata339)/mean(abs(testdata339)); L339=(max(testdata339)-min(testdata339))/mean(sqrt(abs(testdata339)))^2; SE339=SampEn(testdata339,se31,se32); CE339=CondEn(testdata339,ce31,ce32); PE339=PermEn(testdata339,pe3);
RM340=rms(testdata340); S340 = rms(testdata340)/mean(abs(testdata340)); L340=(max(testdata340)-min(testdata340))/mean(sqrt(abs(testdata340)))^2; SE340=SampEn(testdata340,se31,se32); CE340=CondEn(testdata340,ce31,ce32); PE340=PermEn(testdata340,pe3);
RM341=rms(testdata341); S341 = rms(testdata341)/mean(abs(testdata341)); L341=(max(testdata341)-min(testdata341))/mean(sqrt(abs(testdata341)))^2; SE341=SampEn(testdata341,se31,se32); CE341=CondEn(testdata341,ce31,ce32); PE341=PermEn(testdata341,pe3);
RM342=rms(testdata342); S342 = rms(testdata342)/mean(abs(testdata342)); L342=(max(testdata342)-min(testdata342))/mean(sqrt(abs(testdata342)))^2; SE342=SampEn(testdata342,se31,se32); CE342=CondEn(testdata342,ce31,ce32); PE342=PermEn(testdata342,pe3);
RM343=rms(testdata343); S343 = rms(testdata343)/mean(abs(testdata343)); L343=(max(testdata343)-min(testdata343))/mean(sqrt(abs(testdata343)))^2; SE343=SampEn(testdata343,se31,se32); CE343=CondEn(testdata343,ce31,ce32); PE343=PermEn(testdata343,pe3);
RM344=rms(testdata344); S344 = rms(testdata344)/mean(abs(testdata344)); L344=(max(testdata344)-min(testdata344))/mean(sqrt(abs(testdata344)))^2; SE344=SampEn(testdata344,se31,se32); CE344=CondEn(testdata344,ce31,ce32); PE344=PermEn(testdata344,pe3);
RM345=rms(testdata345); S345 = rms(testdata345)/mean(abs(testdata345)); L345=(max(testdata345)-min(testdata345))/mean(sqrt(abs(testdata345)))^2; SE345=SampEn(testdata345,se31,se32); CE345=CondEn(testdata345,ce31,ce32); PE345=PermEn(testdata345,pe3);
RM346=rms(testdata346); S346 = rms(testdata346)/mean(abs(testdata346)); L346=(max(testdata346)-min(testdata346))/mean(sqrt(abs(testdata346)))^2; SE346=SampEn(testdata346,se31,se32); CE346=CondEn(testdata346,ce31,ce32); PE346=PermEn(testdata346,pe3);
RM347=rms(testdata347); S347 = rms(testdata347)/mean(abs(testdata347)); L347=(max(testdata347)-min(testdata347))/mean(sqrt(abs(testdata347)))^2; SE347=SampEn(testdata347,se31,se32); CE347=CondEn(testdata347,ce31,ce32); PE347=PermEn(testdata347,pe3);
RM348=rms(testdata348); S348 = rms(testdata348)/mean(abs(testdata348)); L348=(max(testdata348)-min(testdata348))/mean(sqrt(abs(testdata348)))^2; SE348=SampEn(testdata348,se31,se32); CE348=CondEn(testdata348,ce31,ce32); PE348=PermEn(testdata348,pe3);
RM349=rms(testdata349); S349 = rms(testdata349)/mean(abs(testdata349)); L349=(max(testdata349)-min(testdata349))/mean(sqrt(abs(testdata349)))^2; SE349=SampEn(testdata349,se31,se32); CE349=CondEn(testdata349,ce31,ce32); PE349=PermEn(testdata349,pe3);
RM350=rms(testdata350); S350 = rms(testdata350)/mean(abs(testdata350)); L350=(max(testdata350)-min(testdata350))/mean(sqrt(abs(testdata350)))^2; SE350=SampEn(testdata350,se31,se32); CE350=CondEn(testdata350,ce31,ce32); PE350=PermEn(testdata350,pe3);

tezheng3=[RM301,S301,L301,SE301,CE301,PE301;...
          RM302,S302,L302,SE302,CE302,PE302;...
          RM303,S303,L303,SE303,CE303,PE303;...
          RM304,S304,L304,SE304,CE304,PE304;...
          RM305,S305,L305,SE305,CE305,PE305;...
          RM306,S306,L306,SE306,CE306,PE306;...
          RM307,S307,L307,SE307,CE307,PE307;...
          RM308,S308,L308,SE308,CE308,PE308;...
          RM309,S309,L309,SE309,CE309,PE309;...
          RM310,S310,L310,SE310,CE310,PE310;...
          RM311,S311,L311,SE311,CE311,PE311;...
          RM312,S312,L312,SE312,CE312,PE312;...
          RM313,S313,L313,SE313,CE313,PE313;...
          RM314,S314,L314,SE314,CE314,PE314;...
          RM315,S315,L315,SE315,CE315,PE315;...
          RM316,S316,L316,SE316,CE316,PE316;...
          RM317,S317,L317,SE317,CE317,PE317;...
          RM318,S318,L318,SE318,CE318,PE318;...
          RM319,S319,L319,SE319,CE319,PE319;...
          RM320,S320,L320,SE320,CE320,PE320;...
          RM321,S321,L321,SE321,CE321,PE321;...
          RM322,S322,L322,SE322,CE322,PE322;...
          RM323,S323,L323,SE323,CE323,PE323;...
          RM324,S324,L324,SE324,CE324,PE324;...
          RM325,S325,L325,SE325,CE325,PE325;...
          RM326,S326,L326,SE326,CE326,PE326;...
          RM327,S327,L327,SE327,CE327,PE327;...
          RM328,S328,L328,SE328,CE328,PE328;...
          RM329,S329,L329,SE329,CE329,PE329;...
          RM330,S330,L330,SE330,CE330,PE330;...
          RM331,S331,L331,SE331,CE331,PE331;...
          RM332,S332,L332,SE332,CE332,PE332;...
          RM333,S333,L333,SE333,CE333,PE333;...
          RM334,S334,L334,SE334,CE334,PE334;...
          RM345,S335,L335,SE335,CE335,PE335;...
          RM336,S336,L336,SE336,CE336,PE336;...
          RM337,S337,L337,SE337,CE337,PE337;...
          RM338,S338,L338,SE338,CE338,PE338;...
          RM339,S339,L339,SE339,CE339,PE339;...
          RM340,S340,L340,SE340,CE340,PE340;...
          RM341,S341,L341,SE341,CE341,PE341;...
          RM342,S342,L342,SE342,CE342,PE342;...
          RM343,S343,L343,SE343,CE343,PE343;...
          RM344,S344,L344,SE344,CE344,PE344;...
          RM345,S345,L345,SE345,CE345,PE345;...
          RM346,S346,L346,SE346,CE346,PE346;...
          RM347,S347,L347,SE347,CE347,PE347;...
          RM348,S348,L348,SE348,CE348,PE348;...
          RM349,S349,L349,SE349,CE349,PE349;...
          RM350,S350,L350,SE350,CE350,PE350]
     
%% 外圈故障信号VMD分解，并提取最佳模态的特征组
[u, ~, ~] = VMD(X401, 3000, 0.1, K4, 0, 1, 1e-6);
k401=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k401(end+1)=kurt;
end
[~,I]=max(k401);
testdata401=u(I,:);
[u, ~, ~] = VMD(X402, 3000, 0.1, K4, 0, 1, 1e-6);
k402=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k402(end+1)=kurt;
end
[~,I]=max(k402);
testdata402=u(I,:);
[u, ~, ~] = VMD(X403, 3000, 0.1, K4, 0, 1, 1e-6);
k403=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k403(end+1)=kurt;
end
[~,I]=max(k403);
testdata403=u(I,:);
[u, ~, ~] = VMD(X404, 3000, 0.1, K4, 0, 1, 1e-6);
k404=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k404(end+1)=kurt;
end
[~,I]=max(k404);
testdata404=u(I,:);
[u, ~, ~] = VMD(X405, 3000, 0.1, K4, 0, 1, 1e-6);
k405=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k405(end+1)=kurt;
end
[~,I]=max(k405);
testdata405=u(I,:);
[u, ~, ~] = VMD(X406, 3000, 0.1, K4, 0, 1, 1e-6);
k406=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k406(end+1)=kurt;
end
[~,I]=max(k406);
testdata406=u(I,:);
[u, ~, ~] = VMD(X407, 3000, 0.1, K4, 0, 1, 1e-6);
k407=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k407(end+1)=kurt;
end
[~,I]=max(k407);
testdata407=u(I,:);
[u, ~, ~] = VMD(X408, 3000, 0.1, K4, 0, 1, 1e-6);
k408=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k408(end+1)=kurt;
end
[~,I]=max(k408);
testdata408=u(I,:);
[u, ~, ~] = VMD(X409, 3000, 0.1, K4, 0, 1, 1e-6);
k409=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k409(end+1)=kurt;
end
[~,I]=max(k409);
testdata409=u(I,:);
[u, ~, ~] = VMD(X410, 3000, 0.1, K4, 0, 1, 1e-6);
k410=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k410(end+1)=kurt;
end
[~,I]=max(k410);
testdata410=u(I,:);
[u, ~, ~] = VMD(X411, 3000, 0.1, K4, 0, 1, 1e-6);
k411=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k411(end+1)=kurt;
end
[~,I]=max(k411);
testdata411=u(I,:);
[u, ~, ~] = VMD(X412, 3000, 0.1, K4, 0, 1, 1e-6);
k412=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k412(end+1)=kurt;
end
[~,I]=max(k412);
testdata412=u(I,:);
[u, ~, ~] = VMD(X413, 3000, 0.1, K4, 0, 1, 1e-6);
k413=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k413(end+1)=kurt;
end
[~,I]=max(k413);
testdata413=u(I,:);
[u, ~, ~] = VMD(X414, 3000, 0.1, K4, 0, 1, 1e-6);
k414=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k414(end+1)=kurt;
end
[~,I]=max(k414);
testdata414=u(I,:);
[u, ~, ~] = VMD(X415, 3000, 0.1, K4, 0, 1, 1e-6);
k415=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k415(end+1)=kurt;
end
[~,I]=max(k415);
testdata415=u(I,:);
[u, ~, ~] = VMD(X416, 3000, 0.1, K4, 0, 1, 1e-6);
k416=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k416(end+1)=kurt;
end
[~,I]=max(k416);
testdata416=u(I,:);
[u, ~, ~] = VMD(X417, 3000, 0.1, K4, 0, 1, 1e-6);
k417=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k417(end+1)=kurt;
end
[~,I]=max(k417);
testdata417=u(I,:);
[u, ~, ~] = VMD(X418, 3000, 0.1, K4, 0, 1, 1e-6);
k418=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k418(end+1)=kurt;
end
[~,I]=max(k418);
testdata418=u(I,:);
[u, ~, ~] = VMD(X419, 3000, 0.1, K4, 0, 1, 1e-6);
k419=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k419(end+1)=kurt;
end
[~,I]=max(k419);
testdata419=u(I,:);
[u, ~, ~] = VMD(X420, 3000, 0.1, K4, 0, 1, 1e-6);
k420=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k420(end+1)=kurt;
end
[~,I]=max(k420);
testdata420=u(I,:);
[u, ~, ~] = VMD(X421, 3000, 0.1, K4, 0, 1, 1e-6);
k421=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k421(end+1)=kurt;
end
[~,I]=max(k421);
testdata421=u(I,:);
[u, ~, ~] = VMD(X422, 3000, 0.1, K4, 0, 1, 1e-6);
k422=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k422(end+1)=kurt;
end
[~,I]=max(k422);
testdata422=u(I,:);
[u, ~, ~] = VMD(X423, 3000, 0.1, K4, 0, 1, 1e-6);
k423=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k423(end+1)=kurt;
end
[~,I]=max(k423);
testdata423=u(I,:);
[u, ~, ~] = VMD(X424, 3000, 0.1, K4, 0, 1, 1e-6);
k424=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k424(end+1)=kurt;
end
[~,I]=max(k424);
testdata424=u(I,:);
[u, ~, ~] = VMD(X425, 3000, 0.1, K4, 0, 1, 1e-6);
k425=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k425(end+1)=kurt;
end
[~,I]=max(k425);
testdata425=u(I,:);
[u, ~, ~] = VMD(X426, 3000, 0.1, K4, 0, 1, 1e-6);
k426=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k426(end+1)=kurt;
end
[~,I]=max(k426);
testdata426=u(I,:);
[u, ~, ~] = VMD(X427, 3000, 0.1, K4, 0, 1, 1e-6);
k427=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k427(end+1)=kurt;
end
[~,I]=max(k427);
testdata427=u(I,:);
[u, ~, ~] = VMD(X428, 3000, 0.1, K4, 0, 1, 1e-6);
k428=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k428(end+1)=kurt;
end
[~,I]=max(k428);
testdata428=u(I,:);
[u, ~, ~] = VMD(X429, 3000, 0.1, K4, 0, 1, 1e-6);
k429=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k429(end+1)=kurt;
end
[~,I]=max(k429);
testdata429=u(I,:);
[u, ~, ~] = VMD(X430, 3000, 0.1, K4, 0, 1, 1e-6);
k430=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k430(end+1)=kurt;
end
[~,I]=max(k430);
testdata430=u(I,:);
[u, ~, ~] = VMD(X431, 3000, 0.1, K4, 0, 1, 1e-6);
k431=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k431(end+1)=kurt;
end
[~,I]=max(k431);
testdata431=u(I,:);
[u, ~, ~] = VMD(X432, 3000, 0.1, K4, 0, 1, 1e-6);
k432=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k432(end+1)=kurt;
end
[~,I]=max(k432);
testdata432=u(I,:);
[u, ~, ~] = VMD(X433, 3000, 0.1, K4, 0, 1, 1e-6);
k433=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k433(end+1)=kurt;
end
[~,I]=max(k433);
testdata433=u(I,:);
[u, ~, ~] = VMD(X434, 3000, 0.1, K4, 0, 1, 1e-6);
k434=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k434(end+1)=kurt;
end
[~,I]=max(k434);
testdata434=u(I,:);
[u, ~, ~] = VMD(X435, 3000, 0.1, K4, 0, 1, 1e-6);
k435=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k435(end+1)=kurt;
end
[~,I]=max(k435);
testdata435=u(I,:);
[u, ~, ~] = VMD(X436, 3000, 0.1, K4, 0, 1, 1e-6);
k436=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k436(end+1)=kurt;
end
[~,I]=max(k436);
testdata436=u(I,:);
[u, ~, ~] = VMD(X437, 3000, 0.1, K4, 0, 1, 1e-6);
k437=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k437(end+1)=kurt;
end
[~,I]=max(k437);
testdata437=u(I,:);
[u, ~, ~] = VMD(X438, 3000, 0.1, K4, 0, 1, 1e-6);
k438=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k438(end+1)=kurt;
end
[~,I]=max(k438);
testdata438=u(I,:);
[u, ~, ~] = VMD(X439, 3000, 0.1, K4, 0, 1, 1e-6);
k439=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k439(end+1)=kurt;
end
[~,I]=max(k439);
testdata439=u(I,:);
[u, ~, ~] = VMD(X440, 3000, 0.1, K4, 0, 1, 1e-6);
k440=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k440(end+1)=kurt;
end
[~,I]=max(k440);
testdata440=u(I,:);
[u, ~, ~] = VMD(X441, 3000, 0.1, K4, 0, 1, 1e-6);
k441=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k441(end+1)=kurt;
end
[~,I]=max(k441);
testdata441=u(I,:);
[u, ~, ~] = VMD(X442, 3000, 0.1, K4, 0, 1, 1e-6);
k442=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k442(end+1)=kurt;
end
[~,I]=max(k442);
testdata442=u(I,:);
[u, ~, ~] = VMD(X443, 3000, 0.1, K4, 0, 1, 1e-6);
k443=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k443(end+1)=kurt;
end
[~,I]=max(k443);
testdata443=u(I,:);
[u, ~, ~] = VMD(X444, 3000, 0.1, K4, 0, 1, 1e-6);
k444=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k444(end+1)=kurt;
end
[~,I]=max(k444);
testdata444=u(I,:);
[u, ~, ~] = VMD(X445, 3000, 0.1, K4, 0, 1, 1e-6);
k445=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k445(end+1)=kurt;
end
[~,I]=max(k445);
testdata445=u(I,:);
[u, ~, ~] = VMD(X446, 3000, 0.1, K4, 0, 1, 1e-6);
k446=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k446(end+1)=kurt;
end
[~,I]=max(k446);
testdata446=u(I,:);
[u, ~, ~] = VMD(X447, 3000, 0.1, K4, 0, 1, 1e-6);
k447=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k447(end+1)=kurt;
end
[~,I]=max(k447);
testdata447=u(I,:);
[u, ~, ~] = VMD(X448, 3000, 0.1, K4, 0, 1, 1e-6);
k448=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k448(end+1)=kurt;
end
[~,I]=max(k448);
testdata448=u(I,:);
[u, ~, ~] = VMD(X449, 3000, 0.1, K4, 0, 1, 1e-6);
k449=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k449(end+1)=kurt;
end
[~,I]=max(k449);
testdata449=u(I,:);
[u, ~, ~] = VMD(X450, 3000, 0.1, K4, 0, 1, 1e-6);
k450=[];
for i=1:K4
        testdata=u(i,:);
        kurt=kurtosis(testdata);
        k450(end+1)=kurt;
end
[~,I]=max(k450);
testdata450=u(I,:);
RM401=rms(testdata401); S401 = rms(testdata401)/mean(abs(testdata401)); L401=(max(testdata401)-min(testdata401))/mean(sqrt(abs(testdata401)))^2; SE401=SampEn(testdata401,se41,se42); CE401=CondEn(testdata401,ce41,ce42); PE401=PermEn(testdata401,pe4);
RM402=rms(testdata402); S402 = rms(testdata402)/mean(abs(testdata402)); L402=(max(testdata402)-min(testdata402))/mean(sqrt(abs(testdata402)))^2; SE402=SampEn(testdata402,se41,se42); CE402=CondEn(testdata402,ce41,ce42); PE402=PermEn(testdata402,pe4);
RM403=rms(testdata403); S403 = rms(testdata403)/mean(abs(testdata403)); L403=(max(testdata403)-min(testdata403))/mean(sqrt(abs(testdata403)))^2; SE403=SampEn(testdata403,se41,se42); CE403=CondEn(testdata403,ce41,ce42); PE403=PermEn(testdata403,pe4);
RM404=rms(testdata404); S404 = rms(testdata404)/mean(abs(testdata404)); L404=(max(testdata404)-min(testdata404))/mean(sqrt(abs(testdata404)))^2; SE404=SampEn(testdata404,se41,se42); CE404=CondEn(testdata404,ce41,ce42); PE404=PermEn(testdata404,pe4);
RM405=rms(testdata405); S405 = rms(testdata405)/mean(abs(testdata405)); L405=(max(testdata405)-min(testdata405))/mean(sqrt(abs(testdata405)))^2; SE405=SampEn(testdata405,se41,se42); CE405=CondEn(testdata405,ce41,ce42); PE405=PermEn(testdata405,pe4);
RM406=rms(testdata406); S406 = rms(testdata406)/mean(abs(testdata406)); L406=(max(testdata406)-min(testdata406))/mean(sqrt(abs(testdata406)))^2; SE406=SampEn(testdata406,se41,se42); CE406=CondEn(testdata406,ce41,ce42); PE406=PermEn(testdata406,pe4);
RM407=rms(testdata407); S407 = rms(testdata407)/mean(abs(testdata407)); L407=(max(testdata407)-min(testdata407))/mean(sqrt(abs(testdata407)))^2; SE407=SampEn(testdata407,se41,se42); CE407=CondEn(testdata407,ce41,ce42); PE407=PermEn(testdata407,pe4);
RM408=rms(testdata408); S408 = rms(testdata408)/mean(abs(testdata408)); L408=(max(testdata408)-min(testdata408))/mean(sqrt(abs(testdata408)))^2; SE408=SampEn(testdata408,se41,se42); CE408=CondEn(testdata408,ce41,ce42); PE408=PermEn(testdata408,pe4);
RM409=rms(testdata409); S409 = rms(testdata409)/mean(abs(testdata409)); L409=(max(testdata409)-min(testdata409))/mean(sqrt(abs(testdata409)))^2; SE409=SampEn(testdata409,se41,se42); CE409=CondEn(testdata409,ce41,ce42); PE409=PermEn(testdata409,pe4);
RM410=rms(testdata410); S410 = rms(testdata410)/mean(abs(testdata410)); L410=(max(testdata410)-min(testdata410))/mean(sqrt(abs(testdata410)))^2; SE410=SampEn(testdata410,se41,se42); CE410=CondEn(testdata410,ce41,ce42); PE410=PermEn(testdata410,pe4);
RM411=rms(testdata411); S411 = rms(testdata411)/mean(abs(testdata411)); L411=(max(testdata411)-min(testdata411))/mean(sqrt(abs(testdata411)))^2; SE411=SampEn(testdata411,se41,se42); CE411=CondEn(testdata411,ce41,ce42); PE411=PermEn(testdata411,pe4);
RM412=rms(testdata412); S412 = rms(testdata412)/mean(abs(testdata412)); L412=(max(testdata412)-min(testdata412))/mean(sqrt(abs(testdata412)))^2; SE412=SampEn(testdata412,se41,se42); CE412=CondEn(testdata412,ce41,ce42); PE412=PermEn(testdata412,pe4);
RM413=rms(testdata413); S413 = rms(testdata413)/mean(abs(testdata413)); L413=(max(testdata413)-min(testdata413))/mean(sqrt(abs(testdata413)))^2; SE413=SampEn(testdata413,se41,se42); CE413=CondEn(testdata413,ce41,ce42); PE413=PermEn(testdata413,pe4);
RM414=rms(testdata414); S414 = rms(testdata414)/mean(abs(testdata414)); L414=(max(testdata414)-min(testdata414))/mean(sqrt(abs(testdata414)))^2; SE414=SampEn(testdata414,se41,se42); CE414=CondEn(testdata414,ce41,ce42); PE414=PermEn(testdata414,pe4);
RM415=rms(testdata415); S415 = rms(testdata415)/mean(abs(testdata415)); L415=(max(testdata415)-min(testdata415))/mean(sqrt(abs(testdata415)))^2; SE415=SampEn(testdata415,se41,se42); CE415=CondEn(testdata415,ce41,ce42); PE415=PermEn(testdata415,pe4);
RM416=rms(testdata416); S416 = rms(testdata416)/mean(abs(testdata416)); L416=(max(testdata416)-min(testdata416))/mean(sqrt(abs(testdata416)))^2; SE416=SampEn(testdata416,se41,se42); CE416=CondEn(testdata416,ce41,ce42); PE416=PermEn(testdata416,pe4);
RM417=rms(testdata417); S417 = rms(testdata417)/mean(abs(testdata417)); L417=(max(testdata417)-min(testdata417))/mean(sqrt(abs(testdata417)))^2; SE417=SampEn(testdata417,se41,se42); CE417=CondEn(testdata417,ce41,ce42); PE417=PermEn(testdata417,pe4);
RM418=rms(testdata418); S418 = rms(testdata418)/mean(abs(testdata418)); L418=(max(testdata418)-min(testdata418))/mean(sqrt(abs(testdata418)))^2; SE418=SampEn(testdata418,se41,se42); CE418=CondEn(testdata418,ce41,ce42); PE418=PermEn(testdata418,pe4);
RM419=rms(testdata419); S419 = rms(testdata419)/mean(abs(testdata419)); L419=(max(testdata419)-min(testdata419))/mean(sqrt(abs(testdata419)))^2; SE419=SampEn(testdata419,se41,se42); CE419=CondEn(testdata419,ce41,ce42); PE419=PermEn(testdata419,pe4);
RM420=rms(testdata420); S420 = rms(testdata420)/mean(abs(testdata420)); L420=(max(testdata420)-min(testdata420))/mean(sqrt(abs(testdata420)))^2; SE420=SampEn(testdata420,se41,se42); CE420=CondEn(testdata420,ce41,ce42); PE420=PermEn(testdata420,pe4);
RM421=rms(testdata421); S421 = rms(testdata421)/mean(abs(testdata421)); L421=(max(testdata421)-min(testdata421))/mean(sqrt(abs(testdata421)))^2; SE421=SampEn(testdata421,se41,se42); CE421=CondEn(testdata421,ce41,ce42); PE421=PermEn(testdata421,pe4);
RM422=rms(testdata422); S422 = rms(testdata422)/mean(abs(testdata422)); L422=(max(testdata422)-min(testdata422))/mean(sqrt(abs(testdata422)))^2; SE422=SampEn(testdata422,se41,se42); CE422=CondEn(testdata422,ce41,ce42); PE422=PermEn(testdata422,pe4);
RM423=rms(testdata423); S423 = rms(testdata423)/mean(abs(testdata423)); L423=(max(testdata423)-min(testdata423))/mean(sqrt(abs(testdata423)))^2; SE423=SampEn(testdata423,se41,se42); CE423=CondEn(testdata423,ce41,ce42); PE423=PermEn(testdata423,pe4);
RM424=rms(testdata424); S424 = rms(testdata424)/mean(abs(testdata424)); L424=(max(testdata424)-min(testdata424))/mean(sqrt(abs(testdata424)))^2; SE424=SampEn(testdata424,se41,se42); CE424=CondEn(testdata424,ce41,ce42); PE424=PermEn(testdata424,pe4);
RM425=rms(testdata425); S425 = rms(testdata425)/mean(abs(testdata425)); L425=(max(testdata425)-min(testdata425))/mean(sqrt(abs(testdata425)))^2; SE425=SampEn(testdata425,se41,se42); CE425=CondEn(testdata425,ce41,ce42); PE425=PermEn(testdata425,pe4);
RM426=rms(testdata426); S426 = rms(testdata426)/mean(abs(testdata426)); L426=(max(testdata426)-min(testdata426))/mean(sqrt(abs(testdata426)))^2; SE426=SampEn(testdata426,se41,se42); CE426=CondEn(testdata426,ce41,ce42); PE426=PermEn(testdata426,pe4);
RM427=rms(testdata427); S427 = rms(testdata427)/mean(abs(testdata427)); L427=(max(testdata427)-min(testdata427))/mean(sqrt(abs(testdata427)))^2; SE427=SampEn(testdata427,se41,se42); CE427=CondEn(testdata427,ce41,ce42); PE427=PermEn(testdata427,pe4);
RM428=rms(testdata428); S428 = rms(testdata428)/mean(abs(testdata428)); L428=(max(testdata428)-min(testdata428))/mean(sqrt(abs(testdata428)))^2; SE428=SampEn(testdata428,se41,se42); CE428=CondEn(testdata428,ce41,ce42); PE428=PermEn(testdata428,pe4);
RM429=rms(testdata429); S429 = rms(testdata429)/mean(abs(testdata429)); L429=(max(testdata429)-min(testdata429))/mean(sqrt(abs(testdata429)))^2; SE429=SampEn(testdata429,se41,se42); CE429=CondEn(testdata429,ce41,ce42); PE429=PermEn(testdata429,pe4);
RM430=rms(testdata430); S430 = rms(testdata430)/mean(abs(testdata430)); L430=(max(testdata430)-min(testdata430))/mean(sqrt(abs(testdata430)))^2; SE430=SampEn(testdata430,se41,se42); CE430=CondEn(testdata430,ce41,ce42); PE430=PermEn(testdata430,pe4);
RM431=rms(testdata431); S431 = rms(testdata431)/mean(abs(testdata431)); L431=(max(testdata431)-min(testdata431))/mean(sqrt(abs(testdata431)))^2; SE431=SampEn(testdata431,se41,se42); CE431=CondEn(testdata431,ce41,ce42); PE431=PermEn(testdata431,pe4);
RM432=rms(testdata432); S432 = rms(testdata432)/mean(abs(testdata432)); L432=(max(testdata432)-min(testdata432))/mean(sqrt(abs(testdata432)))^2; SE432=SampEn(testdata432,se41,se42); CE432=CondEn(testdata432,ce41,ce42); PE432=PermEn(testdata432,pe4);
RM433=rms(testdata433); S433 = rms(testdata433)/mean(abs(testdata433)); L433=(max(testdata433)-min(testdata433))/mean(sqrt(abs(testdata433)))^2; SE433=SampEn(testdata433,se41,se42); CE433=CondEn(testdata433,ce41,ce42); PE433=PermEn(testdata433,pe4);
RM434=rms(testdata434); S434 = rms(testdata434)/mean(abs(testdata434)); L434=(max(testdata434)-min(testdata434))/mean(sqrt(abs(testdata434)))^2; SE434=SampEn(testdata434,se41,se42); CE434=CondEn(testdata434,ce41,ce42); PE434=PermEn(testdata434,pe4);
RM435=rms(testdata435); S435 = rms(testdata435)/mean(abs(testdata435)); L435=(max(testdata435)-min(testdata435))/mean(sqrt(abs(testdata435)))^2; SE435=SampEn(testdata435,se41,se42); CE435=CondEn(testdata435,ce41,ce42); PE435=PermEn(testdata435,pe4);
RM436=rms(testdata436); S436 = rms(testdata436)/mean(abs(testdata436)); L436=(max(testdata436)-min(testdata436))/mean(sqrt(abs(testdata436)))^2; SE436=SampEn(testdata436,se41,se42); CE436=CondEn(testdata436,ce41,ce42); PE436=PermEn(testdata436,pe4);
RM437=rms(testdata437); S437 = rms(testdata437)/mean(abs(testdata437)); L437=(max(testdata437)-min(testdata437))/mean(sqrt(abs(testdata437)))^2; SE437=SampEn(testdata437,se41,se42); CE437=CondEn(testdata437,ce41,ce42); PE437=PermEn(testdata437,pe4);
RM438=rms(testdata438); S438 = rms(testdata438)/mean(abs(testdata438)); L438=(max(testdata438)-min(testdata438))/mean(sqrt(abs(testdata438)))^2; SE438=SampEn(testdata438,se41,se42); CE438=CondEn(testdata438,ce41,ce42); PE438=PermEn(testdata438,pe4);
RM439=rms(testdata439); S439 = rms(testdata439)/mean(abs(testdata439)); L439=(max(testdata439)-min(testdata439))/mean(sqrt(abs(testdata439)))^2; SE439=SampEn(testdata439,se41,se42); CE439=CondEn(testdata439,ce41,ce42); PE439=PermEn(testdata439,pe4);
RM440=rms(testdata440); S440 = rms(testdata440)/mean(abs(testdata440)); L440=(max(testdata440)-min(testdata440))/mean(sqrt(abs(testdata440)))^2; SE440=SampEn(testdata440,se41,se42); CE440=CondEn(testdata440,ce41,ce42); PE440=PermEn(testdata440,pe4);
RM441=rms(testdata441); S441 = rms(testdata441)/mean(abs(testdata441)); L441=(max(testdata441)-min(testdata441))/mean(sqrt(abs(testdata441)))^2; SE441=SampEn(testdata441,se41,se42); CE441=CondEn(testdata441,ce41,ce42); PE441=PermEn(testdata441,pe4);
RM442=rms(testdata442); S442 = rms(testdata442)/mean(abs(testdata442)); L442=(max(testdata442)-min(testdata442))/mean(sqrt(abs(testdata442)))^2; SE442=SampEn(testdata442,se41,se42); CE442=CondEn(testdata442,ce41,ce42); PE442=PermEn(testdata442,pe4);
RM443=rms(testdata443); S443 = rms(testdata443)/mean(abs(testdata443)); L443=(max(testdata443)-min(testdata443))/mean(sqrt(abs(testdata443)))^2; SE443=SampEn(testdata443,se41,se42); CE443=CondEn(testdata443,ce41,ce42); PE443=PermEn(testdata443,pe4);
RM444=rms(testdata444); S444 = rms(testdata444)/mean(abs(testdata444)); L444=(max(testdata444)-min(testdata444))/mean(sqrt(abs(testdata444)))^2; SE444=SampEn(testdata444,se41,se42); CE444=CondEn(testdata444,ce41,ce42); PE444=PermEn(testdata444,pe4);
RM445=rms(testdata445); S445 = rms(testdata445)/mean(abs(testdata445)); L445=(max(testdata445)-min(testdata445))/mean(sqrt(abs(testdata445)))^2; SE445=SampEn(testdata445,se41,se42); CE445=CondEn(testdata445,ce41,ce42); PE445=PermEn(testdata445,pe4);
RM446=rms(testdata446); S446 = rms(testdata446)/mean(abs(testdata446)); L446=(max(testdata446)-min(testdata446))/mean(sqrt(abs(testdata446)))^2; SE446=SampEn(testdata446,se41,se42); CE446=CondEn(testdata446,ce41,ce42); PE446=PermEn(testdata446,pe4);
RM447=rms(testdata447); S447 = rms(testdata447)/mean(abs(testdata447)); L447=(max(testdata447)-min(testdata447))/mean(sqrt(abs(testdata447)))^2; SE447=SampEn(testdata447,se41,se42); CE447=CondEn(testdata447,ce41,ce42); PE447=PermEn(testdata447,pe4);
RM448=rms(testdata448); S448 = rms(testdata448)/mean(abs(testdata448)); L448=(max(testdata448)-min(testdata448))/mean(sqrt(abs(testdata448)))^2; SE448=SampEn(testdata448,se41,se42); CE448=CondEn(testdata448,ce41,ce42); PE448=PermEn(testdata448,pe4);
RM449=rms(testdata449); S449 = rms(testdata449)/mean(abs(testdata449)); L449=(max(testdata449)-min(testdata449))/mean(sqrt(abs(testdata449)))^2; SE449=SampEn(testdata449,se41,se42); CE449=CondEn(testdata449,ce41,ce42); PE449=PermEn(testdata449,pe4);
RM450=rms(testdata450); S450 = rms(testdata450)/mean(abs(testdata450)); L450=(max(testdata450)-min(testdata450))/mean(sqrt(abs(testdata450)))^2; SE450=SampEn(testdata450,se41,se42); CE450=CondEn(testdata450,ce41,ce42); PE450=PermEn(testdata450,pe4);

tezheng4=[RM401,S401,L401,SE401,CE401,PE401;...
          RM402,S402,L402,SE402,CE402,PE402;...
          RM403,S403,L403,SE403,CE403,PE403;...
          RM404,S404,L404,SE404,CE404,PE404;...
          RM405,S405,L405,SE405,CE405,PE405;...
          RM406,S406,L406,SE406,CE406,PE406;...
          RM407,S407,L407,SE407,CE407,PE407;...
          RM408,S408,L408,SE408,CE408,PE408;...
          RM409,S409,L409,SE409,CE409,PE409;...
          RM410,S410,L410,SE410,CE410,PE410;...
          RM411,S411,L411,SE411,CE411,PE411;...
          RM412,S412,L412,SE412,CE412,PE412;...
          RM413,S413,L413,SE413,CE413,PE413;...
          RM414,S414,L414,SE414,CE414,PE414;...
          RM415,S415,L415,SE415,CE415,PE415;...
          RM416,S416,L416,SE416,CE416,PE416;...
          RM417,S417,L417,SE417,CE417,PE417;...
          RM418,S418,L418,SE418,CE418,PE418;...
          RM419,S419,L419,SE419,CE419,PE419;...
          RM420,S420,L420,SE420,CE420,PE420;...
          RM421,S421,L421,SE421,CE421,PE421;...
          RM422,S422,L422,SE422,CE422,PE422;...
          RM423,S423,L423,SE423,CE423,PE423;...
          RM424,S424,L424,SE424,CE424,PE424;...
          RM425,S425,L425,SE425,CE425,PE425;...
          RM426,S426,L426,SE426,CE426,PE426;...
          RM427,S427,L427,SE427,CE427,PE427;...
          RM428,S428,L428,SE428,CE428,PE428;...
          RM429,S429,L429,SE429,CE429,PE429;...
          RM430,S430,L430,SE430,CE430,PE430;...
          RM431,S431,L431,SE431,CE431,PE431;...
          RM432,S432,L432,SE432,CE432,PE432;...
          RM433,S433,L433,SE433,CE433,PE433;...
          RM434,S434,L434,SE434,CE434,PE434;...
          RM445,S435,L435,SE435,CE435,PE435;...
          RM436,S436,L436,SE436,CE436,PE436;...
          RM437,S437,L437,SE437,CE437,PE437;...
          RM438,S438,L438,SE438,CE438,PE438;...
          RM439,S439,L439,SE439,CE439,PE439;...
          RM440,S440,L440,SE440,CE440,PE440;...
          RM441,S441,L441,SE441,CE441,PE441;...
          RM442,S442,L442,SE442,CE442,PE442;...
          RM443,S443,L443,SE443,CE443,PE443;...
          RM444,S444,L444,SE444,CE444,PE444;...
          RM445,S445,L445,SE445,CE445,PE445;...
          RM446,S446,L446,SE446,CE446,PE446;...
          RM447,S447,L447,SE447,CE447,PE447;...
          RM448,S448,L448,SE448,CE448,PE448;...
          RM449,S449,L449,SE449,CE449,PE449;...
          RM450,S450,L450,SE450,CE450,PE450]