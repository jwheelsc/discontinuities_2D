%% if you want to inititate a set, then do the following...BUT BE CAREFUL NOT TO DELETE
%%% these sets should be saved in source control

close all
clear all
%%


ls1 = ls('output')
ls2 = cellstr(ls1)
ls3 = strcmp(ls2,'setsFile.mat')

if sum(ls3)<1
    allSets = []
    save('output\setsFile.mat','allSets')
end

%%

load('output\setsFile.mat');
[msfc,ws,ol,image_name,xlms,ylms] = msfcFunc();
imshow(image_name)
fullXlim = get(gca,'xlim');
fullYlim = get(gca,'ylim');
save('output/fullLims.mat','fullXlim','fullYlim')


if isempty(xlms)    
    xlms = get(gca,'xlim');
    ylms = get(gca,'ylim');
else
    xlim(xlms);
    ylim(ylms);
end

lxl = xlms(1);
uxl = xlms(2);
lyl = ylms(1);
uyl = ylms(2);

save('output\windowLims.mat','lxl','uxl','lyl','uyl')

%%% do you want to plot the bounding box of your sampling window?
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

%% plot the sets

%%% do you want to plot all the lines or just some? and do you want text or
%%% no?

traceColor = 'b'
textColor = 'r'
textSize = 10

%%% TRACE ONLY A PORTION?
% for i = round(length(allSets)*0.5):length(allSets)
%%% TRACE ALL?
for i = 1:length(allSets)
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)',traceColor,'linewidth',1);
    elyt = find(p(:,2)==max(p(:,2)));
    elyt = elyt(end);
    %%% LINE NUMBERS at highest y
    text(p(elyt,1),p(elyt,2),num2str(i),'fontsize',textSize,'color', textColor);
    elyb = find(p(:,2)==min(p(:,2)));
    elyb = elyb(end);
    %%% LINE NUMBERS at lowest y
    text(p(elyb,1),p(elyb,2),num2str(i),'fontsize',textSize,'color', textColor);
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



set(0,'units','pixels')  
%Obtains this pixel information
Pix_SS = get(0,'screensize');

%%% here is the x ofset for the pushbottons, which will depend on your
%%% screen size, so you'll have to play around with it.
xButLoc = Pix_SS(3)*(9/10);

popup = uicontrol('Style', 'pushbutton',...
   'String', 'create trace',...
   'Position', [xButLoc 535 80 50],...
   'Callback', @draw_line_function); 

popup = uicontrol('Style', 'pushbutton',...
   'String', 'stop tracing',...
   'Position', [xButLoc 500 80 30],...
   'Callback', @break_loop_function); 

popup = uicontrol('Style', 'pushbutton',...
   'String', 'delete line',...
   'Position', [xButLoc 400 80 50],...
   'Callback', @delete_line_function); 

popup = uicontrol('Style', 'pushbutton',...
   'String', 'append line',...
   'Position', [xButLoc 312.5 80 50],...
   'Callback', @append_line_function); 

btn = uicontrol('Style', 'pushbutton', 'String', 'top left',...
    'Position', [xButLoc 210 80 30],...
    'Callback', @topLeft_button); 

btn = uicontrol('Style', 'pushbutton', 'String', 'move right',...
    'Position', [xButLoc 175 80 30],...
    'Callback', @moveRight_button); 

btn = uicontrol('Style', 'pushbutton', 'String', 'move down',...
    'Position', [xButLoc 137.5 80 30],...
    'Callback', @moveDown_button); 

popup = uicontrol('Style', 'popup',...
   'String', {'FULL IMAGE','FULL WINDOW','top left',...
   'move left','move right','move up','move down'},...
   'Position', [xButLoc 240 80 50],...
   'Callback', @window_function); 

btn = uicontrol('Style', 'pushbutton',...
        'String', 'draw set',...
        'Position', [xButLoc 90 80 30],...
        'Callback', @draw_set_function);

btn = uicontrol('Style', 'pushbutton',...
        'String', 'return window',...
        'Position', [xButLoc 90-37.5 80 30],...
        'Callback', @lastWindow_function);







