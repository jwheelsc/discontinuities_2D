function draw_line_function(source,userdata, callbackdata)

load('output\setsFile.mat');

loops = 'yes'
save('output\looping.mat','loops')

count = 1;
while count < 500
    
    if strcmp(loops,'yes')
        h = imfreehand;
        lin = h.getPosition;
    end
    if strcmp(loops,'no')
        lin = [0,0]
    end
    
    if length(lin(:,1))<2
        return
    end
    if lin(1,1)>lin(end,1)
        lin = lin(end:-1:1,:);
    end
    allSets{end+1}= lin(:,:);
    save('output\setsFile.mat','allSets','-append');
    count = count+1; 
    
    load('output\looping.mat')
    
    load('output\setNum.mat')
    load('output\setsFile.mat')
    metaDat = [metaDat,setNumber]
    save('setsFile.mat','metaDat')
    
end

