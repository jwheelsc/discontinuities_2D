load('output\setsFile.mat')
[msfc,ws,ol,image_name] = msfcFunc()


%% now loop through all angles

setNum = 'allSets'

%%% num_h is the number of scanlines per unit area


prompt = 'How many scanline per unit area?'
ind = inputdlg(prompt);
num_h = str2num(ind{1});

h = sqrt(area_xy*(scales.^2))/num_h
hS = num2str(num_h)

%%% here you can control the interval at which your angle changes in
%%% degreed, just make sure you dont land on 90 degrees.
intAng = 5
lowerA = 1
upperA = 176
thetaA = [lowerA:intAng:upperA];

slFig = figure('units','normalized','outerposition',[0 0 1 1])
for i = 1:length(allSets)
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','k-','linewidth',1);
end

for t = 1:length(thetaA)
    
    theta = thetaA(t)
    m_sl = tan(theta*pi/180); %slope in radians
    B = abs(h/sin((90-theta)*pi/180)); %this is the offset in y for lines a distance of h apart
    if theta < 90
        bf = (m_sl*minx)/B; %the scale factor for the first intercept that will keep the upper line in the box
        b_sl = maxy-(B*bf); %the first intercept
        max_l = floor((miny-(m_sl*maxx)-maxy)/-B)-ceil(bf); % the number of lines that will be in the box
    else 
        bf = (miny-(m_sl*minx))/B;
        b_sl = B*bf;
        max_l = floor((maxy-(m_sl*maxx))/B)-ceil(bf);
    end

    min_x_line = 0;

    set_int = {};
    line_length = [];

    xlim([minx maxx])
    ylim([miny maxy])

    
    if theta < 90
        
        for l = 1:max_l

            b_sl = b_sl-B;
            
            %%%this is for plottting the scanline
            min_x_line = (miny-b_sl)/m_sl;
            
            pa = [(maxy-b_sl)/m_sl,maxy];
            pb = [maxx,m_sl*maxx+b_sl];
            pc = [minx, m_sl*minx+b_sl];
            pd = [(miny-b_sl)/m_sl,miny];
            pA = [pa;pb;pc;pd];
            [ps,pind] = sort(pA(:,1));
            p1 = pA(pind(2),:);
            p2 = pA(pind(3),:);
            
            line_length(l) = sqrt(sum((p2-p1).^2));
                
            hold on
            plot([p1(1) p2(1)],[p1(2) p2(2)],'m-')
            
            %%% this is for finding the intersection
            int_point = [];
            for ji = 1:length(allSets)
                
                js = allSets{ji};
                y = js(:,2);
                x = js(:,1);
                m_j = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1));
 
                m_j(isnan(m_j))=0;
                m_j(isinf(m_j))=1e4;
                b_j = y(2:end)-(m_j.*x(2:end));
                
                xi = (b_j-b_sl)./(m_sl-m_j);
                xi(isnan(xi))=0;
                xi(isinf(xi))=0;
                yi = m_sl.*xi+b_sl;
                yi(isnan(yi))=0;
                yi(isinf(yi))=0;
                
                d1 = sqrt((xi-x(1:end-1)).^2+(yi-y(1:end-1)).^2);
                d2 = sqrt((xi-x(2:end)).^2+(yi-y(2:end)).^2);
                d3 = sqrt((x(1:end-1)-x(2:end)).^2+(y(1:end-1)-y(2:end)).^2);
                inBox = logical((d1<d3).*(d2<d3));
                int_point = [int_point;[xi(inBox),yi(inBox)]];
                
            end
            set_int{end+1}= int_point;
            hold on
            plot(int_point(:,1),int_point(:,2),'bo')
        end
    end

    min_y_line = 0;
    if theta > 90
        for l = 1:max_l

            b_sl = b_sl+B;

            min_y_line = m_sl*maxx+b_sl;
           
            pa = [(maxy-b_sl)/m_sl,maxy];
            pb = [maxx,m_sl*maxx+b_sl];
            pc = [minx, m_sl*minx+b_sl];
            pd = [(miny-b_sl)/m_sl,miny];
            pA = [pa;pb;pc;pd];
            [ps,pind] = sort(pA(:,1));
            p1 = pA(pind(2),:);
            p2 = pA(pind(3),:);
            
            line_length(l) = sqrt(sum((p2-p1).^2));

            hold on
            plot([p1(1) p2(1)],[p1(2) p2(2)],'m-')
           %%% this is for finding the intersection
            int_point = [];
            for ji = 1:length(allSets)
                
                js = allSets{ji};
                y = js(:,2);
                x = js(:,1);
                m_j = (y(2:end)-y(1:end-1))./(x(2:end)-x(1:end-1));
 
                m_j(isnan(m_j))=0;
                m_j(isinf(m_j))=1e4;
                b_j = y(2:end)-(m_j.*x(2:end));
                
                xi = (b_j-b_sl)./(m_sl-m_j);
                xi(isnan(xi))=0;
                xi(isinf(xi))=0;
                yi = m_sl.*xi+b_sl;
                yi(isnan(yi))=0;
                yi(isinf(yi))=0;
                
                d1 = sqrt((xi-x(1:end-1)).^2+(yi-y(1:end-1)).^2);
                d2 = sqrt((xi-x(2:end)).^2+(yi-y(2:end)).^2);
                d3 = sqrt((x(1:end-1)-x(2:end)).^2+(y(1:end-1)-y(2:end)).^2);
                inBox = logical((d1<d3).*(d2<d3));
                int_point = [int_point;[xi(inBox),yi(inBox)]];
                
            end
            set_int{end+1}= int_point;
            hold on
            plot(int_point(:,1),int_point(:,2),'bo')
        end
    end

    %%% the code will run a lot faster if the following is commented out
    pause(0.5)

    axis equal
    save(['output/sl_pts_' num2str(theta) '_' setNum '_' hS '.mat'], 'set_int', 'line_length')

end






















