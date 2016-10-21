function draw_set_function(source, callbackdata)

xlm = get(gca,'xlim')
ylm = get(gca,'ylim')

save('output\limits.mat','xlm','ylm')
run draw_and_plot_Sets.m
