function AnnotatedImage = AnnotateDetections(CSVPath, TilePath, LabelMap, AnnotationSize)
    AnnotatedImage = im2double(imread(TilePath)).^0.3;

    disp('Logging MatLab file path');
    disp(CSVPath);
    fid = fopen(CSVPath);
    
    if fid ~= -1
        CSV=textscan(fid, '%s %s %s\n', 'Delimiter', ',', 'EndOfLine', '\n');
        fclose(fid);
            
        labels = CSV{1}(2:end);
        disp(labels);
            
        X = cellfun(@str2num, CSV{2}(2:end));
        Y = cellfun(@str2num, CSV{3}(2:end));
        %unique(labels)
        %keys(LabelMap)
        cellTypes = sort(intersect(unique(labels), keys(LabelMap)));
        cellTypes = cellTypes(end:-1:1);

        disp(cellTypes);

        disp(length(cellTypes));
    
    
        for i=1:length(cellTypes)
            disp("Entering loop -----");
            disp(i);
            disp(length(cellTypes));
            disp(cellTypes(i));
            disp(LabelMap)
            disp("----");
            colour = LabelMap(cellTypes{i});
            disp(colour);
        
            if ~isempty(colour)
                isCellType = strcmp(labels, cellTypes{i});
                disp("Annotate image 1...");
                disp(isCellType);
                disp(colour);
                disp(AnnotationSize);
                disp(X(isCellType));
                disp(Y(isCellType));
                disp("Annotate image 2...");
                AnnotatedImage = annotate_image_with_class(AnnotatedImage, [X(isCellType), Y(isCellType)], colour, AnnotationSize);
                disp("...annotated image");
            end
        end
    end
end

