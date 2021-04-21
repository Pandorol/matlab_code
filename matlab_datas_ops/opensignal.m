clear all;
Path = 'D:\CWorkSpace\matlab\open_signals\';
File = dir(fullfile(Path,'*.txt'));
FileNames = {File.name};
for i=1:length(FileNames)
    index = [Path,FileNames{i}];
    data=importdata(index);
    data=data';
end
y = data(1,3001:6000);
t=1:length(y);
imf = emd(y);
%emd_visu(y,t,imf);

[A,f,tt] = hhspectrum(imf);%imf各个分量分别进行希尔伯特变换，然后分别做fft，此处的f是归一化的频率
[E,t,Cenf]=toimage(A,f);%合成HHT谱图（类似语谱图）
disp_hhs(E);%绘制HHT谱图