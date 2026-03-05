function savegif(filename,ims,fps)

    disp(['saving ', filename])
    
    for i = 1:length(ims)
        [A,map] = rgb2ind(ims{i},256); % convert to saveable format
        if i==1
            imwrite(A,map,filename,"gif",LoopCount=0,DelayTime = 1/fps)
        else
            imwrite(A,map,filename,"gif",WriteMode='append',DelayTime = 1/fps)
        end
    end
    disp([filename, ' saved'])

end

