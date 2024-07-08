function CreateMaskTiles(ImageTilePath, MaskTilePath, Ext)
%CREATEMASKTILES Summary of this function goes here
%   Detailed explanation goes here
    fprintf('Entered function CreateMaskTiles in matlab\n');
    if nargin < 3
        Ext = 'jpg';
    end

    fprintf(ImageTilePath);
    fprintf('\n');
    fprintf(MaskTilePath);
    fprintf('\n');
    fprintf(Ext);
    fprintf('\n');
    

    imageTileFiles = dir(fullfile(ImageTilePath, ['Da*.' Ext]));
    
    if ~isfolder(MaskTilePath)
        mkdir(MaskTilePath);
    end

    parfor i=1:length(imageTileFiles)
        [~, fName, ~] = fileparts(imageTileFiles(i).name);
        G = rgb2gray(imread(fullfile(imageTileFiles(i).folder, imageTileFiles(i).name)));
        
        C = bwconncomp(entropyfilt(G)>3.5);
        
        A = cellfun(@numel, C.PixelIdxList);
        V = cellfun(@(x) median(G(x)), C.PixelIdxList);
        
        goodPixels = cat(1, C.PixelIdxList{(A > 5000) & (V < 225)});
        
        B = false(size(G));
        B(goodPixels) = true;
        
        if any(B(:))
            imwrite(B, fullfile(MaskTilePath, [fName '.png']));
        end
    end
end