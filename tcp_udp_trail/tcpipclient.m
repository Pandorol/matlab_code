%% 设置连接参数，要连接的地址为127.0.0.1(即本地主机)，端口号为5174，作为客户机连接。
CServer=tcpip('192.168.43.10',5174,'Timeout', 200);
%% 建立连接，建立完成后进行下一步，否则报错
fopen(CServer);%与一个服务器建立连接，直到建立完成返回，否则报错。
%sprintf('成功建立连接')
%% 发送字符串，pause（1）要不要都可以
textSend='66 77 99 88 -99as';
%pause(1);
fwrite(CServer,textSend);
%% 接收字符串,pause(1)要不要都可以,temp是最终结果
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
%% 关闭客户端
fclose(CServer);
display(777)
