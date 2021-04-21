clearvars -except SampleFeature Label 
fileName = 'out.xlsx';
data = [];
Samplesize=size(SampleFeature)
j=0;
for i=1:Samplesize(1)
    j=j+1;
    if(j==31)
        j=0;
        split = zeros(5,13);
        data=[data;split];
    end
    data2 = SampleFeature(i,:,:);
    data2 = squeeze(data2);
    data=[data;data2];
    split = zeros(1,13);
    data=[data;split];
end
xlswrite('out.xlsx',data);

%{

fid = fopen('outexcel.xlsx','w');


for i=1:fidsize(1)
    S1=SampleFeature(i,:,:);
    S1 = squeeze(S1)';
    xlswrite(filename,S1);
end
fclose(fid);
%}
