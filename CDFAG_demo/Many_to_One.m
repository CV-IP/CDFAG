function [y,net]=Many_to_One(source,Target_N,test)

%---------------------------------------------------
% ָ��ѵ������
%---------------------------------------------------
% net.trainFcn = 'traingd'; % �ݶ��½��㷨
% net.trainFcn = 'traingdm'; % �����ݶ��½��㷨
%
% net.trainFcn = 'traingda'; % ��ѧϰ���ݶ��½��㷨
% net.trainFcn = 'traingdx'; % ��ѧϰ�ʶ����ݶ��½��㷨
%
% (�����������ѡ�㷨)
% net.trainFcn = 'trainrp'; % RPROP(����BP)�㷨,�ڴ�������С
%
% (�����ݶ��㷨)
% net.trainFcn = 'traincgf'; % Fletcher-Reeves�����㷨
% net.trainFcn = 'traincgp'; % Polak-Ribiere�����㷨,�ڴ������Fletcher-Reeves�����㷨�Դ�
% net.trainFcn = 'traincgb'; % Powell-Beal��λ�㷨,�ڴ������Polak-Ribiere�����㷨�Դ�
%
% (�����������ѡ�㷨)
%net.trainFcn = 'trainscg'; % Scaled Conjugate Gradient�㷨,�ڴ�������Fletcher-Reeves�����㷨��ͬ,�����������������㷨��С�ܶ�
% net.trainFcn = 'trainbfg'; % Quasi-Newton Algorithms - BFGS Algorithm,���������ڴ�������ȹ����ݶ��㷨��,�������ȽϿ�
% net.trainFcn = 'trainoss'; % One Step Secant Algorithm,���������ڴ��������BFGS�㷨С,�ȹ����ݶ��㷨�Դ�
%
% (�����������ѡ�㷨)
%net.trainFcn = 'trainlm'; % Levenberg-Marquardt�㷨,�ڴ��������,�����ٶ����
% net.trainFcn = 'trainbr'; % ��Ҷ˹�����㷨
%�����������
%setdemorandstream(pi)
%net= newff( minmax(source) , 100, { 'logsig'  }  ) ; 
%% �½�BP�����磬�����ò��� 
hiddenNet=100;
net = feedforwardnet(hiddenNet);
net.layers{1}.initFcn = 'initwb'; 
% net.layers{2}.initFcn = 'initwb';
net.layers{1}.transferFcn='logsig';
% net.layers{2}.transferFcn='logsig';
%ʹ�ú���һ���������ģ�ͣ���������10����Ԫ������Matlab��patternnet����
%patternnet�����Ĳ����У�hiddenSizes��trainFcn��performFcn��������hiddenSizesĬ��ֵ��10
%�����������ʾ��������㡣trainFcnĬ��ֵ�ǡ�trainscg����performFcnĬ���ǡ�crossentropy����
%�����Ҫ�����������㣬ÿ�����Ԫ����10���������д��net = patternnet��[10,10]�� ;
%net = patternnet(500);
net.trainParam.epochs=1000; %���ѵ��������ȱʡֵΪ10��
net.trainParam.show=25;%��ʾѵ���������̣�NaN��ʾ����ʾ��ȱʡΪ25����ÿ25����ʾһ��
net.trainParam.showCommandLine=0;%��ʾ�����У�Ĭ��ֵ��0�� 0��ʾ����ʾ
net.trainParam.showWindow=1; %��ʾGUI��Ĭ��ֵ��1�� 1��ʾ��ʾ
net.trainParam.goal=0;%ѵ��Ҫ�󾫶ȣ�ȱʡΪ0��
net.trainParam.time=inf;%���ѵ��ʱ�䣨ȱʡΪinf��
net.trainParam.min_grad=1e-6;%��С�ݶ�Ҫ��ȱʡΪ1e-10��
net.trainParam.max_fail=5;%���ʧ�ܴ�����ȱʡΪ5��
net.performFcn='mse';%���ܺ���
net.trainFcn = 'trainscg';
net.trainParam.lr = 0.1;%ѧϰ����
net.trainParam.mc = 0.9;%momentum
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
%net = init(net); 
% ѵ��������ģ��
net= train(net,source,Target_N);
%netPath = ['net\net_' dataset '_' num2str(hiddenNet) '.mat'];
%save(netPath,'net');
%view(net);
disp('BP������ѵ����ɣ�');
%% ʹ��ѵ���õ�BP���������Ԥ��
%test=importdata('test.txt');
%test=test';
% y=net(test);
y=sim(net,test);
%mse(y, T1)
%y2= sim(net,test);
%plotconfusion(target,y);
disp('Ԥ����ɣ�');