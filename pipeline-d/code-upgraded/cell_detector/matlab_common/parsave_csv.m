function [] = parsave_csv(savename, detection)
disp(['V1V2V3 Saving to ' savename]);
M = {'V1', 'V2', 'V3'};
M(2:size(detection, 1)+1,1)= {'None'};
M(2:size(detection, 1)+1,2:3)= num2cell(detection);
cell2csv(savename, M);

end