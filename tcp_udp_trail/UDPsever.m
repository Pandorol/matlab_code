ipA = '192.168.43.252'; %Local IP��������IP
portA = 5000;%ѡ��һ��δ��ռ�õĶ˿ڣ�
ipB = '192.168.43.10';%��Ҫȥ���Ӷ˵�IP,ע����ô�������ĵڶ������ּ�0������IP���һ�£�ʹ�����紦��ͬһ����
portB = 50001;
udpA = udp(ipB,'RemotePort',portB,'LocalPort',portA);%�½�һ��udpͨ�Ŷ���
set(udpA,'OutputBufferSize',8192);%����OutputBufferSize
set(udpA,'TimeOut',10000);
fopen(udpA);%�豸֮��LANͨ������
%fprintf('NOT Blank');
a1 =  fscanf(udpA);
display(class(a1));%�鿴���յ����ݵ�����
display(size(a1));%�鿴���յ����ݵĴ�С

fclose(udpA);
delete(udpA);
clear ipA portA ipB portB;
display(666)
