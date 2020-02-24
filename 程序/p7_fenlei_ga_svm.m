%�Ŵ��㷨�Ż�֧�������������й���
%% ��ʼ��
%clear all
%clc
%load data.mat
%ѵ����---100������
train_matrix=[tezheng1(1:44,:);tezheng2(1:44,:);tezheng3(1:44,:);tezheng4(1:44,:)];

train_label=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,...
             2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,...
             3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,...
             4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4]';
%���Լ�---100������
test_matrix=[tezheng1(26:50,:);tezheng2(26:50,:);tezheng3(26:50,:);tezheng4(26:50,:)];
test_label=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,...
            2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,...
            3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,...
            4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4]';
%% ���ݹ�һ��
%ѵ����
[Train_matrix,PS]=mapminmax(train_matrix');
Train_matrix=Train_matrix';
%���Լ�
Test_matrix=mapminmax('apply',test_matrix',PS);
Test_matrix=Test_matrix';
%% �Ŵ��㷨�Ż�c,g
%gaSVMcgForClass�Ŵ��㷨�����Ż�
ga_option.maxgen = 40;
ga_option.sizepop = 25;
ga_option.cbound = [30,80];
ga_option.gbound = [0,100];
ga_option.v = 5;
ga_option.ggap = 0.5;
[BestCVaccuracy,bestc,bestg,ga_option] = gaSVMcgForClass(train_label,train_matrix,ga_option);
disp('Optimization complete!');
%% SVM����/ѵ��(RBF�˺���)
%Ѱ�����c/g��������������֤����

%����/ѵ��SVM
cmd=[' -c ',num2str(bestc),' -g ',num2str(bestg)];
model=svmtrain(train_label,Train_matrix,cmd);
%% SVM�������
[predict_label_1,accuracy_1]=svmpredict(train_label,Train_matrix,model);
[predict_label_2,accuracy_2]=svmpredict(test_label,Test_matrix,model);
result_1=[train_label predict_label_1]
result_2=[test_label predict_label_2]
%% ��ͼ
figure
stem(1:length(train_label),train_label,'r- *')
hold on
stem(1:length(train_label),predict_label_1,'b:o')
grid on
legend('��ʵ���','Ԥ�����')
xlabel('ѵ�����������')
ylabel('ѵ�����������')
string_1={'ѵ����SVMԤ�����Ա�';['����=' num2str(accuracy_1(1)) '%']};
title(string_1)
figure
stem(1:length(test_label),test_label,'g- *')
hold on
stem(1:length(test_label),predict_label_2,'b:o')
grid on
legend('��ʵ���','Ԥ�����')
xlabel('���Լ��������')
ylabel('���Լ��������')
string={'���Լ�SVMԤ�����Ա�(RBF�˺���)';['����=' num2str(accuracy_2(1)) '%']};
title(string)