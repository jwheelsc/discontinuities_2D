close all

[msfc,ws,ol,image_name] = msfcFunc()

imshow(image_name)

h = msgbox(['once you have clicked OK and zoomed in, press F5, or continue running script'])
keyboard
l1 = ginput(1)
% keyboard
l2 = ginput(1)

diff = l2-l1
d =  sqrt((diff(1).^2)+(diff(2).^2))

prompt = 'How many meters is that?'
ind = inputdlg(prompt)
ind = str2num(ind{1})
scale = d/ind
h = msgbox(['there are ' num2str(scale) ' pixels per meter'])
