function CreateMaskTilesBatch(TilesFolder, MasksFolder, Method, varargin)
%CREATEMASKTILEBATCH Summary of this function goes here
%   Detailed explanation goes here
    fprintf('Params entered to matlab\n');
	fprintf(TilesFolder);
	fprintf('\n');
	fprintf(MasksFolder);
	fprintf('\n');
	fprintf(Method);
	fprintf('\n');	
    fprintf(varargin);
	fprintf('\n');	
	if nargin < 3
        Method = 'E';
        varargin = {};
    end

    files = dir(TilesFolder);
    files = files(~ismember({files.name}, {'.', '..'}));
    files = files([files.isdir]);

    switch Method
        case 'E'
			fprintf('case E');
			fprintf('\n');
            maskTileFun = @(x, y) CreateMaskTilesEntropy(x, y, varargin{:});
        case 'T'
			fprintf('case T');
			fprintf('\n');
            maskTileFun = @(x, y) CreateMaskTilesThreshold(x, y, varargin{:});
        otherwise
			fprintf('case other');
			fprintf('\n');
            error(['Mask tile method "' Method '" is not recognised.']);
    end
    
    for i=1:length(files)
        InFolder = fullfile(files(i).folder, files(i).name);		
        OutFolder = fullfile(MasksFolder, files(i).name);        		
		fprintf(InFolder);
		fprintf('\n');
		fprintf(OutFolder);
		fprintf('\n');
        maskTileFun(InFolder, OutFolder);
    end
    fprintf('Completed\n');	
end

