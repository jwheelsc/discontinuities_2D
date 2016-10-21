function [msfc,ws,ol,image_name] = msfcFunc()

%enter your value in pixels per meter here:
pxpm= 190

msfc = 1/pxpm
%enter the size of your subwindow for tracing in meters
ws = 2

% what fraction of the window size do you want to have overlap on 
% each side?
ol = (1/8)*ws

% what is the name of your image
image_name = 'IMG_1259.JPG'