fDist = figure(2)

%%% here you can chnage the number of bins
bins = 60;

fs = 16;

SN = allSets;
    
d = []
for i = 1:length(SN)
    lin = SN{i};
    diff = lin(2:end,:)-lin(1:end-1,:);
    d(i) = sum(sqrt((diff(:,1).^2)+(diff(:,2).^2)));
end
d_sc1 = d*msfc;
h = histogram(d_sc1,bins,'normalization','pdf');
text(0.5,0.7,['mean = ' num2str(mean(d_sc1)) 'm'],'units','normalized','fontsize',fs)
grid on
xlabel('trace length (m)','fontsize',fs)
ylabel(['probability'],'fontsize',fs)
xlim([0 2]);
xl = get(gca,'xlim');
mean_l = mean(d_sc1(d_sc1>0));
std_l = std(d_sc1(d_sc1>0));
lambda = mean_l^-1;
xx = linspace(xl(1),xl(2),100);
yy = lambda*exp(-lambda*xx);
hold on 
h1 = plot(xx,yy,'r','linewidth',2);
lambdahat = lognfit(d_sc1(d_sc1>0));
yy2 = lognpdf(xx,lambdahat(1),lambdahat(2));
hold on
h2 = plot(xx,yy2,'b','linewidth',2);
set(gca,'fontsize',fs);
hold on
h3 = plot([mean_l mean_l],get(gca,'ylim'),'k');

dX = quantile(d_sc1,[0.25,0.5,0.75]);
hold on
h4 = plot([dX(1) dX(1)],get(gca,'ylim'),'b--','linewidth',1);
hold on
h5 = plot([dX(2) dX(2)],get(gca,'ylim'),'r--','linewidth',1);
hold on
h6 = plot([dX(3) dX(3)],get(gca,'ylim'),'m--','linewidth',1);

legend([h1 h2 h3 h4 h5 h6], {'negative exponential','lognormal','mean','D_{25}','median (D_{50})','D_{75}'},'location','southeast','fontsize',12);

%% this is a section to get the total length of a joint set and the number of joints, run the first two sections
SN = allSets;
for i = 1:length(SN)
    lin = SN{i};
    diff = lin(2:end,:)-lin(1:end-1,:);
    d(i) = sum(sqrt((diff(:,1).^2)+(diff(:,2).^2)));
end
sum_length = sum(d*msfc);
num_joints = length(SN); 

save('output/results.mat','mean_l','std_l','sum_length','num_joints','dX','-append')
savePDFfunction(fDist,'figures/length_distribution')
    
    

