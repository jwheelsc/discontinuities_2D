function topLeft_button(source, userdata, callbackdata)
   
load('output\setsFile.mat')

[msfc,ws,ol,image_name,xlms,ylms] = msfcFunc();
xlm = xlms;
ylm = ylms;

xlim([xlm(1) xlm(1)+(ws/msfc)])
ylim([ylm(1) ylm(1)+(ws/msfc)])
    