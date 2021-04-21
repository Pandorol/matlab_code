function [ Sample,Label ] = OutSample(label_1,label_2)

echo off all;
Path = '.\samples\';
File = dir(fullfile(Path,'*.txt'));
FileNames = {File.name};
FileNamesSize = size(FileNames);
%%%��Ҫ�ָ�����Ĳ����ʵ����ü���ǩ������%%%
SamplingRate = 3000;
SamplingLabel=[label_1 label_2];%%��ȭ1��̯��3������7������6
%%%��Ҫ�ָ�����Ĳ����ʵ����ü���ǩ������%%%
Sample=[];
Label=[];
SampleCount = 0;
for i=1:FileNamesSize(2)
    index = ['.\samples\',FileNames{i}];
    data=importdata(index);
    data=data';
    ChannelsSize = size(data);
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
Label = Label';
clearvars -except Sample Label 
%%%�õ���Sample ��һ��ά���������ڶ���ά����������е�ͨ������������ά��ÿ��ͨ���ɼ������ź�%%
%%Label�����ݵı�ǩ%%


end

