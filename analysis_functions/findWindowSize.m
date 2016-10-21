%% this script finds the edges of the joints and then finds the size of the window
mnx = [];
mny = [];
mxx = [];
mxy = [];
for i = 1:length(allSets)
    lin = allSets{i};
    mnx(i) = min(lin(:,1));
    mny(i) = min(lin(:,2));
    mxx(i) = max(lin(:,1));
    mxy(i) = max(lin(:,2));
end 
miny = min(mny);
maxy = max(mxy);
minx = min(mnx);
maxx = max(mxx);


xlim([minx maxx]);
ylim([miny maxy]);

scales = 1/(msfc);
length_x = (maxx-minx)/(scales);
length_y = (maxy-miny)/(scales);
area_xy = (length_x*length_y);

save(['output/results.mat'],'length_x','length_y','area_xy')
