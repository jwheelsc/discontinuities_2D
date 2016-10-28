close all
clear variables

[msfc,ws,ol,image_name,xlms,ylms] = msfcFunc();

ls1 = ls('output')
ls2 = cellstr(ls1)
ls3 = strcmp(ls2,'results.mat')

if sum(ls3)<1
    save('output/results.mat')
end

load('output\setsFile.mat')

%% here is where the scripts are run

run findWindowSize
run windowEdges
run sets_stats.m
run analyze_sets_intersections.m
run analyze_sets.m
run computeFrequency.m

%% and the data is output

load('output/results')

h = msgbox({'RESULTS',...
    ['The max frequency is ' num2str(mxy) ' m^-1']...
    ['The min frequency = ' num2str(mny) ' m^-1']...
    ['The mean frequency (P10) = ' num2str(mean_fq) ' m^-1']...
    ['The average joint length = ' num2str(mean_l) ' m']...
    ['There are ' num2str(num_joints) ' joints']...
    ['The total joint length = ' num2str(sum_length) ' m']...
    ['There are ' num2str(totalints) ' intersections']...
    ['The length in x = ' num2str(length_x) ' m']...
    ['The length in y = ' num2str(length_y) ' m']...
    ['The area = ' num2str(area_xy) ' m^2'],...
    ['The P20 = ' num2str(num_joints/area_xy) ' m^-2'],...
    ['The P21 = ' num2str(sum_length/area_xy) ' m^-1'],...
    ['The I20 = ' num2str(totalints/area_xy) ' m^-2'],...
    [num2str(etf(5)) ' % of your traces touch the window edge']})
ah = get( h, 'CurrentAxes' );
ch = get( ah, 'Children' );
set( ch, 'FontSize', 14 );
set(h, 'position', [500 440 400 400]); %makes box bigger