function append_line_function(source, callbackdata)

load('output\setsFile.mat')

prompt = 'which line to append?'
ind = inputdlg(prompt)
ind = str2num(ind{1})

h1 = imfreehand;
h0 = allSets{ind};
lin = h1.getPosition;
if lin(1,1)>lin(end,1)
    lin = lin(end:-1:1,:);
end

l1 = lin(1,:)
l2 = lin(end,:)
h1 = h0(1,:)
h2 = h0(end,:)

d1 = sqrt(sum((l1-h1).^2))
d2 = sqrt(sum((l1-h2).^2))
d3 = sqrt(sum((l2-h1).^2))
d4 = sqrt(sum((l2-h2).^2))

d = [d1,d2,d3,d4]
minEl = find(d==(min(d)))
if minEl==1
    tl = [lin(end:-1:1,:);h0]
    if tl(1,1)>tl(end,1)
        tl = tl(end:-1:1,:)
    end
    allSets{ind} = tl;
elseif minEl==2
    allSets{ind} = [h0;lin]
elseif minEl==3
    allSets{ind} = [lin;h0]
elseif minEl==4
    tl = [lin;h0(end:-1:1,:)]
    if tl(1,1)>tl(end,1)
        tl = tl(end:-1:1,:)
    end
    allSets{ind} = tl;
end

save('output\setsFile.mat','allSets','-append')

