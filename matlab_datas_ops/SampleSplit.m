clearvars -except Sample Label 
%Sample_2 = [];
%Label_2 = [];
%Label_2=Label;
%Label_2=[Label;Label];
%Sample_2=[Sample(:,:,1:2990);Sample(:,:,2991:5980)];
for i=1:length(Label)
    if Label(i)~=0
        Label(i) = 3;
    end
end
%Label = Label;
%Sample = Sample;



