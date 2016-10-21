%% once you have finished drawing all fractures, then you need to delete 
%%% all lines that fit outside the bounding box. 

load('output\setsFile.mat')
load('output\windowLims.mat')

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
for i = 1:length(SN)
    hold on
    plot(SN{i}(:,1),SN{i}(:,2))
end
axis equal

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
axis equal    

prompt = 'Do the changes look good? Y/N'
ind = inputdlg(prompt)

if strcmp(ind,'Y')
    allSets = SN
    save('output\setsFile.mat','allSets')
end



%% if you deleted lines outside an inner bounding box, then you'll need to 
%%% get rid of them as:

runPOBB = 0
if runPOBB == 1
    count = 1;
    for i = 1:length(allSets)

        if size(allSets{i},1) ~= 0; 
            jnt{count} = allSets{i}; 
            count = count+1;
        end
    end

    figure()
    for i = 1:length(jnt)
        hold on
        plot(jnt{i}(:,1),jnt{i}(:,2))
    end

    prompt = 'Do the changes look good? Y/N'
    ind = inputdlg(prompt)

    if strcmp(ind,'Y')
        allSets = jnt
        save('output\setsFile.mat','allSets')
    end
end

%% if you want to ensure that all sets go from left to right, the uncomment 
%%% this section


% crack_arr = {}
% for i = 1:length(allSets)
%     crack = allSets{i}
%     if crack(1,1)>crack(end,1)
%         crack_arr{i} = crack(end:-1:1,:)
%     else
%         crack_arr{i} = crack
%     end
% end
% allSets = crack_arr
% save('output\setsFile.mat','allSets')
    


