function redo_line_function(source, callbackdata)

load('output\setsFile.mat')

prompt = 'Which line to redo?'
ind = inputdlg(prompt)
ind = str2num(ind{1})

h = imfreehand
lin = h.getPosition
if length(lin(:,1))==0
    return
end
if lin(1,1)>lin(end,1)
    lin = lin(end:-1:1,:)
end

allSets{ind}= lin(:,:)
save('output\setsFile.mat','-append')

end

