%支持向量机诊断轴承故障
%% 初始化
%clear all
%clc
%load data.mat
%训练集---10个样本
train_matrix=[tezheng1(1:10,:);tezheng2(1:10,:);tezheng3(1:10,:);tezheng4(1:10,:)];

train_label=[1,1,1,1,1,1,1,1,1,1,...
             2,2,2,2,2,2,2,2,2,2,...
             3,3,3,3,3,3,3,3,3,3,...
             4,4,4,4,4,4,4,4,4,4]';
%测试集---10个样本
test_matrix=[tezheng1(26:50,:);tezheng2(26:50,:);tezheng3(26:50,:);tezheng4(26:50,:)];
test_label=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,...
            2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,...
            3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,...
            4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4]';
%% 数据归一化
%训练集
[Train_matrix,PS]=mapminmax(train_matrix');
Train_matrix=Train_matrix';
%测试集
Test_matrix=mapminmax('apply',test_matrix',PS);
Test_matrix=Test_matrix';
%% SVM创建/训练(RBF核函数)
%寻找最佳c/g参数——交叉验证方法
[c,g]=meshgrid(-10:0.2:10,-10:0.2:10);
[m,n]=size(c);
cg=zeros(m,n);
eps=10^(-4);
v=5;
bestc=1;
bestg=0.1;
bestacc=0;
for i=1:m
    for j=1:n
        cmd=[' -v ',num2str(v),' -c ',num2str(2^c(i,j)),' -g ',num2str(2^g(i,j))];
        cg(i,j)=svmtrain(train_label,Train_matrix,cmd);
        if cg(i,j)>bestacc
            bestacc=cg(i,j);
            bestc=2^c(i,j);
            bestg=2^g(i,j);
        end
        if abs(cg(i,j)-bestacc)<=eps&&bestc>2^c(i,j)
            bestacc=cg(i,j);
            bestc=2^c(i,j);
            bestg=2^g(i,j);
        end
    end        
end
%创建/训练SVM
cmd=[' -c ',num2str(bestc),' -g ',num2str(bestg)];
model=svmtrain(train_label,Train_matrix,cmd);
%% SVM仿真测试
[predict_label_1,accuracy_1]=svmpredict(train_label,Train_matrix,model);
[predict_label_2,accuracy_2]=svmpredict(test_label,Test_matrix,model);
result_1=[train_label predict_label_1]
result_2=[test_label predict_label_2]
%% 绘图
figure
stem(1:length(train_label),train_label,'r- *')
hold on
stem(1:length(train_label),predict_label_1,'b:o')
grid on
legend('真实类别','预测类别')
xlabel('训练集样本编号')
ylabel('训练集样本类别')
string_1={'训练集SVM预测结果对比';['精度=' num2str(accuracy_1(1)) '%']};
title(string_1)
figure
stem(1:length(test_label),test_label,'c- *')
hold on
stem(1:length(test_label),predict_label_2,'b:o')
grid on
legend('真实类别','预测类别')
xlabel('测试集样本编号')
ylabel('测试集样本类别')
string={'测试集SVM预测结果对比(RBF核函数)';['精度=' num2str(accuracy_2(1)) '%']};
title(string)