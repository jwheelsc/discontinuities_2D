
clear all
close all

[dat, written] = xlsread('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',1,'A1:AN102');
vars = written(:,1);
plotOn = logical(dat(strcmp(vars,'plot?'),:));
elLi = num2str(find(strcmp(vars,'rock type')));
elGt = find(strcmp(vars,'surge type'));
elRt = find(strcmp(vars,'group_rk'));
el4g = find(strcmp(vars,'group_4'));


imTextA =  {'Glacier 01-9049','Glacier 01-9228','Glacier 01-0119',...
    'Glacier 02-0413-hr','Glacier 02-0413-lr','Glacier 02-0413-mr',...
    'Glacier 02-0417','Glacier 04-0905','Glacier 05-1103','Glacier 06-1259',...
    'Glacier 07-1343','Glacier 08-1514','Glacier 09-0071','Glacier 11-0273',...
    'Glacier 14-0305','Glacier 14-0231','Glacier 15-0448','Glacier 16-0538',...
    'Glacier 16-0538-b','Glacier 17-0632','Glacier 18-0259','Glacier 19-0519',...
    'Glacier 20-0794'}

glLabsA = {'1a','1b','1c','2_{hr}','2_{lr}','2_{mr}','2c','4','5','6','7','8','9','11','14a','14b','15','16','16b','17','18','19','20'}
iA = [25 23 24 27 26 30 4 21 5 6 20 19 7 8 10 9 11 12 29 15 16 17 18]
cellNA = [{'E','G','I','L','M','N','O','Q','R','S','T','U','V','X',...
    'Z','AA','AC','AD','AG','AH','AI','AJ','AL'}]


hS = num2str(40)

% for iii = 1:length(iA)

figure
% for iii = 1:length(glLabsA)
iii = find(strcmp(glLabsA,'19'))
 
    ii = iA(iii)
    cellN = cellNA(iii)
    [folder, subFolder, imgNum, setIn, imSave, msfc, ws, ol] = whatFolder(ii)
    folderStr = [folder subFolder setIn]
    load(folderStr)    

    cellRange = [cellN{1} num2str(elGt)  ':' cellN{1} num2str(elGt)]
    glType = xlsread('D:\Field_data\2013\Summer\Geotech\outcrop_disctontinuity.xlsx',1,cellRange)
    data = load([folder subFolder 'results_' hS '.mat'])
    minEl = find(data.fq == min(data.fq))

    x = data.thetaA
%     a = [[minEl:length(x)],[1:minEl-1]]
%     y = data.fq(a)
    y = data.fq

    if glType == 1
       mc = [1 0 0]
    elseif glType ==2 
       mc = [0 0 1]
    end

%     close all
%     figure()

% Aarr = max(data.fq)/min(data.fq)
maxEl = find(data.fq == max(data.fq))
diffA = (maxEl - minEl)*5
   
% close all
figure
plot(x,y,'r+-')
hold on
plot(x+360,y,'m+-')
return


%% here where you can move the data around and explore the data

el1 = find(data.thetaA == 91)
el2 = find(data.thetaA == 176)
el3 = find(data.thetaA == 1)
el4 = find(data.thetaA == 86)

el = [[el1:el2],[el3:el4]]

figure()
plot([[1:5:176],[1:5:176]+180],[data.fq(el),data.fq(el)],'b+-')
ylim([0 12])
grid on














