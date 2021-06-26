function [files] = ALLfile(inputdir)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
files=cell(0);
dirs = dir(inputdir);
for i=1:length(dirs)
    if strcmp(dirs(i).name,'.')==1||strcmp(dirs(i).name,'..')==1
        continue;
    else
        if(dirs(i).isdir==1)
            files=[files;ALLfile([dirs(i).folder,'\',dirs(i).name])];
        else
            files = [files;[dirs(i).folder,'\',dirs(i).name]];
        end
    end
end

end

