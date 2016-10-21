function moveDown_button(source, callbackdata)
   
load('output\setsFile.mat')
ol = source.UserData.ol
msfc = source.UserData.msfc
ws = source.UserData.ws

xl2 = get(gca,'xlim')
yl2 = get(gca,'ylim')
ylim([yl2(2)-(ol/msfc) yl2(2)+((ws-ol)/msfc)])
xlim(xl2)
    