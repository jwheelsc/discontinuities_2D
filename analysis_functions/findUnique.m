%%% this is a function called on from densify_lines, so that I can run
%%% multiple iterations of finding the points of overlap

function [jset] = findUnique(jset)

    ys = jset(:,2);
    xs = jset(:,1);
    x_list = 0;
    for i = 2:length(xs)-1

        if xs(i-1)==xs(i)

            x_list(end+1) = i;

        end    

    end
    x_list = x_list(2:end);

    y_list = 0;
    for i = 2:length(ys)-1

        if ys(i-1)==ys(i)

            y_list(end+1) = i;

        end    

    end
    
    y_list = y_list(2:end);
    e_list = sort([x_list,y_list]);
    e_list = unique(e_list);

    jset(e_list,:) = [];
    jset(end-1,:) = [];

