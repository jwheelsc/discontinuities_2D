%% once you have finished drawing all fractures, then you need to delete 
%%% all lines that fit outside the bounding box. 

load('output\setsFile.mat')
load('output\windowLims.mat')
close all
%% delete points outside the bounding box
% clear all

%% get rid of all 1 line points
count = 1
for i = 1:length(allSets)
    a = allSets{i};
    if length(a(:,1))>1
        allSets2{count} = a;
        count = count+1;
    end
end

%%
SN = allSets2

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,1,1)

[msfc,ws,ol,image_name,xlms,ylms] = msfcFunc();

lxl = xlms(1);
uxl = xlms(2);
lyl = ylms(1);
uyl = ylms(2);

if isempty(xlms) == 0
    hold on
    plot([lxl lxl],[lyl uyl],'r-','linewidth',2)
    hold on
    plot([uxl uxl],[lyl uyl],'r-','linewidth',2)
    hold on
    plot([lxl uxl],[lyl lyl],'r-','linewidth',2)
    hold on
    plot([lxl uxl],[uyl uyl],'r-','linewidth',2)
end


for i = 1:length(SN)
    hold on
    plot(SN{i}(:,1),SN{i}(:,2))
end
set(gca,'Ydir','reverse')
axis equal
ylW = get(gca,'ylim')
xlW = get(gca,'xlim')
title('Before clipping traces')

for i = 1:length(SN)
    jnt = SN{i};
    jnt = jnt(jnt(:,1)>lxl,:);
    SN{i} = jnt;
end

for i = 1:length(SN)
    jnt = SN{i};
    jnt = jnt(jnt(:,1)<uxl,:);
    SN{i} = jnt;
end

for i = 1:length(SN)
    jnt = SN{i};
    jnt = jnt(jnt(:,2)>lyl,:);
    SN{i} = jnt;
end

for i = 1:length(SN)
    jnt = SN{i};
    jnt = jnt(jnt(:,2)<uyl,:);
    SN{i} = jnt;
end


subplot(2,1,2)
for i = 1:length(SN)
    hold on
    plot(SN{i}(:,1),SN{i}(:,2))
end

if isempty(xlms) == 0
    hold on
    plot([lxl lxl],[lyl uyl],'r-','linewidth',2)
    hold on
    plot([uxl uxl],[lyl uyl],'r-','linewidth',2)
    hold on
    plot([lxl uxl],[lyl lyl],'r-','linewidth',2)
    hold on
    plot([lxl uxl],[uyl uyl],'r-','linewidth',2)
end
xlim(xlW)
ylim(ylW)
set(gca,'Ydir','reverse')
title('After clipping traces')

prompt = 'Do the changes look good? Y/N'
ind = inputdlg(prompt)

if strcmp(ind,'Y')
    allSets = SN
    save('output\setsFile.mat','allSets')
end



%% if you deleted lines outside an inner bounding box, then you'll need to 
%%% get rid of them as:

prompt = 'Did you delete lines outside the window? Y/N'
ind = inputdlg(prompt)

if strcmp(ind,'Y')
    jnt = {}
    count = 1
    for i = 1:length(allSets)

        if size(allSets{i},1) ~= 0
            jnt{count} = allSets{i}
            count = count+1;
        end
    end
    allSets = jnt
    save('output\setsFile.mat','allSets')

end



