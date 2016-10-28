function draw_set_function(source, userdata, callbackdata)

[msfc,ws,ol,image_name,xlms,ylms] = msfcFunc();
xlm = get(gca,'xlim');
ylm = get(gca,'ylim');

save('output\limits.mat','xlm','ylm')
run draw_and_plot_Sets.m
