clear all;
Path = 'D:\CWorkSpace\matlab\samples\';
File = dir(fullfile(Path,'*.txt'));
FileNames = {File.name};
FileNamesSize = size(FileNames);
%%%需要分割出来的采样率的设置及标签的设置%%%
SamplingRate = 2000;
SamplingLabel=[1 3];%%握拳1，摊开3，连续7，半握6%%0无动作，1右，2左
%%%需要分割出来的采样率的设置及标签的设置%%%
Sample=[];
Label=[];
SampleCount = 0;
for i=1:FileNamesSize(2)
    index = [Path,FileNames{i}];
    data=importdata(index);
    data=data';
    ChannelsSize = size(data);
    %%%去5通道里的f3,f4%%%
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
%%%得到的Sample 第一个维度样本，第二个维度这个样本有的通道数，第三个维度每个通道采集到的信号%%
%%Label是数据的标签%%
%%%写出文件outone.txt
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
