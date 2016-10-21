%% if you want to inititate a set, then do the following...BUT BE CAREFUL NOT TO DELETE
%%% these sets should be saved in source control

close all
clear all
%%
RUNTHIS = 'no'

if strcmp(RUNTHIS,'YES')
    allSets = []
    save('output\setsFile.mat','allSets')
end

%%

load('output\setsFile.mat')
[msfc,ws,ol,image_name] = msfcFunc()
imshow(image_name)

%%% do you know what your limits should be?
plotLims = 1
if plotLims == 1
    xlms=[2622 3842];
    ylms=[1882 3697];
    xlim(xlms);
    ylim(ylms);
elseif plotLims == 0
    xlms = get(gca,'xlim')
    ylms = get(gca,'ylim')
end

lxl = xlms(1);
uxl = xlms(2);
lyl = ylms(1);
uyl = ylms(2);

save('output\windowLims.mat','lxl','uxl','lyl','uyl')

%%% do you want to plot the bounding box of your sampling window?
plotRedWindow = 0
if plotRedWindow == 1
    hold on
    plot([lxl lxl],[lyl uyl],'r-','linewidth',2)
    hold on
    plot([uxl uxl],[lyl uyl],'r-','linewidth',2)
    hold on
    plot([lxl uxl],[lyl lyl],'r-','linewidth',2)
    hold on
    plot([lxl uxl],[uyl uyl],'r-','linewidth',2)
end

%% plot the sets

%%% do you want to plot all the lines or just some? and do you want text or
%%% no?

% for i = round(length(allSets)*0.5):length(allSets)
for i = 1:length(allSets)
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','b','linewidth',1);
    ely = find(p(:,2)==max(p(:,2)));
    ely = ely(end);
%     text(p(ely,1),p(ely,2),num2str(i),'fontsize',9,'color', 'k');
end

%%% find the traces that are XTR times the window size
longTraces = 0
if longTraces == 1
    traceL = getLineLength(allSets)
    rtl = traceL*msfc
    XTR = 4/5
    el = find(rtl>(ws*XTR))
    
    for i = 1:length(el)
        hold on
        p = allSets{el(i)};
        ph(i)=plot(p(:,1)',p(:,2)','r','linewidth',1);
        ely = find(p(:,2)==max(p(:,2)));
        ely = ely(end);
        text(p(ely,1),p(ely,2),num2str(el(i)),'fontsize',9,'color', 'k');
    end

end
%% here is where the buttons start to pop up.

xlm = get(gca,'xlim')
ylm = get(gca,'ylim')

popup = uicontrol('Style', 'pushbutton',...
   'String', 'create line',...
   'Position', [1100 535 80 50],...
   'Callback', @draw_line_function); 

popup = uicontrol('Style', 'pushbutton',...
   'String', 'break line',...
   'Position', [1100 500 80 30],...
   'Callback', @break_loop_function); 

popup = uicontrol('Style', 'pushbutton',...
   'String', 'redo line',...
   'Position', [1100 400 80 50],...
   'Callback', @redo_line_function); 

popup = uicontrol('Style', 'pushbutton',...
   'String', 'append line',...
   'Position', [1100 300 80 50],...
   'Callback', @append_line_function); 

btn = uicontrol('Style', 'pushbutton', 'String', 'top left',...
    'Position', [1150 175 80 30],...
    'UserData', struct('xl',xlm,'yl',ylm,'ol',ol,'ws',ws,'msfc',msfc),...
    'Callback', @topLeft_button); 

btn = uicontrol('Style', 'pushbutton', 'String', 'move right',...
    'Position', [1100 175 80 30],...
    'UserData', struct('xl',xlm,'yl',ylm,'ol',ol,'ws',ws,'msfc',msfc),...
    'Callback', @moveRight_button); 

btn = uicontrol('Style', 'pushbutton', 'String', 'move down',...
    'Position', [1100 137.5 80 30],...
    'UserData', struct('xl',xlm,'yl',ylm,'ol',ol,'ws',ws,'msfc',msfc),...
    'Callback', @moveDown_button); 

popup = uicontrol('Style', 'popup',...
   'String', {'FULL IMAGE','top left',...
   'move left','move right','move up','move down'},...
   'Position', [1100 200 80 50],...
   'UserData', struct('xl',xlm,'yl',ylm,'ol',ol,'ws',ws,'msfc',msfc),...
   'Callback', @window_function); 

btn = uicontrol('Style', 'pushbutton',...
        'String', 'Draw set',...
        'Position', [1100 90 80 30],...
        'Callback', @draw_set_function);

btn = uicontrol('Style', 'pushbutton',...
        'String', 'return window',...
        'Position', [1100 90-37.5 80 30],...
        'Callback', @lastWindow_function);







