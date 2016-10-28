%% in this section you can find the number of joint sets that intersect the edges of the domain

edgeFig = figure(1)
critical_d = 0.1/msfc

for i = 1:length(allSets)
    hold on
    p = allSets{i};
    ph(i)=plot(p(:,1)',p(:,2)','k-','linewidth',1);
end


%%
SN = allSets
%%% left edge
count = 1
jL = []
for i = 1:length(SN);
    jnt = SN{i};    
    el = find(abs(jnt(:,1)-minx)<critical_d);
    if isempty(el)==0
        jL(count) = i
        count = count+1;
        hold on
        plot(jnt(:,1),jnt(:,2),'b.','markersize',10)
    end
end

%%% right edge
count = 1;
jR = [];
for i = 1:length(SN);
    jnt = SN{i};    
    el = find(abs(jnt(:,1)-maxx)<critical_d);
    if isempty(el)==0
        jR(count) = i;
        count = count+1;        
        hold on
        plot(jnt(:,1),jnt(:,2),'b.','markersize',10)
    end
end

%%% upper edge
count = 1;
jU = [];
for i = 1:length(SN)
    jnt = SN{i};    
    el = find(abs(jnt(:,2)-maxy)<critical_d);
    if isempty(el)==0
        jU(count) = i;
        count = count+1;
        hold on
        plot(jnt(:,1),jnt(:,2),'b.','markersize',10)
    end
end

%%% lower edge
count = 1;
jLw = [];
for i = 1:length(SN)
    jnt = SN{i};    
    el = find(abs(jnt(:,2)-miny)<critical_d);
    if isempty(el)==0
        jLw(count) = i;
        count = count+1;
        hold on
        plot(jnt(:,1),jnt(:,2),'b.','markersize',10);
    end
    
end

ljLw = length(jLw);
ljR = length(jR);
ljU = length(jU);
ljL = length(jL);

ljT = ljLw+ljR+ljU+ljL;

etf = ([ljLw,ljR,ljU,ljL,ljT]'/length(allSets))*100;
et = [ljLw,ljR,ljU,ljL,ljT]';
set(gca,'Ydir','reverse')


save('output\results.mat','etf','et','-append')
savePDFfunction(edgeFig,'figures/touching_edges')