function [] = savePDFfunction(fid, filename)

f1 = fid;

set(f1,'PaperOrientation','landscape');
set(f1,'PaperUnits','normalized');
set(f1,'PaperPosition', [0 0 1 1]);
print(f1,filename,'-dpdf','-r0')


