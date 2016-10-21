function moveRight_button(source, callbackdata)
   
load('output\setsFile.mat')
ol = source.UserData.ol
msfc = source.UserData.msfc
ws = source.UserData.ws

xl2 = get(gca,'xlim')
yl2 = get(gca,'ylim')
xlim([xl2(2)-(ol/msfc) xl2(2)+((ws-ol)/msfc)])
ylim(yl2)
    