clearvars -except Sample Label
for i=1:length(Label)
    if Label(i)==0
        Label(i) = [];
        Sample(i,:,:) = [];
    end
end