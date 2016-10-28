function delete_line_function(source, userdata, callbackdata)

load('output\setsFile.mat')

prompt = 'Which line to delete?'
ind = inputdlg(prompt);
ind = str2num(ind{1});


if ind == length(allSets)
    for id = 1:ind-1
        SN{id} = allSets{id};
    end
    allSets = SN
    save('output\setsFile.mat','allSets','-append')
end

% if ind == (length(allSets)-1)
%     for id = 1:ind-1
%         SN{id} = allSets{id};
%     end
%     SN{id+1} = allSets(ind+1)
%     allSets = SN
%     save('output\setsFile.mat','allSets','-append')
% end

if ind < length(allSets)
    for id = 1:ind-1
        SN{id} = allSets{id};
    end
    for id = ind+1:length(allSets)
        SN{id-1} = allSets{id};
    end
    allSets = SN
    save('output\setsFile.mat','allSets','-append')
end


end

