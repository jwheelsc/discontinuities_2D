
intFig = figure('units','normalized','outerposition',[0 0 1 1])
for i = 1:length(allSets)
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','k','linewidth',1);
end
        
    

%% how much does a set intersect itself?
intPts = [];
diffA = [];
count = 1
for i1 = 1:length(allSets)-1
    j1 = allSets{i1};
    j1x = j1(:,1);
    j1y = j1(:,2);
    
    m1 = (j1y(2:end)-j1y(1:end-1))./((j1x(2:end)-j1x(1:end-1)));
    m1(isinf(m1)) = 1e3;
    m1(isnan(m1)) = 0;
    b1 = j1y(2:end)-(j1x(2:end).*m1);
    l1 = length(b1);

    for i2 = i1+1:length(allSets)
        j2 = allSets{i2};
        j2x = j2(:,1);
        j2y = j2(:,2);   
        
        m2 = (j2y(2:end)-j2y(1:end-1))./((j2x(2:end)-j2x(1:end-1)));
        m2(isinf(m2)) = 1e3;
        m2(isnan(m2)) = 0;
        b2 = j2y(2:end)-(j2x(2:end).*m2);
        l2 = length(b2);
        
        
        m1m = repmat(m1,[1,l2]);
        b1m = repmat(b1,[1,l2]);
        
        x1l = repmat(j1x(1:end-1),[1,l2]);
        x1u = repmat(j1x(2:end),[1,l2]);
        y1l = repmat(j1y(1:end-1),[1,l2]);
        y1u = repmat(j1y(2:end),[1,l2]);
        
        
        
        m2m = repmat(m2',[l1,1]);
        b2m = repmat(b2',[l1,1]);
        
        x2l = repmat([j2x(1:end-1)]',[l1,1]);
        x2u = repmat([j2x(2:end)]',[l1,1]);
        y2l = repmat([j2y(1:end-1)]',[l1,1]);
        y2u = repmat([j2y(2:end)]',[l1,1]);
 
        
        xi = (b2m-b1m)./(m1m-m2m);
        yi = m2m.*xi+b2m;

        dM1l = sqrt((xi-x1l).^2+(yi-y1l).^2);
        dM1u = sqrt((xi-x1u).^2+(yi-y1u).^2);
        dM1t = sqrt((x1l-x1u).^2+(y1l-y1u).^2);
        
        dM2l = sqrt((xi-x2l).^2+(yi-y2l).^2);
        dM2u = sqrt((xi-x2u).^2+(yi-y2u).^2);
        dM2t = sqrt((x2l-x2u).^2+(y2l-y2u).^2);
        
        elL = dM1l<dM1t;
        e1U = dM1u<dM1t;
        logi1 = logical(elL.*e1U);
        
        e2L = dM2l<dM2t;
        e2U = dM2u<dM2t;
        logi2 = logical(e2L.*e2U);
        
        logiT = logical(logi1.*logi2);
        xI = xi(logiT);
        yI = yi(logiT);
        if isempty(xI)==0
            xI = xI(1);
            yI = yI(1);
            m1i = m1m(logiT);
            m2i = m2m(logiT);
            dA = abs(atand(m2i)-atand(m1i));
            d2A = [dA,180-dA];
            d2A = d2A(1,:);
            diffA = [diffA,min(d2A)];
            count = count+1;
        end
        
        intPts = [intPts;[xI,yI]];
        
        
    end
    i1
end

hold on
plot(intPts(:,1),intPts(:,2),'r.','markersize',12)
axis equal
savePDFfunction(intFig,'figures/intersections')
totalints = length(intPts(:,1))
save('output/results','totalints','-append')




