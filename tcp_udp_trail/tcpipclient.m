%% �������Ӳ�����Ҫ���ӵĵ�ַΪ127.0.0.1(����������)���˿ں�Ϊ5174����Ϊ�ͻ������ӡ�
CServer=tcpip('192.168.43.10',5174,'Timeout', 200);
%% �������ӣ�������ɺ������һ�������򱨴�
fopen(CServer);%��һ���������������ӣ�ֱ��������ɷ��أ����򱨴�
%sprintf('�ɹ���������')
%% �����ַ�����pause��1��Ҫ��Ҫ������
textSend='66 77 99 88 -99as';
%pause(1);
fwrite(CServer,textSend);
%% �����ַ���,pause(1)Ҫ��Ҫ������,temp�����ս��
pause(1);
data_recv = fread(CServer,CServer.BytesAvailable)
%whos data_recv
%display(class(char(data_recv(4))))

temp = char(data_recv)
%recv = fscanf(Client,'%d',Client.BytesAvailable);
%temp='';
%for i=1:(length(data_recv)-1)
 %   temp=[temp,char(data_recv(i))]
%end

%recv=fscanf(Client);
%display(Client.ValuesReceived)
%temp='';
%for i=1:(length(recv)-1)
 %   temp=temp+recv(i);
%end
%temp
%% �رտͻ���
fclose(CServer);
display(777)
