function WriteAnnotations(ImageNamePattern, DetectionPath, TilePath, OutPath, ColourCodeFile, AnnotationSize, OverWrite)
    if nargin < 6
        AnnotationSize = 6;
    end
    
    if nargin < 7
        OverWrite = false;
    end

    disp('Logging MatLab file path');
    disp(ColourCodeFile);
    fid = fopen(ColourCodeFile);
    colourCodes=textscan(fid, '%s %s %*[^\n]', 'Delimiter', ' ');
    fclose(fid);
    
    colourCodes = cat(2, colourCodes{:});

    labelNames = colourCodes(:, 2);
    colourCodes = colourCodes(:, 1);

    disp('Matlab output labels and colours:');    
    disp(labelNames);
    disp(colourCodes);
        
    parfor i = 1:length(colourCodes)
        colourCode = colourCodes{i};
        labelName = labelNames{i};
        disp('Matlab output label and colour:');
        disp(labelName);
        disp(colourCode);
        
        if strcmp(labelNames{i}, 'unknown')
            labelColours{i} = [];
        else            
            % labelColours{i} = (hex2dec({colourCode(1:2), colourCode(3:4), colourCode(5:6)}))./255;
            labelColours{i} = (i/length(colourCodes))*255; 
        end
    end
    
    labelMap = containers.Map(labelNames, labelColours);

    TilePath = dir(fullfile(TilePath, '/'));
    TilePath = TilePath(1).folder;
    
    tileFiles = dir(fullfile(TilePath, ImageNamePattern, 'Da*.jpg'));
    csvFiles = dir(fullfile(DetectionPath, ImageNamePattern, 'Da*.csv'));

    disp('Matlab input tile path:');
    disp(fullfile(TilePath, ImageNamePattern, 'Da*.jpg'));    
    disp('Matlab input tile files:');
    disp(tileFiles);
    disp('Matlab input csv path:');
    disp(fullfile(DetectionPath, ImageNamePattern, 'Da*.jpg'));    
    disp('Matlab input csv files:');
    disp(csvFiles);

    if isempty(csvFiles)
        error('No CSV Files Found!');
    else
        outFolders = unique({tileFiles.folder});
    
        disp("Making output directories");
        for i = 1:length(outFolders)
            dirToMake = fullfile(OutPath, outFolders{i}((length(TilePath)+1):end));
            mkdir(dirToMake);            
            fprintf('%d Output directory created: %s\n', i, dirToMake);
        end

        parfor i = 1:length(tileFiles)
            disp(i);
            disp(tileFiles(i).name);
            [~, TileName, ~] = fileparts(tileFiles(i).name);
            currTileFile = fullfile(tileFiles(i).folder, tileFiles(i).name);
            
            currCSVFile = fullfile(DetectionPath, tileFiles(i).folder((length(TilePath)+1):end), [TileName '.csv']);
            currOutTileFile = fullfile(OutPath, tileFiles(i).folder((length(TilePath)+1):end), [TileName '.jpg']);

            if OverWrite || ~(exist(currOutTileFile, 'file'))
                try
                    fprintf('Annotating tile for: %s\n', currTileFile);
                    annotatedImage = AnnotateDetections(currCSVFile, currTileFile, labelMap, AnnotationSize);
                    imwrite(annotatedImage, currOutTileFile);
                catch e
                    fprintf('!!! Error annotating tile for: %s\n', currTileFile);
                    disp(currCSVFile)
                    disp(currTileFile)
                    disp(labelMap)
                    disp(AnnotationSize)
                    fprintf('!!! Error message: %s\n', e.message);
                end
            else
                fprintf('Annotated tile already exists for: %s, skipping.\n', currOutTileFile);
            end
        end
    end 
end
