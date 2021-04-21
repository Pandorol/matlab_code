clear all;
Path = 'D:\CWorkSpace\matlab\samples\';
File = dir(fullfile(Path,'*.txt'));
FileNames = {File.name};
FileNamesSize = size(FileNames);
%%%��Ҫ�ָ�����Ĳ����ʵ����ü���ǩ������%%%
SamplingRate = 2000;
SamplingLabel=[1 3];%%��ȭ1��̯��3������7������6%%0�޶�����1�ң�2��
%%%��Ҫ�ָ�����Ĳ����ʵ����ü���ǩ������%%%
Sample=[];
Label=[];
SampleCount = 0;
for i=1:FileNamesSize(2)
    index = [Path,FileNames{i}];
    data=importdata(index);
    data=data';
    ChannelsSize = size(data);
    %%%ȥ5ͨ�����f3,f4%%%
    if ChannelsSize>4
        data(1:2,:)=[];
        ChannelsSize = size(data);
    end
    %%%
    label1 = data(ChannelsSize(1),1);
    label1_start = 1;
    for j=1:ChannelsSize(2)
        label2 = data(ChannelsSize(1),j);
        if label1~=label2
            if ismember(label1,SamplingLabel)
                label1_end = j-1;
                label1_nums = label1_end-label1_start+1;
                if label1_nums>SamplingRate
                    label1_start = label1_end-SamplingRate+1;
                end
                SampleCount=SampleCount+1;
                Sample(SampleCount,:,:) = data(1:ChannelsSize(1)-1,label1_start:label1_end);
                Label=[Label label1];
            end
            label1=label2;
            label1_start = j;
        end
    end
    if ismember(label1,SamplingLabel)
        label1_end = j-1;
        label1_nums = label1_end-label1_start+1;
        if label1_nums>SamplingRate
            label1_start = label1_end-SamplingRate+1;
        end
        SampleCount=SampleCount+1;
        Sample(SampleCount,:,:) = data(1:ChannelsSize(1)-1,label1_start:label1_end);
        Label=[Label label1];
    end
end

Label = Label';
clearvars -except Sample Label 
%%%�õ���Sample ��һ��ά���������ڶ���ά����������е�ͨ������������ά��ÿ��ͨ���ɼ������ź�%%
%%Label�����ݵı�ǩ%%
%%%д���ļ�outone.txt
%{
fidsize=size(Sample);
fid = fopen('outone.txt','w');
labelcount=1;
for i=1:fidsize(2)
    for j=1:fidsize(1)
        fprintf(fid,' %d',Sample(j,i,:));
    end
    fprintf(fid,'\r\n');
end
for i=1:fidsize(1)
    for j=1:fidsize(3)
        fprintf(fid,' %d',Label(labelcount));
    end
    labelcount=labelcount+1;
end
fclose(fid);
%}
