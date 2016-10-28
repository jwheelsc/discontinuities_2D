jset = []

for ang = 1:length(thetaA)

    theta = num2str(thetaA(ang))

    np = []
    %%% this is a .mat file with a variable called set_int (joint set
    %%% intersection), which is a call array, and a variable containing line_length
    %%%. There is a cell for each
    %%% scanline, and within that cell contains the coordinates of where
    %%% the scanline of a given angle (theta) intersects a joint set (j)
    load(['output/sl_pts_' num2str(theta) '_allSets_' hS '.mat'])  ;

    t_dist_bwp = [];
    for i = 1:length(set_int)

        %%% in this section, i reorder the points to compute the spacing
        %%% between consecutive points
        if isempty(set_int{i})==0
            scat_jset = set_int{i};
            [dv,ia] = sort(scat_jset(:,1));
            jset = scat_jset(ia,:);        
            %%% then compute the distance between points
            dif1 = jset(2:end,:)-jset(1:end-1,:);
            dist_bwp = sqrt(sum(dif1.*dif1,2));
            %%% i create a massive cell where the distance between points is
            %%% appended onto the next scanline
            t_dist_bwp = [t_dist_bwp;dist_bwp];
            %%% here are the number of points for the egiven scanline
            np(i) = length(set_int{i});
        else
            np(i) = 0        
        end
    end

    % and here I have to scale it
    t_dist_bwp1 = t_dist_bwp*msfc;
    %%% compute a few stats
    spc_mean = mean(t_dist_bwp1);
    spc_std = std(t_dist_bwp1);
    fq_std(ang) = 1./spc_std; 
    %%% here im saying that the frequncy is the inverse of the mean
    %%% spacing
    fq(ang) = 1/spc_mean;
    %%% alternatively, we can compute a frequency based on the mean of the
    %%% number of points for a given line length (scaled)
%     m_fq(ang) = mean(np./(line_length*msfc));
    %%% or the total number of points by the total line length
    m_fq(ang) = sum(np)./(sum(line_length)*msfc);


end

mean_fq = mean(m_fq);

freqScanFig = figure('units','normalized','outerposition',[0 0 1 1])

fs2 = 12
    h1 = plot(thetaA,fq,'r-o')
        mxy = max(m_fq);
        el = find(m_fq==mxy);
        mxx = thetaA(el);
%         text(mxx,mxy,num2str(mxy),'fontsize',fs2);
        
        mny = min(m_fq);
        el = find(m_fq==mny);
        mnx = thetaA(el);
%         text(mnx,mny,num2str(mny),'fontsize',fs2);
    hold on
%     h1a = plot(thetaA,fq,'r--o')
        my = max(fq);
        el = find(fq==my);
        mx = thetaA(el);
%         text(mx,my,num2str(my),'fontsize',fs2)
    
    text(0.7,0.1,['mean = ' num2str(mean_fq)],'units','normalized','fontsize',12)
    ylabel('Joint frequency (\lambda)')
    xlabel('Scanline angle (\theta)')
    set(gca,'fontsize',16)
    grid on
%     legend([h1 ], {'mean spacing^{-1}'},...
%         'location','southwest','fontsize',12);
%     
savePDFfunction(freqScanFig,'figures/scanline_angle')
save(['output/results_' hS '.mat'],'mxx','mxy','mnx','mny','mean_fq',...
    'thetaA','fq','m_fq','fq_std')

    
