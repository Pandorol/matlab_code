clear all;
echo off all;
t_server=tcpip('0.0.0.0',50001,'NetworkRole','server');
%与第一个请求连接的客户机建立连接，端口号为30000，类型为服务器。
t_server.InputBuffersize=100000;
t_server.OutputBuffersize=1000;
WinSize = 2000;
SelectedChannels = [5 6 18 33];

%SelectedChannelsSize=size(SelectedChannels);
Windata = [];
Windata_start=1;
%%Windata=zeros(SelectedChannelsSize(2),WinSize);

fopen(t_server);%打开服务器，直到建立一个TCP连接才返回；
%textSend='66 77 99 88 -99as';
%pause(1);
%fwrite(t_server,textSend);
%get(t_server);
%pause(1);



while(1)
    if t_server.BytesAvailable>0
        data_recv=fread(t_server,t_server.BytesAvailable,'char');
        %display(data_recv)
        %break;
        for i = 1:numel(data_recv)/2
            c(i)=typecast(uint8([data_recv(i*2-1),data_recv(i*2)]),'int16');
        end
        c=reshape(c,33,[]);
        c=c(SelectedChannels,:);
        csize = size(c);
        if csize(2)>WinSize
            Windata(:,1:WinSize) = c(:,csize(2)-WinSize+1:csize(2));
            Windata_start =1;
        elseif Windata_start+csize(2)-1>WinSize
                c_start = 1;
                data_num = WinSize-Windata_start+1;
                c_end = data_num;
                Windata(:,Windata_start:WinSize) = c(:,c_start:c_end);
                Windata_start = 1;
                c_start = c_end+1;
                c_end = csize(2);
                data_num = csize(2)-data_num;
                Windata(:,Windata_start:Windata_start+data_num-1) = c(:,c_start:c_end);
                Windata_start = Windata_start+data_num;
        else
            Windata(:,Windata_start:Windata_start+csize(2)-1) = c;
            Windata_start = Windata_start+csize(2);
            if(Windata_start>=WinSize)
                Windata_start = 1;
            end
        end
        output = WindataToClassify(Windata,Windata_start);
        fwrite(t_server,output);
        clear data_recv
        clear c
    end
end
fclose(t_server);
%output = WindataToClassify(Windata,Windata_start);
%{
for i = 1:numel(data_recv)/2
    c(i)=typecast(uint8([data_recv(i*2-1),data_recv(i*2)]),'int16')
end
%}
%pause(1);typecast(uint8([data_recv(5),data_recv(6)]),'int16')
%pause(1)
%data_recv=fread(t_server,t_server.BytesAvailable,'char')
%display(data_recv)
%{
while(i<5)
    pause(1);
    data_recv=fread(t_server,t_server.BytesAvailable,'char');%从缓冲区读取数字数据
    %data_recv2 = fscanf(t_server);
        display(data_recv);

    i=i+1;
end
%}

%recv = (short)data_recv


