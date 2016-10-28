function moveDown_button(source, userdata, callbackdata)
   
load('output\setsFile.mat')

[msfc,ws,ol,image_name,xlms,ylms] = msfcFunc();
xl2 = get(gca,'xlim');
yl2 = get(gca,'ylim');

ylim([yl2(2)-(ol/msfc) yl2(2)+((ws-ol)/msfc)])
xlim(xl2)
    