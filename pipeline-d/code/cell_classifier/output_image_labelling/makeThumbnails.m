unction makeThumbnails(fPath, filePattern, inFolder, outFolder)
    if nargin < 2
        filePattern = '*BigDot.tif';
    end

    if nargin < 3
        inFolder = 'tif';
    end

    if nargin < 4
        outFolder = 'thumbnails';
    end

    outFolder = fullfile(fPath, outFolder);

    if ~isfolder(outFolder)
        mkdir(outFolder)
    end

    files = dir(fullfile(fPath, inFolder, filePattern));

    for i=1:length(files)
        [~, fName, ~] = fileparts(files(i).name);

        outfile = fullfile(outFolder, [fName '_Thumbnail.png']);

        if ~isfile(outfile)
            infile = fullfile(files(i).folder, files(i).name);
            info = imfinfo(infile);
            I = imread(infile, 'PixelRegion', {[1 32 info.Height], [1 32 info.Width]});
            imwrite(I, outfile);
        end
    end
end

