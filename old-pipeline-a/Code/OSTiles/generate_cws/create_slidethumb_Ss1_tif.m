function create_slidethumb_Ss1_tif(file_name, input_dir, output_dir, size_im, rescale)

    I = imread(fullfile(input_dir, file_name), ...
        'PixelRegion', ...
        {[0 round(16*rescale) size_im{2}], [0 round(16*rescale) size_im{1}]});
    imwrite(I, fullfile(output_dir, 'Ss1.jpg'));
    scale_h = int64(size_im{1}) / 1024;
    thumbnail_height = int64(size_im{2} / scale_h);
    Ir = imresize(I, [thumbnail_height, 1024]);
    imwrite(Ir, fullfile(output_dir, 'SlideThumb.jpg'));
    
end
