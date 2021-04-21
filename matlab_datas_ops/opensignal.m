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

[A,f,tt] = hhspectrum(imf);%imf���������ֱ����ϣ�����ر任��Ȼ��ֱ���fft���˴���f�ǹ�һ����Ƶ��
[E,t,Cenf]=toimage(A,f);%�ϳ�HHT��ͼ����������ͼ��
disp_hhs(E);%����HHT��ͼ