ipA = '192.168.43.252'; %Local IP，本机的IP
portA = 5000;%选择一个未被占用的端口，
ipB = '192.168.43.10';%需要去连接端的IP,注意最好从右至左的第二个数字即0，两个IP最好一致，使得网络处于同一网段
portB = 50001;
udpA = udp(ipB,'RemotePort',portB,'LocalPort',portA);%新建一个udp通信对象
set(udpA,'OutputBufferSize',8192);%设置OutputBufferSize
set(udpA,'TimeOut',10000);
fopen(udpA);%设备之间LAN通信连接
%fprintf('NOT Blank');
a1 =  fscanf(udpA);
display(class(a1));%查看接收到数据的类型
display(size(a1));%查看接收到数据的大小

fclose(udpA);
delete(udpA);
clear ipA portA ipB portB;
display(666)
