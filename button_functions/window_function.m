function window_function(source, callbackdata)
%DRAW_LINE_FUNCTION Summary of this function goes here
%   Detailed explanation goes here

load('output\setsFile.mat')
ol = source.UserData.ol
msfc = source.UserData.msfc
ws = source.UserData.ws

val = source.Value
source.String(val)

xlm = source.UserData.xl
ylm = source.UserData.yl

if strcmp(source.String(val),'FULL IMAGE')
    load('output/fullLims.mat')
    xlim(fullXlim)
    ylim(fullYlim)
       
elseif strcmp(source.String(val),'FULL WINDOW')
    xlim(xlm)
    ylim(ylm)

elseif strcmp(source.String(val),'top left')

    xlim([xlm(1) xlm(1)+(ws/msfc)])
    ylim([ylm(1) ylm(1)+(ws/msfc)])
    
elseif strcmp(source.String(val),'move right')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(2)-(ol/msfc) xl2(2)+((ws-ol)/msfc)])
    ylim([yl2(1) yl2(2)])
    
elseif strcmp(source.String(val),'move left')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    xlim([xl2(1)-((ws-ol)/msfc) xl2(1)+(ol/msfc)])
    ylim([yl2(1) yl2(2)])
    
elseif strcmp(source.String(val),'move down')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(2)-(ol/msfc) yl2(2)+((ws-ol)/msfc)])
    xlim([xl2(1) xl2(2)])
    
elseif strcmp(source.String(val),'move up')
    
    xl2 = get(gca,'xlim')
    yl2 = get(gca,'ylim')
    ylim([yl2(1)-((ws-ol)/msfc) yl2(1)+(ol/msfc)])
    xlim([xl2(1) xl2(2)])
    
end

end

